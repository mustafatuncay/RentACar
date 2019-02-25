unit UntDlgCar;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, BaseGrid, AdvGrid, DBAdvGrd, StdCtrls, Buttons, ExtCtrls,
  DBAdvGrid, DBGrids, jpeg, DB, ADODB;

type
  TFrmDlgCar = class(TForm)
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
  FrmDlgCar: TFrmDlgCar;

implementation

uses UntDm, UntGlobal, UntProjectGlobal;

{$R *.dfm}

procedure TFrmDlgCar.BtnAraClick(Sender: TObject);
begin
ProgramKullanmaDurumu:=ProgramKullanmaDurumu+1;

Qry1.Close;
Qry1.SQL.Clear;
Qry1.SQL.Add('Select * from car where id<>0 ');
case cmbKriter.ItemIndex of
0 : Qry1.SQL.Add('and model  like :kriter ');
1 : Qry1.SQL.Add('and regno like :kriter ');
2 : Qry1.SQL.Add('and Grup  like :kriter ');
end;
Qry1.SQL.Add(' order by model ');
Qry1.Parameters.ParamByName('kriter').Value:=txtKiriter.Text+'%' ;
Qry1.Prepared;
Qry1.Open;
end;


procedure TFrmDlgCar.txtKiriterKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin

  if Key=13 then BtnAra.Click;
end;
procedure TFrmDlgCar.txtKiriterKeyPress(Sender: TObject; var Key: Char);
begin
key  := BuyukHarf(key,Sender as Tedit);
end;

// ***
procedure TFrmDlgCar.BtniptalClick(Sender: TObject);
begin
ProgramKullanmaDurumu:=ProgramKullanmaDurumu+1;

  iptal:=True;
  Self.Close;
end;
// ***
procedure TFrmDlgCar.FormCreate(Sender: TObject);
begin
  iptal:=True;
with DM.QryArama do
  begin
    Close;
    SQL.Clear;
  end;
end;
// ***
procedure TFrmDlgCar.btnTamamClick(Sender: TObject);
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
procedure TFrmDlgCar.Grd1DblClick(Sender: TObject);
begin
  btnTamam.Click;
end;

procedure TFrmDlgCar.FormShow(Sender: TObject);
begin
  Caption:=proCaption;
end;
// ***
procedure TFrmDlgCar.DBGrid1DblClick(Sender: TObject);
begin
  btnTamam.Click;
end;

end.
