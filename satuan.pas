unit satuan;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, StdCtrls;

type
  TForm1 = class(TForm)
    lbl1: TLabel;
    lbl2: TLabel;
    lbl3: TLabel;
    edt1: TEdit;
    edt2: TEdit;
    btn1: TButton;
    btn2: TButton;
    btn3: TButton;
    btn4: TButton;
    dbgrd1: TDBGrid;
    edt3: TEdit;
    procedure bersih;
    procedure btn1Click(Sender: TObject);
    procedure btn2Click(Sender: TObject);
    procedure btn3Click(Sender: TObject);
    procedure btn4Click(Sender: TObject);
    procedure edt3Change(Sender: TObject);
    procedure dbgrd1CellClick(Column: TColumn);
   
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  a: string;

implementation

uses
  DataModule;

{$R *.dfm}

procedure TForm1.bersih;
begin
edt1.Clear;
edt2.Clear;
end;

procedure TForm1.btn1Click(Sender: TObject);
begin
  if edt1.Text = '' then
  begin
    ShowMessage('Nama Satuan Tidak Boleh Kosong!');
  end
  else if DataModule2.zqry1.Locate('nama', edt1.Text, []) then
  begin
    ShowMessage('Nama Satuan ' + edt1.Text + ' Sudah Ada Didalam Sistem');
  end 
  else
  begin
    // Simpan
    with DataModule2.zqry1 do
    begin
      SQL.Clear;
      SQL.Add('insert into satuan values(null, "' + edt1.Text + '", "' + edt2.Text + '")');
      ExecSQL;
      SQL.Clear;
      SQL.Add('select * from satuan');
      Open;
    end;
    ShowMessage('Data Berhasil Disimpan');
  end;
end;



procedure TForm1.btn2Click(Sender: TObject);
begin
 if edt1.Text = '' then
 begin
   ShowMessage('Nama Satuan Tidak Boleh Kosong!');
 end else

 begin
   with DataModule2.zqry1 do
   begin
     SQL.Clear;
     SQL.Add('update satuan set nama="'+edt1.Text+'", diskripsi="'+edt2.Text+'" where id= "'+a+'"');
     ExecSQL;

     SQL.Clear;
     SQL.Add('select * from satuan');
     Open;
   end;
 end;
end;

procedure TForm1.btn3Click(Sender: TObject);
begin
 if MessageDlg('Apakah Anda Yakin Menghapus Data ini',mtWarning,[mbYes,mbNo],0)=mryes then
 begin
   with DataModule2.zqry1 do
   begin
     SQL.Clear;
     SQL.Add('delete from satuan where id= "'+a+'"');
     ExecSQL;
     SQL.Clear;
     SQL.Add('select * from satuan');
     Open;
   end;
   ShowMessage('Data Berhasil Dihapus!');
   end else
   begin
    ShowMessage('Data Batal Dihapus!');
   end;
 end;

procedure TForm1.btn4Click(Sender: TObject);
begin
bersih;
end;

procedure TForm1.edt3Change(Sender: TObject);
begin
with DataModule2.zqry1 do
begin
  SQL.Clear;
  SQL.Add('select * from satuan where nama like "%'+edt3.Text+'%"');
  Open;
end;
end;

procedure TForm1.dbgrd1CellClick(Column: TColumn);
begin
 edt1.Text := DataModule2.zqry1.Fields[1].AsString;
  edt2.Text := DataModule2.zqry1.Fields[2].AsString;
  a := DataModule2.zqry1.Fields[0].AsString;
  edt1.Enabled := True;
  edt2.Enabled := True;
  btn1.Enabled := True;
  btn2.Enabled := True;
  btn3.Enabled := True;
  btn4.Enabled := False;
end;

end.

