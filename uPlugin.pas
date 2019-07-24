unit uPlugin;

interface

uses Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls, uOrganize, uObjects, PlugInIntf, Menus;

const // Description of this Plug-In (as displayed in Plug-In configuration dialog)
  Plugin_Desc = 'Favorites by cathegory 1.0';
  TB_BTN_MENU = 1;
var
  fOrganize: TfOrganize = nil;
  g_last_requested_group: string;

implementation

var
    tb_menu_bmp: TBitmap;
    pm: TPopupMenu;


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
    pm:= TPopupMenu.Create(Application);
    tb_menu_bmp:= TBitmap.Create;
end;

procedure OnActivate; cdecl;
begin
    Application.Handle := IDE_GetAppHandle;
    fOrganize.il_tv.GetBitmap(3, tb_menu_bmp);
    IDE_CreateToolButton(PlugInID, TB_BTN_MENU, 'Favorites', '', tb_menu_bmp.Handle);
    g_last_requested_group:= '';
//    @fOrganize.ide_refresh:= @IDE_Refresh;
//    fOrganize.plugin_id:= PlugInID;
//    @fOrganize.plugin_refresh:= @IDE_RefreshMenus;
//    fOrganize.load_settings('', False);
//    IDE_RefreshMenus(PlugInID);
end;

// Called when the Plug-In is destroyed
procedure OnDestroy; cdecl;
begin
    FreeAndNil(tb_menu_bmp);
    FreeAndNil(pm);
    fOrganize.Free;
end;

procedure Configure; cdecl;
begin
    if fOrganize.ShowModal = mrOk then;
    ;
end;

// This function is called when a user selected a menu-item created with the
// CreateMenuItem function and the Index parameter has the value (1 to 99) it is related to.

procedure OnMenuClick(Index: Integer);  cdecl;
var
    ide_file_name: string;
    l_node: TTreeNode;
    mrDummy: Integer;
    p: TPoint;
begin
  case Index of
    TB_BTN_MENU : begin
          fOrganize.CreatePopupMenu(pm);
          p:= Point(10, 10);
          p:= Mouse.CursorPos;
          pm.Popup(p.X, p.Y);
        end;
  end;
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
  OnMenuClick,
  About;

end.
