unit UntCarList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, BaseGrid, AdvGrid, Menus, DB, ADODB, StdCtrls, Buttons, jpeg, ExtCtrls, Mask,
  MoneyEdit, asgcombo, ColorCombo, AdvDropDown, AdvColorPickerDropDown, AdvObj;

type
  TFrmCarList = class(TForm)
    Label2: TLabel;
    Panel5: TPanel;
    Qry1: TADOQuery;
    qry2: TADOQuery;
    Panel1: TPanel;
    Label9: TLabel;
    AdvCarList: TAdvStringGrid;
    Panel2: TPanel;
    ImgList: TImage;
    LblList: TLabel;
    Label4: TLabel;
    Label26: TLabel;
    txtmarka: TEdit;
    txtplaka: TEdit;
    LblNew: TLabel;
    ImgNew: TImage;
    PopupMenu1: TPopupMenu;
    SaveTheOrder1: TMenuItem;
    procedure ImgNewClick(Sender: TObject);
    procedure AdvCarListDblClick(Sender: TObject);
    procedure ImgListClick(Sender: TObject);
    procedure SaveTheOrder1Click(Sender: TObject);

    procedure FormClose(Sender: TObject; var Action: TCloseAction);


  private
    { Private declarations }
  public
     procedure CreateParams(var Params: TCreateParams); override;


    { Public declarations }
  end;

var
 FrmCarList: TFrmCarList;

implementation

uses UntDlgCar, UntGlobal, UntProjectGlobal, UntCar;

{$R *.dfm}


procedure TFrmCarList.AdvCarListDblClick(Sender: TObject);
begin
if  assigned(FrmCar) then begin
if (FrmCar.WindowState = wsMinimized ) Then FrmCar.WindowState := wsNormal  ;
FrmCar.BringToFront;
exit;
end;

FrmCar:=TFrmCar.Create(Self);

FrmCar.ArabaGetir(AdvCarList.Cells[3,AdvCarList.Row]);

FrmCar.Show;
end;



procedure TFrmCarList.CreateParams(var Params: TCreateParams);
begin
 inherited CreateParams(Params);
  Params.ExStyle   := Params.ExStyle or WS_EX_APPWINDOW;
  Params.WndParent := GetDesktopWindow;
end;

procedure TFrmCarList.FormClose(Sender: TObject; var Action: TCloseAction);
begin
Action := caFree;
FrmCarList:= nil;
end;

procedure TFrmCarList.ImgListClick(Sender: TObject);
var TmpSql:string;
i:integer;
begin

AdvCarList.ClearRows(1,AdvCarList.RowCount-1);
AdvCarList.RowCount := 2;

   TmpSql := 'Select Model,RegNo,id from Car where id<>0 ' ;

if Trim(txtmarka.text) <> '' then
TmpSql := TmpSql + ' and Model=:Model ' ;

if Trim(txtplaka.text) <> '' then
TmpSql := TmpSql + ' and RegNo=:RegNo ' ;

TmpSql := TmpSql + ' order by sirano ' ;

qry1.Close;
qry1.SQL.Clear;
qry1.SQL.Add(TmpSql);
if Trim(txtmarka.text) <> '' then
Qry1.Parameters.ParamByName('Model').Value := trim(txtmarka.Text) ;
if Trim(txtplaka.text) <> '' then
Qry1.Parameters.ParamByName('RegNo').Value := trim(txtplaka.Text) ;
qry1.Prepared;
qry1.open;

if Qry1.RecordCount <> 0 then  AdvCarList.RowCount :=  Qry1.RecordCount + 1 ;

for i:=1 to Qry1.RecordCount do begin

AdvCarList.Cells[1,i] := Qry1.FieldByName('RegNo').AsString ;
AdvCarList.Cells[2,i] := Qry1.FieldByName('Model').AsString ;
AdvCarList.Cells[3,i] := Qry1.FieldByName('id').AsString ;

Qry1.Next;
end;

AdvCarList.AutoNumberCol(0);

end;

procedure TFrmCarList.ImgNewClick(Sender: TObject);
begin
ProgramKullanmaDurumu:=ProgramKullanmaDurumu+1;

FrmCar:=TFrmCar.Create(self);

FrmCar.Dtistartdate.Date   := Date ;
FrmCar.Dtienddate.Date     := Date ;
FrmCar.Dtsstartdate.Date   := Date ;
FrmCar.Dtsenddate.Date     := Date ;
FrmCar.DtMuayeneTarihi.Date:= Date ;
FrmCar.Dtspaymentdate.Date := Date ;
FrmCar.Dtipaymentdate.Date := Date ;

FrmCar.ShowModal;
FrmCar.Free;

end;



procedure TFrmCarList.SaveTheOrder1Click(Sender: TObject);
var i:integer;
TmpSql:String;
begin

for i:=1 to AdvCarList.RowCount-1 do begin
TmpSql:='update car set SiraNo=:SiraNo where id=:id ' ;
qry1.Close;
qry1.SQL.Clear;
qry1.SQL.Add(TmpSql);
Qry1.Parameters.ParamByName('SiraNo').Value := IntToStr(i) ;
Qry1.Parameters.ParamByName('id').Value     := AdvCarList.Cells[3,i] ;
qry1.Prepared;
qry1.ExecSQL;
end;

MsgUyari(' OK ...');


end;

end.
