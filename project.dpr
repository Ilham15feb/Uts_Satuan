program project;

uses
  Forms,
  satuan in 'satuan.pas' {Form1},
  DataModule in 'DataModule.pas' {DataModule2: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TDataModule2, DataModule2);
  Application.Run;
end.
