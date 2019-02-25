unit UntKur;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, BaseGrid, AdvGrid, Menus, DB, ADODB, StdCtrls, Buttons, jpeg, ExtCtrls, Mask,
  MoneyEdit, ComCtrls,DateUtils,ShellApi, AdvEdit, AdvMoneyEdit;

type
  TFrmKur = class(TForm)
    Label2: TLabel;
    Panel5: TPanel;
    ImgSave: TImage;
    LblSave: TLabel;
    LblStatus: TLabel;
    Label7: TLabel;
    Image3: TImage;
    Label10: TLabel;
    Label14: TLabel;
    a: TImage;
    DtTarih: TDateTimePicker;
    CurrAlis: TAdvMoneyEdit;
    Label1: TLabel;
    CmbKur: TComboBox;
    CurrSatis: TAdvMoneyEdit;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Qry1: TADOQuery;
    procedure ImgSaveClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure DtTarihChange(Sender: TObject);
    procedure CmbKurChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);


  private
    { Private declarations }
  public
    procedure CreateParams(var Params: TCreateParams); override;
    procedure KayitGetir;
    { Public declarations }
  end;

var
 FrmKur: TFrmKur;

implementation

uses UntGlobal, UntDlgCustomer, UntProjectGlobal;

{$R *.dfm}


procedure TFrmKur.CmbKurChange(Sender: TObject);
begin
KayitGetir;
end;

procedure TFrmKur.CreateParams(var Params: TCreateParams);
begin
 inherited CreateParams(Params);
  Params.ExStyle   := Params.ExStyle or WS_EX_APPWINDOW;
  Params.WndParent := GetDesktopWindow;
end;

procedure TFrmKur.DtTarihChange(Sender: TObject);
begin
KayitGetir;
end;

procedure TFrmKur.FormClose(Sender: TObject; var Action: TCloseAction);
begin
Action := caFree;
FrmKur:= nil;
end;

procedure TFrmKur.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if  key = VK_ESCAPE  then close;
end;

procedure TFrmKur.FormShow(Sender: TObject);
begin
DtTarih.Date := Date ;
end;

procedure TFrmKur.ImgSaveClick(Sender: TObject);
var TmpSql:string;
begin
ProgramKullanmaDurumu:=ProgramKullanmaDurumu+1;

if trim(CmbKur.Text) = '' Then begin
MsgUyari('Please select the currency  !!! ');
exit;
end;


if CmbKur.Tag = 0  Then begin
TmpSql:='insert into Kur ' +
'(tarih,parabirimi,alis,satis) ' +
'Values (:tarih,:parabirimi,:alis,:satis)';

qry1.Close;
qry1.SQL.Clear;
qry1.SQL.Add(TmpSql);
Qry1.Parameters.ParamByName('tarih').Value :=
IntToStr(YearOf(DtTarih.Date))+'-'+IntToStr(MonthOf(DtTarih.Date))+'-'+IntToStr(DayOf(DtTarih.Date));
Qry1.Parameters.ParamByName('parabirimi').Value := CmbKur.Text     ;
Qry1.Parameters.ParamByName('alis').Value       := CurrAlis.Value  ;
Qry1.Parameters.ParamByName('satis').Value      := CurrSatis.Value ;
qry1.Prepared;
qry1.ExecSQL;
end
Else begin
TmpSql:='Update Kur Set ' +
'tarih=:tarih,'+
'parabirimi=:parabirimi,'+
'alis=:alis,'+
'satis=:satis ' +
' where id=:id ';

qry1.Close;
qry1.SQL.Clear;
qry1.SQL.Add(TmpSql);
Qry1.Parameters.ParamByName('tarih').Value :=
IntToStr(YearOf(DtTarih.Date))+'-'+IntToStr(MonthOf(DtTarih.Date))+'-'+IntToStr(DayOf(DtTarih.Date));
Qry1.Parameters.ParamByName('parabirimi').Value := CmbKur.Text     ;
Qry1.Parameters.ParamByName('alis').Value       := CurrAlis.Value  ;
Qry1.Parameters.ParamByName('satis').Value      := CurrSatis.Value ;
Qry1.Parameters.ParamByName('id').Value         := CmbKur.Tag      ;
qry1.Prepared;
qry1.ExecSQL;
end;

MsgUyari('Save Successfully ...');
end;

procedure TFrmKur.KayitGetir;
begin
if CmbKur.Text = '' Then exit;

CurrAlis.Value  := 0 ;
CurrSatis.Value := 0 ;
CmbKur.Tag      := 0 ;

qry1.Close;
qry1.SQL.Clear;
qry1.SQL.Add('Select alis,satis,id from Kur where tarih=:tarih and parabirimi=:parabirimi ');
Qry1.Parameters.ParamByName('tarih').Value    :=
IntToStr(YearOf(DtTarih.Date))+'-'+IntToStr(MonthOf(DtTarih.Date))+'-'+IntToStr(DayOf(DtTarih.Date));
Qry1.Parameters.ParamByName('parabirimi').Value := CmbKur.Text;
qry1.Prepared;
qry1.open;
if qry1.RecordCount <> 0 then Begin
CurrAlis.Value  := Qry1.FieldByName('alis').AsCurrency ;
CurrSatis.Value := Qry1.FieldByName('satis').AsCurrency ;
CmbKur.Tag      := Qry1.FieldByName('id').AsInteger ;
end;
end;



end.
