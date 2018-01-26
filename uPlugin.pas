unit uPlugin;

interface

uses Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls, uOrganize, uObjects;

const // Description of this Plug-In (as displayed in Plug-In configuration dialog)
  Plugin_Desc = 'Favorites by cathegory 1.0';
var
  fOrganize: TfOrganize = nil;
  PlugInID: Integer;
  g_last_requested_group: string;

var // Declaration of PL/SQL Developer callback functions
//  SYS_Version: function: Integer; cdecl;
//  SYS_Registry: function: PChar; cdecl;
//  SYS_RootDir: function: PChar; cdecl;
//  SYS_OracleHome: function: PChar; cdecl;
//
//  IDE_MenuState: procedure(ID, Index: Integer; Enabled: Bool); cdecl;
//  IDE_Connected: function: Bool; cdecl;
//  IDE_GetConnectionInfo: procedure(var Username, Password, Database: PChar); cdecl;
//  IDE_GetBrowserInfo: procedure(var ObjectType, ObjectOwner, ObjectName: PChar); cdecl;
//  IDE_GetWindowType: function: Integer; cdecl;
//  IDE_GetAppHandle: function: Integer; cdecl;
//  IDE_GetWindowHandle: function: Integer; cdecl;
//  IDE_GetClientHandle: function: Integer; cdecl;
//  IDE_GetChildHandle: function: Integer; cdecl;
//
//  IDE_CreateWindow: procedure(WindowType: Integer; Text: PChar; Execute: Bool); cdecl;
  IDE_OpenFile: function(WindowType: Integer; Filename: PChar): Bool; cdecl;
//  IDE_SaveFile: function: Bool; cdecl;
  IDE_Filename: function: PChar; cdecl;
//  IDE_CloseFile: procedure; cdecl;
//  IDE_SetReadOnly: procedure(ReadOnly: Bool); cdecl;
//
//  IDE_GetText: function: PChar; cdecl;
//  IDE_GetSelectedText: function: PChar; cdecl;
//  IDE_GetCursorWord: function: PChar; cdecl;
//  IDE_GetEditorHandle: function: Integer; cdecl;
//
//  SQL_Execute: function(SQL: PChar): Integer; cdecl;
//  SQL_FieldCount: function: Integer; cdecl;
//  SQL_Eof: function: Bool; cdecl;
//  SQL_Next: function: Integer; cdecl;
//  SQL_Field: function(Field: Integer): PChar; cdecl;
//  SQL_FieldName: function(Field: Integer): PChar; cdecl;
//  SQL_FieldIndex: function(Name: PChar): Integer; cdecl;
//  SQL_FieldType: function(Field: Integer): Integer; cdecl;
    IDE_RefreshMenus: procedure (ID: Integer); cdecl;
    IDE_SetMenuName: procedure(ID, Index: Integer; Name: PChar); cdecl;
    IDE_SetMenuVisible: procedure(ID, Index: Integer; Enabled: Bool); cdecl;
    IDE_GetMenulayout: function: PChar; cdecl;
    IDE_Refresh: procedure; cdecl;

implementation

// Plug-In identification, a unique identifier is received and
// the description is returned
function IdentifyPlugIn(ID: Integer): PChar;  cdecl;
begin
  PlugInID := ID;
  Result := Plugin_Desc;
end;

// Registration of PL/SQL Developer callback functions
procedure RegisterCallback(Index: Integer; Addr: Pointer); cdecl;
begin
  case Index of
//     1 : @SYS_Version := Addr;
//     2 : @SYS_Registry := Addr;
//     3 : @SYS_RootDir := Addr;
//     4 : @SYS_OracleHome := Addr;
//    10 : @IDE_MenuState := Addr;
//    11 : @IDE_Connected := Addr;
//    12 : @IDE_GetConnectionInfo := Addr;
//    13 : @IDE_GetBrowserInfo := Addr;
//    14 : @IDE_GetWindowType := Addr;
//    15 : @IDE_GetAppHandle := Addr;
//    16 : @IDE_GetWindowHandle := Addr;
//    17 : @IDE_GetClientHandle := Addr;
//    18 : @IDE_GetChildHandle := Addr;
    19 : begin
              @IDE_Refresh := Addr;
              @fOrganize.ide_refresh:= Addr;
         end;
//    20 : @IDE_CreateWindow := Addr;
    21 : @IDE_OpenFile := Addr;
//    22 : @IDE_SaveFile := Addr;
    23 : @IDE_Filename := Addr;
//    24 : @IDE_CloseFile := Addr;
//    25 : @IDE_SetReadOnly := Addr;
//    30 : @IDE_GetText := Addr;
//    31 : @IDE_GetSelectedText := Addr;
//    32 : @IDE_GetCursorWord := Addr;
//    33 : @IDE_GetEditorHandle := Addr;
//    40 : @SQL_Execute := Addr;
//    41 : @SQL_FieldCount := Addr;
//    42 : @SQL_Eof := Addr;
//    43 : @SQL_Next := Addr;
//    44 : @SQL_Field := Addr;
//    45 : @SQL_FieldName := Addr;
//    46 : @SQL_FieldIndex := Addr;
//    47 : @SQL_FieldType := Addr;
    64: begin
           @IDE_RefreshMenus := Addr;
           fOrganize.plugin_id:= PlugInID;
           @fOrganize.plugin_refresh:= Addr;
        end;
    65: begin
           @IDE_SetMenuName :=Addr;
        end;
    67: begin
           @IDE_SetMenuVisible :=Addr;
        end;
    68: begin
           @IDE_GetMenulayout:= Addr;
        end;
  end;
