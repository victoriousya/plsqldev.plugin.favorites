unit uFileChangeMon;

interface

uses
  Windows, Classes, SysUtils;

const

  FILE_NOTIFY_CHANGE = FILE_NOTIFY_CHANGE_FILE_NAME or FILE_NOTIFY_CHANGE_DIR_NAME or
  FILE_NOTIFY_CHANGE_ATTRIBUTES or FILE_NOTIFY_CHANGE_SIZE or
  FILE_NOTIFY_CHANGE_LAST_WRITE or FILE_NOTIFY_CHANGE_LAST_ACCESS or
  FILE_NOTIFY_CHANGE_CREATION or FILE_NOTIFY_CHANGE_SECURITY;

type

  TCreateEvent  = procedure (Sender: TObject; const FileName: string) of object;
  TDeleteEvent  = procedure (Sender: TObject; const FileName: string) of object;
  TRefreshEvent = procedure (Sender: TObject; const FileName: string) of object;
  TRenameEvent  = procedure (Sender: TObject; const FileName: string; const NewFileName: string) of object;

  PFileNotifyInformation = ^TFileNotifyInformation;
  TFileNotifyInformation = packed record
    NextEntryOffset: dword;
    Action: dword;
    FileNameLength: dword;
    FileName: WideChar;
  end;

  TFileThread = class(TThread)
  private
    FOnCreate: TCreateEvent;
    FOnDelete: TDeleteEvent;
    FOnRefresh: TRefreshEvent;
    FOnRename: TRenameEvent;
    FOnChange: TNotifyEvent;
    FDir: string;
    FChild: Boolean;
    FSync: Boolean;
  protected
    procedure Stack; virtual;
    procedure Execute; override;
    procedure DoCreate(const FileName: string);
    procedure DoDelete(const FileName: string);
    procedure DoRefresh(const FileName: string);
    procedure DoRename(const FileName: string; const NewFileName: string);
    procedure DoChange; virtual;
  public
    constructor Create(CreateSuspended: Boolean);
    property  OnCreate: TCreateEvent read FOnCreate write FOnCreate;
    property  OnDelete: TDeleteEvent read FOnDelete write FOnDelete;
    property  OnRefresh: TRefreshEvent read FOnRefresh write FOnRefresh;
    property  OnRename: TRenameEvent read FOnRename write FOnRename;
    property  OnChange: TNotifyEvent read FOnChange write FOnChange;
    property  Dir: string read FDir write FDir;
    property  Child: Boolean read FChild write FChild;
    property  Sync: Boolean read FSync write FSync;
  end;

  TFileChange = class(TFileThread);

implementation

function add_trailing_slash( i_dir  : string): string;
begin
    if copy(i_dir, Length(i_dir), 1) = PathDelim then begin
      result:= i_dir;
    end else begin
      result:= i_dir + PathDelim;
    end;
end;

constructor TFileThread.Create(CreateSuspended: Boolean);
begin
  FDir := '';
  FChild := false;
  FSync := false;
  inherited Create(CreateSuspended);
end;

procedure TFileThread.Stack;
var
  hDir, cbReturn: dword;
  lpBuf: pointer;
  Ptr: PFileNotifyInformation;
  FileName: PWideChar;
  OldName: WideString;
const
  BUF_SIZE = 256;
begin
  if FDir = '' then Exit;
  hDir:=CreateFile(PChar(add_trailing_slash(FDir)), GENERIC_READ, FILE_SHARE_READ or FILE_SHARE_WRITE
  or FILE_SHARE_DELETE, nil, OPEN_EXISTING, FILE_FLAG_BACKUP_SEMANTICS, 0);
  if hDir = INVALID_HANDLE_VALUE then Exit;
  GetMem(lpBuf, BUF_SIZE);
  ZeroMemory(lpBuf, BUF_SIZE);
  if(ReadDirectoryChangesW(hDir, lpBuf, BUF_SIZE, FChild, FILE_NOTIFY_CHANGE, @cbReturn, nil, nil))
  or (cbReturn <> 0) then
  begin
  Ptr := lpBuf;
  OldName :='';

  repeat
    GetMem(FileName,Ptr^.FileNameLength+2);
    ZeroMemory(FileName,Ptr^.FileNameLength+2);
    LstrcpynW(FileName,addr(Ptr^.FileName),Ptr.FileNameLength div 2+1);
    case Ptr.Action of
          FILE_ACTION_ADDED: DoCreate(add_trailing_slash(FDir)+FileName);
          FILE_ACTION_REMOVED: DoDelete(add_trailing_slash(FDir)+FileName);
          FILE_ACTION_MODIFIED: DoRefresh(add_trailing_slash(FDir)+FileName);
          FILE_ACTION_RENAMED_OLD_NAME: OldName := FileName;
          FILE_ACTION_RENAMED_NEW_NAME: DoRename(add_trailing_slash(FDir)+OldName, add_trailing_slash(FDir)+FileName);
    end;
    FreeMem(FileName);
    if Ptr^.NextEntryOffset = 0 then break else
    Inc(Cardinal(Ptr),Ptr^.NextEntryOffset);
  until false;
  end;
  FreeMem(lpBuf);
  CloseHandle(hDir);
end;

procedure TFileThread.Execute;
begin
  while not Terminated do
  begin
    if FSync then Synchronize(Stack) else Stack;
    DoChange;
  end;
end;

procedure TFileThread.DoChange;
begin
  if Assigned(FOnChange) then FOnChange(Self);
end;

procedure TFileThread.DoCreate(const FileName: string);
begin
  if Assigned(FOnCreate) then FOnCreate(Self, FileName);
end;

procedure TFileThread.DoDelete(const FileName: string);
begin
  if Assigned(FOnDelete) then FOnDelete(Self, FileName);
end;

procedure TFileThread.DoRefresh(const FileName: string);
begin
  if Assigned(FOnRefresh) then FOnRefresh(Self, FileName);
end;

procedure TFileThread.DoRename(const FileName: string; const NewFileName: string);
begin
  if Assigned(FOnRename) then FOnRename(Self, FileName, NewFileName);
end;

end.
