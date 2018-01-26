unit uOrganize;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ComCtrls, ExtCtrls, ActnList, ImgList,
  StdActns;
const
     C_TEXT_SEPARATOR = '------------------------------';
type
     favorites_file = TextFile;
     TIDE_RefreshMenusProc = procedure (ID: Integer); cdecl;
     TIDE_RefreshProc = procedure; cdecl;
type
  TfOrganize = class(TForm)
    pnl_btns: TPanel;
    pnl_structure: TPanel;
    tv: TTreeView;
    pnl_editor: TPanel;
    lbl_script_file: TLabel;
    edt_script_file: TEdit;
    btn_script_select: TSpeedButton;
    il1: TImageList;
    actlst1: TActionList;
    btn_add: TSpeedButton;
    btn_sep: TSpeedButton;
    btn_remove: TSpeedButton;
    btn_grp: TSpeedButton;
    btn_export: TSpeedButton;
    btn_import: TSpeedButton;
    act_settings: TAction;
    act_add_script: TAction;
    act_add_group: TAction;
    act_separator: TAction;
    act_remove: TAction;
    act_export: TAction;
    act_open_settings: TAction;
    lbl_open_in: TLabel;
    cbb_open_in: TComboBox;
    act_apply: TAction;
    il_tv: TImageList;
    act_change_script: TAction;
    flpn_script: TOpenDialog;
    act_save_and_close: TAction;
    dlgSave_settings: TSaveDialog;
    dlgOpen_settings: TOpenDialog;
    tmr_show: TTimer;
    chk_use_rel_path: TCheckBox;
    lbl1: TLabel;
    edtMenuName: TEdit;
    lbl2: TLabel;
    cbb_after_menu: TComboBox;
    btn_save: TSpeedButton;
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure tvChanging(Sender: TObject; Node: TTreeNode;
      var AllowChange: Boolean);
    procedure tvChange(Sender: TObject; Node: TTreeNode);
    procedure tvDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure tvDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure act_add_groupExecute(Sender: TObject);
    procedure act_add_scriptExecute(Sender: TObject);
    procedure act_separatorExecute(Sender: TObject);
    procedure tvEdited(Sender: TObject; Node: TTreeNode; var S: String);
    procedure tvEditing(Sender: TObject; Node: TTreeNode;
      var AllowEdit: Boolean);
    procedure act_removeExecute(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure act_save_and_closeExecute(Sender: TObject);
    procedure act_change_scriptExecute(Sender: TObject);
    procedure act_open_settingsExecute(Sender: TObject);
    procedure act_exportExecute(Sender: TObject);
    procedure tmr_showTimer(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    { Private declarations }
    ini_file_name: string;
    settings_fn: string;
    has_changes: Boolean;
    is_loading: Boolean;
    procedure save_selected;
    procedure refresh_edit_controls(item_type: Integer);
    procedure Cleanup_tree;
    procedure read_ini_settings;
    function GetRoamingFolderPath: string;
    procedure init_trace;
    procedure write_ini_settings;
  public
    { Public declarations }
    plugin_refresh: TIDE_RefreshMenusProc;
    ide_refresh   : TIDE_RefreshProc;
    plugin_id     : Integer;
    menu_root     : string;
    menu_location : string;
    procedure load_settings(i_file_name: string; i_on_change: Boolean);
    procedure save_settings(i_file_name: string = '');
    procedure populate_cbb_after_menu(menu_layout: PChar);
    procedure add_plsqdev_script(i_script_file: string );
    procedure trace(i_msg : string);
    procedure RefreshEvent(Sender: TObject; const FileName: string);

  end;

var
  fOrganize: TfOrganize;

implementation

uses StrUtils, uObjects, IniFiles, uFileChangeMon;

{$R *.dfm}

var
  ct : TFileThread;


function add_trailing_slash( i_dir  : string): string;
begin
    if copy(i_dir, Length(i_dir), 1) = PathDelim then begin
      result:= i_dir;
    end else begin
      result:= i_dir + PathDelim;
    end;
end;

function TfOrganize.GetRoamingFolderPath: string;
var
  buf  : PAnsiChar;
begin
  GetMem(buf,MAX_PATH);
  ZeroMemory(buf,MAX_PATH);
  Windows.GetEnvironmentVariable('APPDATA', buf,MAX_PATH);
  Result:= buf;
  FreeMem(Buf);

  Result:= add_trailing_slash(Result)+'PLSQL Developer'+ PathDelim;
  if not DirectoryExists(Result) then
      CreateDir(Result);
  Result:= Result + 'Plugins'+ PathDelim;
  if not DirectoryExists(Result) then
      CreateDir(Result);
  Result:= Result + 'favorite_lib'+ PathDelim;
  if not DirectoryExists(Result) then
      CreateDir(Result);
end;

procedure TfOrganize.FormActivate(Sender: TObject);
begin
    btn_script_select.Caption:= '';
end;

procedure TfOrganize.load_settings(i_file_name: string; i_on_change: Boolean);
var
    r: favorites_rec;
    s: string;
    node, group_node: TTreeNode;
    l_file_name: string;
    f: TextFile;
begin
    is_loading:= True;
    Cleanup_tree;
    group_node:= nil;
    if i_file_name = '' then
        l_file_name:= Self.settings_fn
    else
        l_file_name:= i_file_name;

    trace('Load settings from ' + l_file_name);
    if Self.chk_use_rel_path.Checked then
        trace('Use relative patch')
    else
        trace('Do not use relative path');

    if FileExists(Self.settings_fn) then begin
        AssignFile( f, l_file_name);
        Reset(f);
        while not Eof(f) do
        begin
            Readln(f, s);
            r:= favorites_rec.Create;
            r.import_line(s, Self.chk_use_rel_path.Checked, l_file_name);
            if r.item_type = C_ITEM_TYPE_GROUP then begin
                group_node:= tv.Items.AddObject(nil, r.group_desc, r);
                group_node.ImageIndex:= 0;
                group_node.SelectedIndex:= 0;
            end else if r.item_type = C_ITEM_TYPE_GROUP_END then begin
                group_node:= nil;
            end else if r.item_type = C_ITEM_TYPE_SEPARATOR then begin
                if Assigned(group_node) then begin
                    node:= tv.Items.AddChildObject(group_node, C_TEXT_SEPARATOR, r);
                    node.ImageIndex:= 2;
                    node.SelectedIndex:= 2;
                end else begin
                    node:= tv.Items.AddObject(nil, C_TEXT_SEPARATOR, r);
                    node.ImageIndex:= 2;
                    node.SelectedIndex:= 2;
                end;
            end else begin
                if Assigned(group_node) then begin
                    node:= tv.Items.AddChildObject(group_node, r.script_name, r);
                    node.ImageIndex:= 1;
                    node.SelectedIndex:= 1;
                end else begin
                    node:= tv.Items.AddObject(nil, r.script_name, r);
                    node.ImageIndex:= 1;
                    node.SelectedIndex:= 1;
                end;
            end;

        end;
        CloseFile(F);
    end;
    if tv.Items.Count > 0 then
        tv.Selected:= tv.TopItem;
    if not i_on_change then begin
      ct.Terminate;
      ct:= TFileThread.Create(True);
      ct.Dir:= ExtractFileDir( Self.settings_fn );
      ct.OnRefresh:= RefreshEvent;
      ct.Resume;
//      if not ct.Suspended then ct.Suspend;
//      ct.Dir:= ExtractFileDir( Self.settings_fn );
//      if ct.Suspended then
//         ct.Resume;
    end;
    is_loading:= False;

end;

procedure TfOrganize.save_settings(i_file_name: string = '');
var
    f: TextFile;
    rec: favorites_rec;
    s: string;
    root_node: TTreeNode;
    l_file_name: string;
    procedure save_group(Item: TTreeNode);
    var
        i: Integer;
        rec: favorites_rec;
        s: string;
    begin

        for i:= 0 to Item.Count - 1 do begin
            rec:= favorites_rec(Item[i].Data);
            s:= rec.export_line(chk_use_rel_path.Checked, Self.settings_fn);
            Writeln( f, s );
        end;

        rec:= favorites_rec.Create;
        rec.item_type:= C_ITEM_TYPE_GROUP_END;
        s:= rec.export_line(chk_use_rel_path.Checked, Self.settings_fn);
        Writeln( f, s );
        rec.Free;
    end;
begin
    Self.write_ini_settings;

    if i_file_name = '' then
        l_file_name:= Self.settings_fn
    else
        l_file_name:= i_file_name
    ;

    trace('Save script config to '+l_file_name);

    AssignFile( f, l_file_name);
    Rewrite(f);

    root_node:= tv.Items.GetFirstNode;

    while Assigned(root_node) do begin
        rec:= favorites_rec(root_node.Data);
        s:= rec.export_line(chk_use_rel_path.Checked, Self.settings_fn);
        Writeln( f, s );
        if rec.item_type = C_ITEM_TYPE_GROUP then begin
            save_group(root_node);
        end;

        root_node:= root_node.getNextSibling;
    end;


    Flush(f);
    CloseFile(F);

    has_changes:= False;
end;

procedure TfOrganize.populate_cbb_after_menu(
    menu_layout : PChar
);
var
    sl: TStringList;
    i : Integer;
begin
    sl:= TStringList.Create;
    cbb_after_menu.Items.Text:= '';
    sl.Text:= menu_layout;
    for i:= 0 to sl.Count - 1 do begin
      if Copy( sl[i], 1, 1) <> ' ' then
          cbb_after_menu.Items.Add(sl[i]);
    end;
    cbb_after_menu.Text:= Self.menu_location;
end;

procedure TfOrganize.write_ini_settings;
var
    ini          : TIniFile;
    RoamingFolder: string;
begin
    trace('Save plugin settings to '+Self.ini_file_name);
    RoamingFolder:= GetRoamingFolderPath();
    Self.ini_file_name:= RoamingFolder+'favorite_lib.ini';
    Self.menu_root:= edtMenuName.Text;
    Self.menu_location:= cbb_after_menu.Text;
    ini:= TIniFile.Create(Self.ini_file_name);
    ini.WriteString('general', 'library', Self.settings_fn);
    ini.WriteBool('general', 'use_relative_path', Self.chk_use_rel_path.Checked);
    ini.WriteString('general', 'menu_root', Self.menu_root);
    ini.WriteString('general', 'menu_location', Self.menu_location);
    ini.UpdateFile;
    ini.Free;
end;

procedure TfOrganize.read_ini_settings;
var
    ini          : TIniFile;
    RoamingFolder: string;
begin
    trace('Load plugin settings from '+Self.ini_file_name);
    RoamingFolder:= GetRoamingFolderPath();
    Self.ini_file_name:= RoamingFolder+'favorite_lib.ini';
    ini:= TIniFile.Create(Self.ini_file_name);
    Self.settings_fn:= ini.ReadString('general', 'library', RoamingFolder+'favorite_lib.svfav');
    Self.chk_use_rel_path.Checked:= ini.ReadBool('general', 'use_relative_path', False);
    Self.menu_root:= ini.ReadString('general', 'menu_root', 'Favorites');
    Self.menu_location:= ini.ReadString('general', 'menu_location', 'File');
    Self.edtMenuName.Text:= Self.menu_root;
    Self.cbb_after_menu.Text:= Self.menu_location;
    ini.UpdateFile;
    ini.Free;
    Self.write_ini_settings;
end;

procedure TfOrganize.FormCreate(Sender: TObject);
begin
    Self.init_trace;
    has_changes:= False;
    is_loading:= False;
    read_ini_settings;
    tv.Items.Clear;
    ct:= TFileThread.Create(True);
    ct.OnRefresh:= RefreshEvent;
end;

procedure TfOrganize.tvChanging(Sender: TObject; Node: TTreeNode;
  var AllowChange: Boolean);
begin
    save_selected;
end;

procedure TfOrganize.save_selected;
var
    rec: favorites_rec;
begin
    has_changes:= not is_loading;
    if Assigned(tv.Selected) then begin
        rec:= favorites_rec(tv.Selected.Data);
        if rec.item_type = C_ITEM_TYPE_SCRIPT then begin
            rec.script_file:= edt_script_file.Text;
        end;
    end;
end;

procedure TfOrganize.tvChange(Sender: TObject; Node: TTreeNode);
var
    rec: favorites_rec;
begin
    if Assigned(Node) then begin
        rec:= favorites_rec(Node.Data);
        if rec.item_type = C_ITEM_TYPE_GROUP then begin
            refresh_edit_controls(rec.item_type);
        end else begin
            edt_script_file.Text:= rec.script_file;
            refresh_edit_controls(rec.item_type);
        end;
        has_changes:= not is_loading;
    end;
end;

procedure TfOrganize.refresh_edit_controls(item_type: Integer);
begin
    act_change_script.visible:= item_type in [C_ITEM_TYPE_SCRIPT];
    lbl_script_file.visible:= item_type in [C_ITEM_TYPE_SCRIPT];
    edt_script_file.visible:= item_type in [C_ITEM_TYPE_SCRIPT];
    lbl_open_in.visible:= False;//item_type in [C_ITEM_TYPE_SCRIPT];
    cbb_open_in.visible:= False;//item_type in [C_ITEM_TYPE_SCRIPT];
end;

procedure TfOrganize.tvDragOver(Sender, Source: TObject; X, Y: Integer;
  State: TDragState; var Accept: Boolean);
begin
    Accept:= Source is TTreeView;
end;

procedure TfOrganize.tvDragDrop(Sender, Source: TObject; X, Y: Integer);
var
   drop_node, sibling_node: TTreeNode;
   rec_src, rec_drp: favorites_rec;
begin
   drop_node:= tv.GetNodeAt(X, Y);

   if Assigned(drop_node) then begin
       has_changes:= not is_loading;
       rec_src:= favorites_rec(tv.Selected.Data);
       rec_drp:= favorites_rec(drop_node.Data);
       if ( rec_drp.item_type = C_ITEM_TYPE_GROUP ) and ( rec_src.item_type <> C_ITEM_TYPE_GROUP ) then begin
           tv.Selected.MoveTo(drop_node, naAddChildFirst);
       end else if ( rec_drp.item_type = C_ITEM_TYPE_GROUP) and (rec_src.item_type = C_ITEM_TYPE_GROUP) then begin
           if drop_node.Index < tv.Selected.Index then begin
               tv.Selected.MoveTo(drop_node, naInsert);
           end else begin
               sibling_node:= drop_node.getNextSibling;
               if Assigned(sibling_node) then begin
                   tv.Selected.MoveTo(sibling_node, naInsert);
               end else begin
                   tv.Selected.MoveTo(drop_node, naAdd);
               end;
           end;
       end else begin
           if drop_node.Index < tv.Selected.Index then begin
               tv.Selected.MoveTo(drop_node, naInsert);
           end else begin
               sibling_node:= drop_node.getNextSibling;
               if Assigned(sibling_node) then begin
                   tv.Selected.MoveTo(sibling_node, naInsert);
               end else begin
                   tv.Selected.MoveTo(drop_node, naAdd);
               end;
           end;
       end;
   end else begin
      tv.Selected.MoveTo(nil, naAdd);
   end;

end;

procedure TfOrganize.act_add_groupExecute(Sender: TObject);
var
   sibling_node, new_node: TTreeNode;
   rec: favorites_rec;
   group_name: string;
begin
   group_name:= '';
   Self.Visible:= False;
   InputQuery('Enter group name','Name', group_name);
   Self.Visible:= True;
   if group_name <> '' then begin
       has_changes:= not is_loading;
       rec:= favorites_rec.Create;
       rec.item_type:= C_ITEM_TYPE_GROUP;
       rec.group_desc:= group_name;

       if Assigned(tv.Selected) and Assigned(tv.Selected.Parent) then begin
           sibling_node:= tv.Selected.Parent.getNextSibling;
       end else if Assigned(tv.Selected) and not Assigned(tv.Selected.Parent) then begin
           sibling_node:= tv.Selected.getNextSibling;
       end else begin
           sibling_node:= nil;
       end;

       if Assigned(sibling_node) then begin
           new_node:= tv.Items.InsertObject(sibling_node, group_name, rec);
       end else begin
           new_node:= tv.Items.AddObject(nil, group_name, rec);
       end;

       new_node.Selected:= True;

   end;
end;

procedure TfOrganize.act_add_scriptExecute(Sender: TObject);
var
    rec: favorites_rec;
    new_node, next_sibling, selected_parent: TTreeNode;
begin
    tmr_show.Enabled:= False;
    if flpn_script.Execute and ( flpn_script.FileName <> '') then begin
        tmr_show.Enabled:= True;
        has_changes:= not is_loading;
        rec:= favorites_rec.Create;
        rec.item_type:= C_ITEM_TYPE_SCRIPT;
        rec.script_file:= flpn_script.FileName;
        rec.script_name:= ExtractFileName(flpn_script.FileName);
        rec.window_type:= 0;
        if Assigned(tv.Selected)
           and ( favorites_rec(tv.Selected.data).item_type = C_ITEM_TYPE_GROUP )
        then begin
            new_node:= tv.Items.AddChildObject(tv.Selected, rec.script_name, rec);
        end else if not Assigned(tv.Selected) then begin
                new_node:= tv.Items.AddObject(nil, rec.script_name, rec);
        end else begin
            next_sibling:= tv.Selected.getNextSibling;
            selected_parent:= tv.Selected.Parent;
            if Assigned(next_sibling) then begin
                new_node:= tv.Items.InsertObject(next_sibling, rec.script_name, rec);
            end else if Assigned(selected_parent) then begin
                new_node:= tv.Items.AddChildObject(selected_parent, rec.script_name, rec);
            end else begin
                new_node:= tv.Items.AddObject(tv.Selected, rec.script_name, rec);
            end;
        end;

        new_node.ImageIndex:= 1;
        new_node.SelectedIndex:= 1;
        new_node.Selected:= True;
//    end else begin
//        ShowMessage('File select dialog is not executed');
    end;
    tmr_show.Enabled:= True;
end;

procedure TfOrganize.act_separatorExecute(Sender: TObject);
var
    rec: favorites_rec;
    new_node, next_sibling, selected_parent: TTreeNode;
begin
    rec:= favorites_rec.Create;
    rec.item_type:= C_ITEM_TYPE_SEPARATOR;
    rec.script_file:= '';
    rec.script_name:= '';
    rec.window_type:= 0;
    has_changes:= not is_loading;
    if Assigned(tv.Selected)
       and ( favorites_rec(tv.Selected.data).item_type = C_ITEM_TYPE_GROUP )
    then begin
        new_node:= tv.Items.AddChildObject(tv.Selected, C_TEXT_SEPARATOR, rec);
    end else if not Assigned(tv.Selected) then begin
            new_node:= tv.Items.AddObject(nil, C_TEXT_SEPARATOR, rec);
    end else begin
        next_sibling:= tv.Selected.getNextSibling;
        selected_parent:= tv.Selected.Parent;
        if Assigned(next_sibling) then begin
            new_node:= tv.Items.InsertObject(next_sibling, C_TEXT_SEPARATOR, rec);
        end else if Assigned(selected_parent) then begin
            new_node:= tv.Items.AddChildObject(selected_parent, C_TEXT_SEPARATOR, rec);
        end else begin
            new_node:= tv.Items.AddObject(tv.Selected, C_TEXT_SEPARATOR, rec);
        end;
    end;

    new_node.ImageIndex:= 2;
    new_node.SelectedIndex:= 2;
    new_node.Selected:= True;
end;

procedure TfOrganize.tvEdited(Sender: TObject; Node: TTreeNode;
  var S: String);
var
    rec: favorites_rec;
begin
    rec:= favorites_rec(Node.data);
    if rec.item_type = C_ITEM_TYPE_GROUP then
        rec.group_desc:= s
    else if rec.item_type = C_ITEM_TYPE_SCRIPT then
        rec.script_name:= s;
    Node.Text:= S;
end;

procedure TfOrganize.tvEditing(Sender: TObject; Node: TTreeNode;
  var AllowEdit: Boolean);
begin
    AllowEdit:= favorites_rec(Node.data).item_type in [C_ITEM_TYPE_GROUP, C_ITEM_TYPE_SCRIPT];
end;

procedure TfOrganize.act_removeExecute(Sender: TObject);
var
    selected_node: TTreeNode;
begin
    selected_node:= tv.Selected;
    if Assigned(selected_node) and not selected_node.HasChildren then begin
        has_changes:= not is_loading;
        favorites_rec(selected_node.data).Free;
        selected_node.Delete;
    end;

end;

procedure TfOrganize.Cleanup_tree;
var
    i: Integer;
begin
    for i:= 0 to tv.Items.Count - 1 do begin
        favorites_rec(tv.Items[i].Data).Free;
    end;
    tv.Items.Clear;
end;


procedure TfOrganize.FormDestroy(Sender: TObject);
begin
    Cleanup_tree;
    ct.Terminate;
    Self.trace('Plugin stopped');
end;

procedure TfOrganize.add_plsqdev_script(i_script_file: string);
var
    rec: favorites_rec;
    new_node: TTreeNode;
begin
    fOrganize.trace('added script: ' + i_script_file);
    rec:= favorites_rec.Create;
    rec.item_type:= C_ITEM_TYPE_SCRIPT;
    rec.script_file:= i_script_file;
    rec.script_name:= ExtractFileName(i_script_file);
    rec.window_type:= 0;
    new_node:= tv.Items.AddObject(nil, rec.script_name, rec);
    new_node.ImageIndex:= 1;
    new_node.SelectedIndex:= 1;
    save_settings;
end;

procedure TfOrganize.act_save_and_closeExecute(Sender: TObject);
begin
   save_settings;
   Close;
   Self.ModalResult:= mrOk;
end;

procedure TfOrganize.act_change_scriptExecute(Sender: TObject);
var
    rec: favorites_rec;
    node: TTreeNode;
begin
    tmr_show.Enabled:= False;
    Node:= tv.Selected;
    if Assigned(node) then begin
        rec:= favorites_rec(node.Data);
        if flpn_script.Execute and ( flpn_script.FileName <> '') then begin
            has_changes:= not is_loading;
            rec.script_file:= flpn_script.FileName;
            node.Text:= flpn_script.FileName;
        end;
    end;
    tmr_show.Enabled:= True;
end;

procedure TfOrganize.act_open_settingsExecute(Sender: TObject);
begin
   tmr_show.Enabled:= False;
   has_changes:= False;
   dlgOpen_settings.FileName:= Self.settings_fn;
   if dlgOpen_settings.Execute and ( dlgOpen_settings.FileName <> '' ) then begin
      Self.settings_fn:= dlgOpen_settings.FileName;
      load_settings(Self.settings_fn, False);
   end;
   tmr_show.Enabled:= True;
end;

procedure TfOrganize.act_exportExecute(Sender: TObject);
begin
   tmr_show.Enabled:= False;
   dlgSave_settings.FileName:= Self.settings_fn;
   if dlgSave_settings.Execute and (dlgSave_settings.FileName <> '' ) then begin
       save_settings(dlgSave_settings.FileName);
   end;
   tmr_show.Enabled:= True;
end;

procedure TfOrganize.tmr_showTimer(Sender: TObject);
begin
    if Self.Visible then begin
        Self.BringToFront;
    end;
end;

procedure TfOrganize.init_trace;
var
    l_file_name: string;
    f: TextFile;
begin
    l_file_name:= GetRoamingFolderPath()+'favorite_lib.log';
    AssignFile( f, l_file_name);
    Rewrite(f);
    CloseFile(f);
    Self.trace('Log started');
end;

procedure TfOrganize.trace(i_msg: string);
var
    l_file_name: string;
    f: TextFile;
begin
    l_file_name:= GetRoamingFolderPath()+'favorite_lib.log';
    AssignFile( f, l_file_name);
    Append(f);
    Writeln(f, DateTimeToStr(Now()) + ' | ' + i_msg);
    Flush(f);
    CloseFile(f);
end;

procedure TfOrganize.RefreshEvent(Sender: TObject; const FileName: string);
begin
   if FileName = Self.settings_fn then begin
     Self.load_settings('', True);
     if Assigned(@plugin_refresh) then begin
         trace('Start refresh menus on file change');
         plugin_refresh(plugin_id);
         trace('Finish refresh menus on file change');
     end;

   end;
end;

procedure TfOrganize.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
   if (Self.ModalResult <> mrOk) and Self.has_changes then begin
        tmr_show.Enabled:= False;
        CanClose:=
            MessageDlg(
                'Do you want to close without saving your changes'
              , mtConfirmation
              , mbOKCancel
              , 0
            ) = mrOk;
        tmr_show.Enabled:= True;
   end else
       CanClose:= True;

end;

end.
