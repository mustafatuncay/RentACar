unit UntDlgCustomer;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, BaseGrid, AdvGrid, DBAdvGrd, StdCtrls, Buttons, ExtCtrls,
  DBAdvGrid, DBGrids, jpeg, DB, ADODB;

type
  TFrmDlgCustomer = class(TForm)
    Panel2: TPanel;
    BtnAra: TSpeedButton;
    cmbKriter: TComboBox;
    txtKiriter: TEdit;
    Panel4: TPanel;
    btnTamam: TSpeedButton;
    Btniptal: TSpeedButton;
    DBGrid1: TDBGrid;
    Qry1: TADOQuery;
    ds1: TDataSource;
    Panel1: TPanel;
    Label7: TLabel;
    procedure BtnAraClick(Sender: TObject);
    procedure txtKiriterKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BtniptalClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnTamamClick(Sender: TObject);
    procedure Grd1DblClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure txtKiriterKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    actCariKod,actTUnvan:String;
    ActBakiye:Double;
    iptal:Boolean;
    TmpStatus:string;
    { Public declarations }
  end;

var
  FrmDlgCustomer: TFrmDlgCustomer;

implementation

uses UntDm, UntGlobal, UntProjectGlobal;

{$R *.dfm}

procedure TFrmDlgCustomer.BtnAraClick(Sender: TObject);
begin
ProgramKullanmaDurumu:=ProgramKullanmaDurumu+1;

Qry1.Close;
Qry1.SQL.Clear;
Qry1.SQL.Add('Select * from customer where id <> 0 ');
case cmbKriter.ItemIndex of
0 : Qry1.SQL.Add('and name  like :kriter ');
1 : Qry1.SQL.Add('and surname like :kriter ');
end;
Qry1.SQL.Add(' order by name ');
Qry1.Parameters.ParamByName('kriter').Value:=txtKiriter.Text+'%' ;
Qry1.Prepared;
Qry1.Open;
end;


procedure TFrmDlgCustomer.txtKiriterKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key=13 then BtnAra.Click;
end;
procedure TFrmDlgCustomer.txtKiriterKeyPress(Sender: TObject; var Key: Char);
begin
key  := BuyukHarf(key,Sender as Tedit);
end;

// ***
procedure TFrmDlgCustomer.BtniptalClick(Sender: TObject);
begin
ProgramKullanmaDurumu:=ProgramKullanmaDurumu+1;

  iptal:=True;
  Self.Close;
end;
// ***
procedure TFrmDlgCustomer.FormCreate(Sender: TObject);
begin
  iptal:=True;
with DM.QryArama do
  begin
    Close;
    SQL.Clear;
  end;
end;
// ***
procedure TFrmDlgCustomer.btnTamamClick(Sender: TObject);
begin
ProgramKullanmaDurumu:=ProgramKullanmaDurumu+1;

if (qry1.Active=False) or (qry1.RecordCount=0) then exit
else
begin
  iptal :=False;
  Self.Close;
end;
end;
// ***
procedure TFrmDlgCustomer.Grd1DblClick(Sender: TObject);
begin
  btnTamam.Click;
end;

procedure TFrmDlgCustomer.FormShow(Sender: TObject);
begin
  Caption:=proCaption;
  SetWindowPos(Handle, HWND_TOPMOST, Left, Top, Width, Height, SWP_NOACTIVATE or SWP_NOMOVE or SWP_NOSIZE);

end;
// ***
procedure TFrmDlgCustomer.DBGrid1DblClick(Sender: TObject);
begin
  btnTamam.Click;
end;

end.
