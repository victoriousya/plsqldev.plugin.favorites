unit uObjects;

interface

uses SysUtils, StrUtils;
const
    C_ITEM_TYPE_GROUP     = 1;
    C_ITEM_TYPE_SCRIPT    = 2;
    C_ITEM_TYPE_SEPARATOR = 3;
    C_ITEM_TYPE_GROUP_END = 4;
type
     favorites_rec = class(TObject)
         item_type: integer;
         group_desc: string;
         script_name, script_file: string;
         window_type: Integer;
     public
         function export_line(i_use_relative_path: Boolean; i_settings_path: string): string;
         procedure import_line(i_line: string; i_use_relative_path: Boolean; i_settings_path: string);
     end;

implementation

{ favorites_rec }

function favorites_rec.export_line( i_use_relative_path: Boolean; i_settings_path: string ): string;
var
  l_script_file: string;
begin
    if Self.item_type = C_ITEM_TYPE_GROUP then begin
        result:= '+' + Self.group_desc;
    end else if Self.item_type = C_ITEM_TYPE_SEPARATOR then begin
        result:= '-';
    end else if Self.item_type = C_ITEM_TYPE_GROUP_END then begin
        result:= '=';
    end else begin
        if i_use_relative_path then
          l_script_file:= ExtractRelativePath(i_settings_path, self.script_file)
        else
          l_script_file:= Self.script_file;
        result:= self.script_name
                +'|'
                +l_script_file
                +'|'
                +IntToStr( self.window_type )
        ;
    end;
end;

procedure favorites_rec.import_line(i_line: string; i_use_relative_path: Boolean; i_settings_path: string);
var
    l_pos: Integer;
    l_offset: Integer;
    l_cur_dir: string;
begin

    if Copy(i_line,1,1) = '+' then begin
        Self.item_type:= C_ITEM_TYPE_GROUP;
        Self.group_desc:= Copy(i_line, 2, 255);
    end else if Copy(i_line,1,1) = '=' then begin
        Self.item_type:= C_ITEM_TYPE_GROUP_END;
    end else if Copy(i_line,1,1) = '-' then begin
        Self.item_type:= C_ITEM_TYPE_SEPARATOR;
    end else begin
        Self.item_type:= C_ITEM_TYPE_SCRIPT;
        Self.group_desc:= '';
        l_offset:= 1;
        l_pos:= PosEx('|', i_line, l_offset);
        self.script_name:= Copy(i_line, l_offset, l_pos - l_offset);

        l_offset:= l_pos + 1;
        l_pos:= PosEx('|', i_line, l_offset);
        self.script_file:= Copy(i_line, l_offset, l_pos - l_offset);
        if i_use_relative_path then begin
          l_cur_dir:= GetCurrentDir;
          SetCurrentDir(ExtractFilePath(i_settings_path));
          self.script_file:= ExpandFileName(self.script_file);
          SetCurrentDir(l_cur_dir);
        end;
        l_offset:= l_pos + 1;
        self.window_type:= StrToInt( Copy(i_line, l_offset, 1));

    end;

end;

end.
