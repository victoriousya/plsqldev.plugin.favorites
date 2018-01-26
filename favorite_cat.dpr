program favorite_cat;

uses
  Forms,
  uOrganize in 'uOrganize.pas' {fOrganize},
  uObjects in 'uObjects.pas',
  uFileChangeMon in 'uFileChangeMon.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfOrganize, fOrganize);
  Application.Run;
end.
