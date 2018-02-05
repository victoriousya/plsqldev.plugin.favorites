unit uPlugin;

interface

uses Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls, uOrganize, uObjects, PlugInIntf;

const // Description of this Plug-In (as displayed in Plug-In configuration dialog)
  Plugin_Desc = 'Favorites by cathegory 1.0';
var
  fOrganize: TfOrganize = nil;
  g_last_requested_group: string;

implementation

// Plug-In identification, a unique identifier is received and
// the description is returned
function IdentifyPlugIn(ID: Integer): PChar;  cdecl;
begin
  PlugInID := ID;
  Result := Plugin_Desc;
end;

// Called when the Plug-In is created
procedure OnCreate; cdecl;
begin
    g_last_requested_group:= '';
//    Application.Handle := IDE_GetAppHandle;
    fOrganize:= TfOrganize.Create(Application);
end;

procedure OnActivate; cdecl;
begin
    g_last_requested_group:= '';
    @fOrganize.ide_refresh:= @IDE_Refresh;
    fOrganize.plugin_id:= PlugInID;
    @fOrganize.plugin_refresh:= @IDE_RefreshMenus;
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
  if not Assigned(fOrganize) then Exit;
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

function About: PChar;
begin
  Result:= Plugin_Desc+
           #13'©2017-2018 VictoriousSoft Team'
         + #13#13'Favorite script with subfolders'
         + #13'eMail to author: victorious.soft@gmail.ru'
         + #13'or visit my GitHub page: github.com/victoriousya'
           ;
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
  OnMainMenu,
  About;

end.