end;

// Called when the Plug-In is created
procedure OnCreate; cdecl;
begin
    g_last_requested_group:= '';
    fOrganize:= TfOrganize.Create(Application);
end;

procedure OnActivate; cdecl;
begin
    g_last_requested_group:= '';
    fOrganize.load_settings('', False);
    IDE_RefreshMenus(PlugInID);
end;

// Called when the Plug-In is destroyed
procedure OnDestroy; cdecl;
begin
    fOrganize.Free;
end;

procedure Configure; cdecl;
begin
    fOrganize.populate_cbb_after_menu(IDE_GetMenulayout());
    if fOrganize.ShowModal = mrOk then;
    ;
end;


// This function will be called with an Index ranging from 1 to 99. For every Index you
// can return a string that creates a new menu-item in PL/SQL Developer.
function CreateMenuItem(Index: Integer): PChar;  cdecl;
var
   l_node: TTreeNode;
   res: string;
begin
try
    res:= '';
    if Index = 1 then
        res:= fOrganize.menu_location + ' >> ' + fOrganize.menu_root
    else if Index = 2 then
        res:= fOrganize.menu_root + ' / '+ 'Add Current'
    else if Index = 3 then
        res:= fOrganize.menu_root + ' / '+ 'Organize...'
    else if Index = 4 then begin
        res:= fOrganize.menu_root + ' / '+ '-';
    end else if fOrganize.tv.Items.Count > Index - 5 then begin
        l_node:= fOrganize.tv.Items[Index - 5];
        if favorites_rec( l_node.Data ).item_type = C_ITEM_TYPE_GROUP then begin
            g_last_requested_group:= favorites_rec( l_node.Data ).group_desc;
            res:= fOrganize.menu_root + ' / '+ g_last_requested_group;
        end else if l_node.Parent <> nil then begin
            if favorites_rec( l_node.Data ).item_type = C_ITEM_TYPE_SCRIPT then begin
                res:= fOrganize.menu_root + ' / '+ g_last_requested_group + ' / ' + favorites_rec( l_node.Data ).script_name;
            end else begin
                res:= fOrganize.menu_root + ' / '+ g_last_requested_group + ' / -';
            end;
        end else begin
            g_last_requested_group:= '';
            if favorites_rec( l_node.Data ).item_type = C_ITEM_TYPE_SCRIPT then begin
                res:= fOrganize.menu_root +  ' / '+ favorites_rec( l_node.Data ).script_name;
            end else begin
                res:= fOrganize.menu_root +  ' / '+ '-';
            end;
        end;
    end;
    if res <> '' then begin
        GetMem( Result, Length(res) + 1);
        Result:= StrPCopy(Result, res);
    end else Result:= '';
except
    on E: Exception do ShowMessage(E.Message);
end;
end;

// This function is called when a user selected a menu-item created with the
// CreateMenuItem function and the Index parameter has the value (1 to 99) it is related to.
procedure OnMenuClick(Index: Integer);  cdecl;
var
    ide_file_name: string;
    l_node: TTreeNode;
    mrDummy: Integer;
begin
  case Index of
    1 : begin
            // Nothing for Favorites root
        end;
    2 : begin
            ide_file_name:= string( IDE_Filename());
            if ide_file_name <> '' then
                fOrganize.add_plsqdev_script(ide_file_name)
            else
                mrDummy:= MessageDlg( 'Save script first'
                            , mtError, [mbOk], 0);
            IDE_Refresh;
            // IDE_RefreshMenus(PlugInID);
        end;
    3 : begin
            Configure;
        end;
    4: begin
           // separator
       end;
  else begin
           if fOrganize.tv.Items.Count + 4 >= Index then begin
               l_node:= fOrganize.tv.Items[Index - 5];
               if favorites_rec(l_node.Data).item_type = C_ITEM_TYPE_SCRIPT then
                   if favorites_rec(l_node.Data).script_file = '' then begin
                       favorites_rec(l_node.Data).Free;
                       l_node.Delete;
                       fOrganize.save_settings;
                   end else if not IDE_OpenFile(0, PChar(favorites_rec(l_node.Data).script_file)) then begin
                       if MessageDlg( 'File not found. Remove? [' + favorites_rec(l_node.Data).script_file+']'
                            , mtError, [mbYes, mbNo], 0) = mrYes then begin
                           favorites_rec(l_node.Data).Free;
                           l_node.Delete;
                           fOrganize.save_settings;
                          // IDE_RefreshMenus(PlugInID);
                       end;

                   end;
           end;
       end;
  end;
end;

procedure OnMainMenu(MenuName: PChar);
begin
end;

exports
  IdentifyPlugIn,
  RegisterCallback,
  OnCreate,
  OnActivate,
  OnDestroy,
  Configure,
  CreateMenuItem,
  OnMenuClick,
  OnMainMenu;

end.
