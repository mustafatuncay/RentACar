unit UntCar;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, BaseGrid, AdvGrid, Menus, DB, ADODB, StdCtrls, Buttons, jpeg, ExtCtrls, Mask,
  MoneyEdit, asgcombo, ColorCombo, AdvDropDown, AdvColorPickerDropDown, ComCtrls,
  AdvObj, AdvEdit, AdvMoneyEdit,DateUtils, AdvUtil;

type
  TFrmCar = class(TForm)
    Label2: TLabel;
    Panel5: TPanel;
    Qry1: TADOQuery;
    ColorDialog1: TColorDialog;
    qry2: TADOQuery;
    Panel1: TPanel;
    Label9: TLabel;
    LblStatus: TLabel;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    Label4: TLabel;
    Label26: TLabel;
    Label7: TLabel;
    Label1: TLabel;
    Label5: TLabel;
    Label8: TLabel;
    txtmarka: TEdit;
    txtplaka: TEdit;
    RbAuto: TRadioButton;
    RbManual: TRadioButton;
    RbTriptronic: TRadioButton;
    CmbGroup: TComboBox;
    CurrSiraNo: TMoneyEdit;
    ChkSold: TCheckBox;
    Button1: TButton;
    Button2: TButton;
    TabSheet4: TTabSheet;
    Label3: TLabel;
    Dtistartdate: TDateTimePicker;
    Label10: TLabel;
    Dtienddate: TDateTimePicker;
    Label11: TLabel;
    Cmbcompany: TComboBox;
    CurrThirdParty: TAdvMoneyEdit;
    Label12: TLabel;
    CurrKasko: TAdvMoneyEdit;
    Label13: TLabel;
    Label14: TLabel;
    CurrTotal: TAdvMoneyEdit;
    Label18: TLabel;
    Dtsstartdate: TDateTimePicker;
    Dtsenddate: TDateTimePicker;
    Currprice: TAdvMoneyEdit;
    Label19: TLabel;
    Label17: TLabel;
    Label15: TLabel;
    DtMuayeneTarihi: TDateTimePicker;
    Label16: TLabel;
    Dtspaymentdate: TDateTimePicker;
    Label20: TLabel;
    Dtipaymentdate: TDateTimePicker;
    BitBtn4: TBitBtn;
    BitBtn5: TBitBtn;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    ImgSave: TImage;
    ImgEdit: TImage;
    ImgDelete: TImage;
    ImgNew: TImage;
    LblSave: TLabel;
    LblEdit: TLabel;
    LblDelete: TLabel;
    Label6: TLabel;
    TabSheet3: TTabSheet;
    Label24: TLabel;
    DtExpenseDate: TDateTimePicker;
    BitBtn3: TBitBtn;
    BitBtn6: TBitBtn;
    Label25: TLabel;
    CurrSterlin1: TAdvMoneyEdit;
    CurrSterlin2: TAdvMoneyEdit;
    CurrSterlin3: TAdvMoneyEdit;
    CurrEuro1: TAdvMoneyEdit;
    CurrEuro2: TAdvMoneyEdit;
    CurrEuro3: TAdvMoneyEdit;
    Label27: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    MemCarinsurance: TMemo;
    CurrPrice2: TAdvMoneyEdit;
    CurrPrice3: TAdvMoneyEdit;
    Label30: TLabel;
    Label31: TLabel;
    Label32: TLabel;
    Label33: TLabel;
    CurrExpensePrice: TAdvMoneyEdit;
    CurrExpensePrice2: TAdvMoneyEdit;
    CurrExpensePrice3: TAdvMoneyEdit;
    Label34: TLabel;
    Label36: TLabel;
    Label21: TLabel;
    TxtExpense: TEdit;
    Label22: TLabel;
    MemSeyrusefer: TMemo;
    Label23: TLabel;
    MemExpense: TMemo;
    Label37: TLabel;
    MemCar: TMemo;
    Label35: TLabel;
    BitBtn7: TBitBtn;
    BitBtn9: TBitBtn;
    Label38: TLabel;
    TxtServiceKm: TEdit;
    Label39: TLabel;
    TxtNextServiceKm: TEdit;
    AdvExpense: TAdvStringGrid;
    Advinsurance: TAdvStringGrid;
    AdvSeyrusefer: TAdvStringGrid;
    procedure ImgNewClick(Sender: TObject);
    procedure ImgDeleteClick(Sender: TObject);
    procedure ImgEditClick(Sender: TObject);
    procedure ImgSaveClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn6Click(Sender: TObject);
    procedure CurrThirdPartyChange(Sender: TObject);
    procedure CurrKaskoChange(Sender: TObject);
    procedure CurrTotalChange(Sender: TObject);
    procedure CurrSterlin1Change(Sender: TObject);
    procedure CurrSterlin2Change(Sender: TObject);
    procedure CurrSterlin3Change(Sender: TObject);
    procedure CurrEuro1Change(Sender: TObject);
    procedure CurrEuro2Change(Sender: TObject);
    procedure CurrEuro3Change(Sender: TObject);
    procedure CurrpriceChange(Sender: TObject);
    procedure CurrPrice2Change(Sender: TObject);
    procedure CurrPrice3Change(Sender: TObject);
    procedure CurrExpensePriceChange(Sender: TObject);
    procedure CurrExpensePrice2Change(Sender: TObject);
    procedure CurrExpensePrice3Change(Sender: TObject);
    procedure CmbcompanyKeyPress(Sender: TObject; var Key: Char);
    procedure AdvinsuranceDblClick(Sender: TObject);
    procedure BitBtn7Click(Sender: TObject);
    procedure AdvSeyruseferDblClick(Sender: TObject);
    procedure BitBtn8Click(Sender: TObject);
    procedure AdvExpenseDblClick(Sender: TObject);
    procedure BitBtn9Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);



  private
    { Private declarations }
  public

    var PubSterlinAlis,PubSterlinSatis,PubEuroAlis,PubEuroSatis : Currency ;
    Pubc:integer;


    procedure insuranceList;
    procedure seyruseferList ;
    procedure ExpenseList;
    Procedure temizle;
    procedure ArabaGetir(Tmpid:string);


    { Public declarations }
  end;

var
 FrmCar: TFrmCar;

implementation

uses UntDlgCar, UntGlobal, UntProjectGlobal;

{$R *.dfm}


procedure TFrmCar.AdvExpenseDblClick(Sender: TObject);
begin
qry1.Close;
qry1.SQL.Clear;
qry1.SQL.Add('Select * from CarExpense Where id='''+AdvExpense.Cells[7,AdvExpense.Row]+'''  ');
qry1.open;
DtExpenseDate.DateTime  := Qry1.FieldByName('ExpenseDate').AsDateTime ;
TxtExpense.Text         := Qry1.FieldByName('expense').AsString ;
CurrExpensePrice.Value  := Qry1.FieldByName('price').Asfloat ;
MemExpense.Text         := Qry1.FieldByName('Notes').AsString ;
CurrExpensePrice2.Value := Qry1.FieldByName('priceSterlin').Asfloat;
CurrExpensePrice3.Value := Qry1.FieldByName('priceEuro').Asfloat;
TxtServiceKm.Text       := Qry1.FieldByName('ServiceKm').AsString ;
TxtNextServiceKm.Text   := Qry1.FieldByName('NextServiceKm').AsString ;

TxtExpense.Tag          := Qry1.FieldByName('id').AsInteger ;
end;

procedure TFrmCar.AdvinsuranceDblClick(Sender: TObject);
begin

qry1.Close;
qry1.SQL.Clear;
qry1.SQL.Add('Select * from Carinsurance Where id='''+Advinsurance.Cells[16,Advinsurance.Row]+'''  ');
qry1.open;
Dtistartdate.DateTime   := Qry1.FieldByName('startdate').AsDateTime ;
Dtienddate.DateTime     := Qry1.FieldByName('enddate').AsDateTime ;
Cmbcompany.Text         := Qry1.FieldByName('company').AsString ;
MemCarinsurance.Text    := Qry1.FieldByName('Notes').AsString ;
CurrThirdParty.Value    := Qry1.FieldByName('thirdpartyprice').Asfloat ;
CurrKasko.Value         := Qry1.FieldByName('kaskoprice').Asfloat;
CurrTotal.Value         := Qry1.FieldByName('totalprice').Asfloat;
CurrSterlin1.Value      := Qry1.FieldByName('thirdpartypriceSterlin').Asfloat ;
CurrSterlin2.Value      := Qry1.FieldByName('kaskopriceSterlin').Asfloat;
CurrSterlin3.Value      := Qry1.FieldByName('totalpriceSterlin').Asfloat;
CurrEuro1.Value         := Qry1.FieldByName('thirdpartypriceEuro').Asfloat ;
CurrEuro2.Value         := Qry1.FieldByName('kaskopriceEuro').Asfloat;
CurrEuro3.Value         := Qry1.FieldByName('totalpriceEuro').Asfloat;
Dtipaymentdate.DateTime := Qry1.FieldByName('paymentdate').AsDateTime ;
MemCarinsurance.Text    := Qry1.FieldByName('notes').AsString ;
Cmbcompany.Tag          := Qry1.FieldByName('id').AsInteger ;

end;

procedure TFrmCar.AdvSeyruseferDblClick(Sender: TObject);
begin

qry1.Close;
qry1.SQL.Clear;
qry1.SQL.Add('Select * from Carseyrusefer Where id='''+AdvSeyrusefer.Cells[8,AdvSeyrusefer.Row]+'''  ');
qry1.open;
Dtsstartdate.DateTime   := Qry1.FieldByName('startdate').AsDateTime ;
Dtsenddate.DateTime     := Qry1.FieldByName('enddate').AsDateTime ;
Currprice.Value         := Qry1.FieldByName('price').Asfloat ;
Dtspaymentdate.DateTime := Qry1.FieldByName('odemetarihi').AsDateTime ;
MemSeyrusefer.Text      := Qry1.FieldByName('Notes').AsString ;
CurrPrice2.Value        := Qry1.FieldByName('priceSterlin').Asfloat;
CurrPrice3.Value        := Qry1.FieldByName('priceEuro').Asfloat;
Dtsstartdate.Tag        := Qry1.FieldByName('id').AsInteger ;

end;

procedure TFrmCar.ArabaGetir(Tmpid:string);
begin

qry1.Close;
qry1.SQL.Clear;
qry1.SQL.Add('Select * from Car where id=:id ');
Qry1.Parameters.ParamByName('id').Value := Tmpid;
qry1.Prepared;
qry1.open;

txtmarka.Text := Qry1.FieldByName('Model').AsString ;
txtplaka.Text := Qry1.FieldByName('RegNo').AsString ;

CmbGroup.ItemIndex := FrmCar.CmbGroup.Items.IndexOf(Qry1.FieldByName('Grup').AsString) ;

if Qry1.FieldByName('Type').AsString = 'Auto'       Then RbAuto.Checked := True ;
if Qry1.FieldByName('Type').AsString = 'Manual'     Then RbManual.Checked := True ;
if Qry1.FieldByName('Type').AsString = 'Triptronic' Then RbTriptronic.Checked := True ;

CurrSiraNo.Value := Qry1.FieldByName('SiraNo').AsCurrency ;

if Qry1.FieldByName('Sold').AsString = '1' Then ChkSold.Checked := True
Else ChkSold.Checked := False ;

Label5.Color          := StringToColor(Qry1.FieldByName('Color').AsString);
Label8.Color          := StringToColor(Qry1.FieldByName('FontColor').AsString);
DtMuayeneTarihi.Date  := Qry1.FieldByName('MuayeneTarihi').AsDateTime ;
MemCar.Text           := Qry1.FieldByName('Notes').AsString ;



txtmarka.Tag := Qry1.FieldByName('id').AsInteger ;

insuranceList;
seyruseferList;
ExpenseList;

ImgSave.Enabled:=False;
LblSave.Font.Color := clGray ;
LblSave.Enabled := False;

ImgDelete.Enabled:=True;
LblDelete.Font.Color := clWhite ;
LblDelete.Enabled := True;

ImgEdit.Enabled:=True;
LblEdit.Font.Color := clWhite ;
LblEdit.Enabled := True;


end;

procedure TFrmCar.BitBtn1Click(Sender: TObject);
var TmpSql:string;
TmpSiraNo,i,TmpMaxid:integer;
begin

ProgramKullanmaDurumu:=ProgramKullanmaDurumu+1;

if txtmarka.Tag = 0 Then begin
MsgUyari('Please Select The Car First   !!! ');
exit;
end;


TmpSql:='insert into Carseyrusefer ' +
'(carid,startdate,enddate,price,kayittarihi,odemetarihi,Notes,PriceEuro,PriceSterlin,CarModel,CarRegNo) ' +
'Values (:carid,:startdate,:enddate,:price,:kayittarihi,:odemetarihi,:Notes,:PriceEuro,:PriceSterlin,:CarModel,:CarRegNo)';

qry1.Close;
qry1.SQL.Clear;
qry1.SQL.Add(TmpSql);

Qry1.Parameters.ParamByName('carid').Value   := txtmarka.Tag ;
Qry1.Parameters.ParamByName('startdate').Value :=
IntToStr(YearOf(Dtsstartdate.Date))+'-'+IntToStr(MonthOf(Dtsstartdate.Date))+'-'+IntToStr(DayOf(Dtsstartdate.Date));
Qry1.Parameters.ParamByName('enddate').Value :=
IntToStr(YearOf(Dtsenddate.Date))+'-'+IntToStr(MonthOf(Dtsenddate.Date))+'-'+IntToStr(DayOf(Dtsenddate.Date));
Qry1.Parameters.ParamByName('price').Value       := Currprice.Value ;
Qry1.Parameters.ParamByName('kayittarihi').Value :=
IntToStr(YearOf(Date))+'-'+IntToStr(MonthOf(Date))+'-'+IntToStr(DayOf(Date));
Qry1.Parameters.ParamByName('odemetarihi').Value :=
IntToStr(YearOf(Dtspaymentdate.Date))+'-'+IntToStr(MonthOf(Dtspaymentdate.Date))+'-'+IntToStr(DayOf(Dtspaymentdate.Date));

Qry1.Parameters.ParamByName('Notes').Value         := MemSeyrusefer.Text ;

Qry1.Parameters.ParamByName('priceEuro').Value     := Currprice3.Value ;
Qry1.Parameters.ParamByName('priceSterlin').Value  := Currprice2.Value ;

Qry1.Parameters.ParamByName('CarModel').Value    := trim(txtmarka.Text) ;
Qry1.Parameters.ParamByName('CarRegNo').Value    := trim(txtplaka.Text) ;

qry1.Prepared;
qry1.ExecSQL;

MsgUyari('Save successfully ... ');

seyruseferList;
end;

procedure TFrmCar.BitBtn2Click(Sender: TObject);
begin
ProgramKullanmaDurumu:=ProgramKullanmaDurumu+1;

if MsgOnay('Do you want to delete ? ') Then begin

qry1.Close;
qry1.SQL.Clear;
qry1.SQL.Add('Delete from Carseyrusefer where id='''+AdvSeyrusefer.Cells[8,AdvSeyrusefer.Row]+''' ');
qry1.ExecSQL;

seyruseferList;
end;

end;

procedure TFrmCar.BitBtn3Click(Sender: TObject);
var TmpSql:string;
TmpSiraNo,i,TmpMaxid:integer;
begin

ProgramKullanmaDurumu:=ProgramKullanmaDurumu+1;

if txtmarka.Tag = 0 Then begin
MsgUyari('Please Select The Car First   !!! ');
exit;
end;

TmpSql:='insert into CarExpense ' +
'(carid,ExpenseDate,expense,price,Notes,priceEuro,priceSterlin,ServiceKm,NextServiceKm,CarModel,CarRegNo) ' +
'Values (:carid,:ExpenseDate,:expense,:price,:Notes,:priceEuro,:priceSterlin,:ServiceKm,:NextServiceKm,:CarModel,:CarRegNo)';

qry1.Close;
qry1.SQL.Clear;
qry1.SQL.Add(TmpSql);
Qry1.Parameters.ParamByName('carid').Value         := txtmarka.Tag ;
Qry1.Parameters.ParamByName('ExpenseDate').Value :=
IntToStr(YearOf(DtExpenseDate.Date))+'-'+IntToStr(MonthOf(DtExpenseDate.Date))+'-'+IntToStr(DayOf(DtExpenseDate.Date));
Qry1.Parameters.ParamByName('expense').Value       := TxtExpense.Text ;
Qry1.Parameters.ParamByName('price').Value         := CurrExpensePrice.Value ;
Qry1.Parameters.ParamByName('Notes').Value         := MemExpense.Text ;
Qry1.Parameters.ParamByName('priceEuro').Value     := CurrExpensePrice3.Value ;
Qry1.Parameters.ParamByName('priceSterlin').Value  := CurrExpensePrice2.Value ;
Qry1.Parameters.ParamByName('ServiceKm').Value     := TxtServiceKm.Text ;
Qry1.Parameters.ParamByName('NextServiceKm').Value := TxtNextServiceKm.Text ;

Qry1.Parameters.ParamByName('CarModel').Value    := trim(txtmarka.Text) ;
Qry1.Parameters.ParamByName('CarRegNo').Value    := trim(txtplaka.Text) ;

qry1.Prepared;
qry1.ExecSQL;

MsgUyari('Save successfully ... ');

ExpenseList;
end;

procedure TFrmCar.BitBtn4Click(Sender: TObject);
var TmpSql:string;
TmpSiraNo,i,TmpMaxid:integer;
begin

ProgramKullanmaDurumu:=ProgramKullanmaDurumu+1;

if txtmarka.Tag = 0 Then begin
MsgUyari('Please Select The Car First   !!! ');
exit;
end;

if trim(Cmbcompany.Text) = '' Then begin
MsgUyari('Please enter insurance company  !!! ');
exit;
end;


TmpSql:='insert into Carinsurance ' +
'(carid,company,startdate,enddate,thirdpartyprice,kaskoprice,totalprice,paymentdate,kayittarihi,Notes,'+
'thirdpartypriceSterlin,kaskopriceSterlin,totalpriceSterlin,thirdpartypriceEuro,kaskopriceEuro,totalpriceEuro,CarModel,CarRegNo) ' +
'Values (:carid,:company,:startdate,:enddate,:thirdpartyprice,:kaskoprice,:totalprice,:paymentdate,:kayittarihi,:Notes,'+
':thirdpartypriceSterlin,:kaskopriceSterlin,:totalpriceSterlin,:thirdpartypriceEuro,:kaskopriceEuro,:totalpriceEuro,:CarModel,:CarRegNo) ' ;
qry1.Close;
qry1.SQL.Clear;
qry1.SQL.Add(TmpSql);
Qry1.Parameters.ParamByName('carid').Value   := txtmarka.Tag ;
Qry1.Parameters.ParamByName('company').Value := Cmbcompany.Text ;
Qry1.Parameters.ParamByName('startdate').Value :=
IntToStr(YearOf(Dtistartdate.Date))+'-'+IntToStr(MonthOf(Dtistartdate.Date))+'-'+IntToStr(DayOf(Dtistartdate.Date));
Qry1.Parameters.ParamByName('enddate').Value :=
IntToStr(YearOf(Dtienddate.Date))+'-'+IntToStr(MonthOf(Dtienddate.Date))+'-'+IntToStr(DayOf(Dtienddate.Date));
Qry1.Parameters.ParamByName('thirdpartyprice').Value  := CurrThirdParty.Value ;
Qry1.Parameters.ParamByName('kaskoprice').Value       := CurrKasko.Value ;
Qry1.Parameters.ParamByName('totalprice').Value       := CurrTotal.Value ;
Qry1.Parameters.ParamByName('paymentdate').Value :=
IntToStr(YearOf(Dtipaymentdate.Date))+'-'+IntToStr(MonthOf(Dtipaymentdate.Date))+'-'+IntToStr(DayOf(Dtipaymentdate.Date));
Qry1.Parameters.ParamByName('kayittarihi').Value :=
IntToStr(YearOf(Date))+'-'+IntToStr(MonthOf(Date))+'-'+IntToStr(DayOf(Date));
Qry1.Parameters.ParamByName('Notes').Value       := MemCarinsurance.Text ;
Qry1.Parameters.ParamByName('thirdpartypriceSterlin').Value := CurrSterlin1.Value ;
Qry1.Parameters.ParamByName('kaskopriceSterlin').Value      := CurrSterlin2.Value ;
Qry1.Parameters.ParamByName('totalpriceSterlin').Value      := CurrSterlin3.Value ;
Qry1.Parameters.ParamByName('thirdpartypriceEuro').Value    := CurrEuro1.Value ;
Qry1.Parameters.ParamByName('kaskopriceEuro').Value         := CurrEuro2.Value ;
Qry1.Parameters.ParamByName('totalpriceEuro').Value         := CurrEuro3.Value ;

Qry1.Parameters.ParamByName('CarModel').Value    := trim(txtmarka.Text) ;
Qry1.Parameters.ParamByName('CarRegNo').Value    := trim(txtplaka.Text) ;
qry1.Prepared;
qry1.ExecSQL;

MsgUyari('Save successfully ... ');

insuranceList;
end;
procedure TFrmCar.BitBtn5Click(Sender: TObject);
begin
ProgramKullanmaDurumu:=ProgramKullanmaDurumu+1;

if MsgOnay('Do you want to delete ? ') Then begin

qry1.Close;
qry1.SQL.Clear;
qry1.SQL.Add('Delete from Carinsurance where id='''+Advinsurance.Cells[16,Advinsurance.Row]+''' ');
qry1.ExecSQL;

insuranceList;
end;

end;

procedure TFrmCar.BitBtn6Click(Sender: TObject);
begin
ProgramKullanmaDurumu:=ProgramKullanmaDurumu+1;

if MsgOnay('Do you want to delete ? ') Then begin

qry1.Close;
qry1.SQL.Clear;
qry1.SQL.Add('Delete from Carexpense where id='''+AdvExpense.Cells[7,AdvExpense.Row]+''' ');
qry1.ExecSQL;

ExpenseList;
end;

end;

procedure TFrmCar.BitBtn7Click(Sender: TObject);
var TmpSql:string;
TmpSiraNo,i,TmpMaxid:integer;
begin

ProgramKullanmaDurumu:=ProgramKullanmaDurumu+1;

if Cmbcompany.Tag = 0 Then begin
MsgUyari('There is No Record ...   !!! ');
exit;
end;

if txtmarka.Tag = 0 Then begin
MsgUyari('Please Select The Car First   !!! ');
exit;
end;

if trim(Cmbcompany.Text) = '' Then begin
MsgUyari('Please enter insurance company  !!! ');
exit;
end;

TmpSql:='Update Carinsurance Set ' +
'company=:company,'+
'startdate=:startdate,'+
'enddate=:enddate,'+
'thirdpartyprice=:thirdpartyprice,'+
'kaskoprice=:kaskoprice,'+
'totalprice=:totalprice,'+
'paymentdate=:paymentdate,'+
'Notes=:Notes,'+
'thirdpartypriceSterlin=:thirdpartypriceSterlin,'+
'kaskopriceSterlin=:kaskopriceSterlin,'+
'totalpriceSterlin=:totalpriceSterlin,'+
'thirdpartypriceEuro=:thirdpartypriceEuro,'+
'kaskopriceEuro=:kaskopriceEuro,'+
'totalpriceEuro=:totalpriceEuro ' +
' where id=:id ' ;

qry1.Close;
qry1.SQL.Clear;
qry1.SQL.Add(TmpSql);
Qry1.Parameters.ParamByName('company').Value := Cmbcompany.Text ;
Qry1.Parameters.ParamByName('startdate').Value :=
IntToStr(YearOf(Dtistartdate.Date))+'-'+IntToStr(MonthOf(Dtistartdate.Date))+'-'+IntToStr(DayOf(Dtistartdate.Date));
Qry1.Parameters.ParamByName('enddate').Value :=
IntToStr(YearOf(Dtienddate.Date))+'-'+IntToStr(MonthOf(Dtienddate.Date))+'-'+IntToStr(DayOf(Dtienddate.Date));
Qry1.Parameters.ParamByName('thirdpartyprice').Value  := CurrThirdParty.Value ;
Qry1.Parameters.ParamByName('kaskoprice').Value       := CurrKasko.Value ;
Qry1.Parameters.ParamByName('totalprice').Value       := CurrTotal.Value ;
Qry1.Parameters.ParamByName('paymentdate').Value :=
IntToStr(YearOf(Dtipaymentdate.Date))+'-'+IntToStr(MonthOf(Dtipaymentdate.Date))+'-'+IntToStr(DayOf(Dtipaymentdate.Date));
Qry1.Parameters.ParamByName('Notes').Value       := MemCarinsurance.Text ;
Qry1.Parameters.ParamByName('thirdpartypriceSterlin').Value := CurrSterlin1.Value ;
Qry1.Parameters.ParamByName('kaskopriceSterlin').Value      := CurrSterlin2.Value ;
Qry1.Parameters.ParamByName('totalpriceSterlin').Value      := CurrSterlin3.Value ;
Qry1.Parameters.ParamByName('thirdpartypriceEuro').Value    := CurrEuro1.Value ;
Qry1.Parameters.ParamByName('kaskopriceEuro').Value         := CurrEuro2.Value ;
Qry1.Parameters.ParamByName('totalpriceEuro').Value         := CurrEuro3.Value ;
Qry1.Parameters.ParamByName('id').Value                     := Cmbcompany.Tag ;
qry1.Prepared;
qry1.ExecSQL;

MsgUyari('Update successfully ... ');

insuranceList;
end;

procedure TFrmCar.BitBtn8Click(Sender: TObject);
var TmpSql:string;
TmpSiraNo,i,TmpMaxid:integer;
begin

ProgramKullanmaDurumu:=ProgramKullanmaDurumu+1;

if Dtsstartdate.Tag = 0 Then begin
MsgUyari('There is No Record ...   !!! ');
exit;
end;

if txtmarka.Tag = 0 Then begin
MsgUyari('Please Select The Car First   !!! ');
exit;
end;

TmpSql:='Update Carseyrusefer Set ' +
'startdate=:startdate,'+
'enddate=:enddate,'+
'price=:price,'+
'odemetarihi=:odemetarihi,'+
'Notes=:Notes,'+
'PriceEuro=:PriceEuro,'+
'PriceSterlin=:PriceSterlin'+

' where id=:id ' ;

qry1.Close;
qry1.SQL.Clear;
qry1.SQL.Add(TmpSql);
Qry1.Parameters.ParamByName('startdate').Value     :=
IntToStr(YearOf(Dtsstartdate.Date))+'-'+IntToStr(MonthOf(Dtsstartdate.Date))+'-'+IntToStr(DayOf(Dtsstartdate.Date));
Qry1.Parameters.ParamByName('enddate').Value       :=
IntToStr(YearOf(Dtsenddate.Date))+'-'+IntToStr(MonthOf(Dtsenddate.Date))+'-'+IntToStr(DayOf(Dtsenddate.Date));
Qry1.Parameters.ParamByName('price').Value         := Currprice.Value ;
Qry1.Parameters.ParamByName('odemetarihi').Value   :=
IntToStr(YearOf(Dtspaymentdate.Date))+'-'+IntToStr(MonthOf(Dtspaymentdate.Date))+'-'+IntToStr(DayOf(Dtspaymentdate.Date));
Qry1.Parameters.ParamByName('Notes').Value         := MemSeyrusefer.Text ;
Qry1.Parameters.ParamByName('PriceEuro').Value     := CurrPrice3.Value ;
Qry1.Parameters.ParamByName('PriceSterlin').Value  := CurrPrice2.Value ;
Qry1.Parameters.ParamByName('id').Value            := Dtsstartdate.Tag ;
qry1.Prepared;
qry1.ExecSQL;

MsgUyari('Update successfully ... ');

seyruseferList;
end;

procedure TFrmCar.BitBtn9Click(Sender: TObject);
var TmpSql:string;
TmpSiraNo,i,TmpMaxid:integer;
begin

ProgramKullanmaDurumu:=ProgramKullanmaDurumu+1;

if TxtExpense.Tag = 0 Then begin
MsgUyari('There is No Record ...   !!! ');
exit;
end;

if txtmarka.Tag = 0 Then begin
MsgUyari('Please Select The Car First   !!! ');
exit;
end;

TmpSql:='Update CarExpense Set ' +
'ExpenseDate=:ExpenseDate,'+
'expense=:expense,'+
'price=:price,'+
'Notes=:Notes,'+
'PriceEuro=:PriceEuro,'+
'PriceSterlin=:PriceSterlin,'+
'ServiceKm=:ServiceKm,'+
'NextServiceKm=:NextServiceKm ' +

' where id=:id ' ;

qry1.Close;
qry1.SQL.Clear;
qry1.SQL.Add(TmpSql);
Qry1.Parameters.ParamByName('ExpenseDate').Value   :=
IntToStr(YearOf(DtExpenseDate.Date))+'-'+IntToStr(MonthOf(DtExpenseDate.Date))+'-'+IntToStr(DayOf(DtExpenseDate.Date));
Qry1.Parameters.ParamByName('expense').Value       := TxtExpense.Text ;
Qry1.Parameters.ParamByName('price').Value         := CurrExpensePrice.Value ;
Qry1.Parameters.ParamByName('Notes').Value         := MemExpense.Text ;
Qry1.Parameters.ParamByName('PriceEuro').Value     := CurrExpensePrice3.Value ;
Qry1.Parameters.ParamByName('PriceSterlin').Value  := CurrExpensePrice2.Value ;
Qry1.Parameters.ParamByName('ServiceKm').Value     := TxtServiceKm.Text ;
Qry1.Parameters.ParamByName('NextServiceKm').Value := TxtNextServiceKm.Text ;

Qry1.Parameters.ParamByName('id').Value            := TxtExpense.Tag ;
qry1.Prepared;
qry1.ExecSQL;

MsgUyari('Update successfully ... ');

ExpenseList;
end;


procedure TFrmCar.Button1Click(Sender: TObject);
begin
if ColorDialog1.Execute()= False Then exit;

Label5.Color := ColorDialog1.Color;

end;

procedure TFrmCar.Button2Click(Sender: TObject);
begin
if ColorDialog1.Execute()= False Then exit;

Label8.Color := ColorDialog1.Color;
end;

procedure TFrmCar.CmbcompanyKeyPress(Sender: TObject; var Key: Char);
begin
key  := BuyukHarfCombo(key,Sender as TComboBox);
end;

procedure TFrmCar.CurrEuro1Change(Sender: TObject);
begin
exit;

if pubc=1 then exit;
Pubc:=1;
CurrThirdParty.Value := CurrEuro1.Value * PubEuroAlis ;
CurrSterlin1.Value      := (CurrEuro1.Value * PubEuroAlis) / PubSterlinAlis  ;
 pubc:=0;
end;

procedure TFrmCar.CurrEuro2Change(Sender: TObject);
begin
exit;

if pubc=1 then exit;
Pubc:=1;
CurrKasko.Value    := CurrEuro2.Value * PubEuroAlis ;
CurrSterlin2.Value      := (CurrEuro2.Value * PubEuroAlis) / PubSterlinAlis  ;
Pubc:=0;
end;

procedure TFrmCar.CurrEuro3Change(Sender: TObject);
begin
CurrEuro3.Value := CurrEuro2.Value + CurrEuro1.Value ;
exit;

if pubc=1 then exit;
Pubc:=1;
CurrTotal.Value      := CurrEuro3.Value * PubEuroAlis ;
CurrSterlin3.Value   := (CurrEuro3.Value * PubEuroAlis) / PubSterlinAlis  ;
Pubc:=0;
end;

procedure TFrmCar.CurrExpensePrice2Change(Sender: TObject);
begin
if pubc=1 then exit;
Pubc:=1;
CurrExpensePrice.Value  := CurrExpensePrice2.Value * PubSterlinAlis ;
CurrExpensePrice3.Value := (CurrExpensePrice2.Value * PubSterlinAlis) / PubEuroAlis  ;
Pubc:=0;
end;

procedure TFrmCar.CurrExpensePrice3Change(Sender: TObject);
begin
if pubc=1 then exit;
Pubc:=1;
CurrExpensePrice.Value  := CurrExpensePrice3.Value * PubEuroAlis ;
CurrExpensePrice2.Value := (CurrExpensePrice3.Value * PubEuroAlis) / PubSterlinAlis ;
pubc:=0;
end;

procedure TFrmCar.CurrExpensePriceChange(Sender: TObject);
begin
if pubc=1 then exit;
Pubc:=1;
CurrExpensePrice2.Value := CurrExpensePrice.Value / PubSterlinAlis ;
CurrExpensePrice3.Value := CurrExpensePrice.Value / PubEuroAlis    ;
Pubc:=0;
end;

procedure TFrmCar.CurrKaskoChange(Sender: TObject);
begin
exit;

if pubc=1 then exit;
Pubc:=1;
CurrSterlin2.Value := CurrKasko.Value / PubSterlinAlis ;
CurrEuro2.Value    := CurrKasko.Value / PubEuroAlis    ;
Pubc:=0;
end;

procedure TFrmCar.CurrPrice2Change(Sender: TObject);
begin
if pubc=1 then exit;
Pubc:=1;
Currprice.Value  := CurrPrice2.Value * PubSterlinAlis ;
CurrPrice3.Value := (CurrPrice2.Value * PubSterlinAlis) / PubEuroAlis  ;
Pubc:=0;
end;

procedure TFrmCar.CurrPrice3Change(Sender: TObject);
begin
if pubc=1 then exit;
Pubc:=1;
Currprice.Value  := CurrPrice3.Value * PubEuroAlis ;
CurrPrice2.Value := (CurrPrice3.Value * PubEuroAlis) / PubSterlinAlis ;
pubc:=0;
end;

procedure TFrmCar.CurrpriceChange(Sender: TObject);
begin
if pubc=1 then exit;
Pubc:=1;
Currprice2.Value := CurrPrice.Value / PubSterlinAlis ;
Currprice3.Value := Currprice.Value / PubEuroAlis    ;
Pubc:=0;
end;

procedure TFrmCar.CurrSterlin1Change(Sender: TObject);
begin
exit;
if pubc=1 then exit;
Pubc:=1;
CurrThirdParty.Value := CurrSterlin1.Value * PubSterlinAlis ;
CurrEuro1.Value      := (CurrSterlin1.Value * PubSterlinAlis) / PubEuroAlis  ;
Pubc:=0;
end;

procedure TFrmCar.CurrSterlin2Change(Sender: TObject);
begin
exit;

if pubc=1 then exit;
Pubc:=1;
CurrKasko.Value      := CurrSterlin2.Value * PubSterlinAlis ;
CurrEuro2.Value      := (CurrSterlin2.Value * PubSterlinAlis) / PubEuroAlis  ;
Pubc:=0;
end;

procedure TFrmCar.CurrSterlin3Change(Sender: TObject);
begin
CurrSterlin3.Value := CurrSterlin1.Value + CurrSterlin2.Value ;
exit;

if pubc=1 then exit;
Pubc:=1;
CurrTotal.Value      := CurrSterlin3.Value * PubSterlinAlis ;
CurrEuro3.Value      := (CurrSterlin3.Value * PubSterlinAlis) / PubEuroAlis  ;
Pubc:=0;
end;

procedure TFrmCar.CurrThirdPartyChange(Sender: TObject);
begin


CurrTotal.Value := CurrThirdParty.Value + CurrKasko.Value ;
exit;

if pubc=1 then exit;
Pubc:=1;
CurrSterlin1.Value := CurrThirdParty.Value / PubSterlinAlis ;
CurrEuro1.Value    := CurrThirdParty.Value / PubEuroAlis    ;
Pubc:=0;
end;

procedure TFrmCar.CurrTotalChange(Sender: TObject);
begin
exit;

if pubc=1 then exit;
Pubc:=1;
CurrSterlin3.Value := CurrTotal.Value / PubSterlinAlis ;
CurrEuro3.Value    := CurrTotal.Value / PubEuroAlis    ;
Pubc:=0;
end;

procedure TFrmCar.ExpenseList;
var TmpSql:string;
i:integer;
TmpGenelToplam,TmpGenelToplam2,TmpGenelToplam3:Currency;
begin

AdvExpense.ClearRows(1,AdvExpense.RowCount-1);
AdvExpense.RowCount := 2;

TmpSql := 'Select * from carexpense where carid='''+IntToStr(txtmarka.Tag)+''' order by ExpenseDate ' ;
qry1.Close;
qry1.SQL.Clear;
qry1.SQL.Add(TmpSql);
qry1.open;

if Qry1.RecordCount <> 0 then  AdvExpense.RowCount :=  Qry1.RecordCount + 1 ;
TmpGenelToplam:=0;
for i:=1 to Qry1.RecordCount do begin
AdvExpense.Cells[1,i] := Qry1.FieldByName('expensedate').AsString ;
AdvExpense.Cells[2,i] := Qry1.FieldByName('expense').AsString ;
AdvExpense.Cells[3,i] := FormatFloat('#,##0.00',Qry1.FieldByName('price').Asfloat) ;
AdvExpense.Cells[4,i] := FormatFloat('#,##0.00',Qry1.FieldByName('priceSterlin').Asfloat) ;
AdvExpense.Cells[5,i] := FormatFloat('#,##0.00',Qry1.FieldByName('priceEuro').Asfloat) ;
AdvExpense.Cells[6,i] := Qry1.FieldByName('Notes').AsString ;
AdvExpense.Cells[7,i] := Qry1.FieldByName('id').AsString ;

TmpGenelToplam := TmpGenelToplam + Qry1.FieldByName('price').AsCurrency ;
TmpGenelToplam2 := TmpGenelToplam2 + Qry1.FieldByName('priceSterlin').AsCurrency ;
TmpGenelToplam3 := TmpGenelToplam3 + Qry1.FieldByName('priceEuro').AsCurrency ;
Qry1.Next;
end;

AdvExpense.AutoNumberCol(0);
AdvExpense.AddRow;
AdvExpense.Cells[3,AdvExpense.RowCount-1]  := FormatFloat('#,##0.00',TmpGenelToplam) ;
AdvExpense.Colors[3,AdvExpense.RowCount-1] := clYellow;

AdvExpense.Cells[4,AdvExpense.RowCount-1]  := FormatFloat('#,##0.00',TmpGenelToplam2) ;
AdvExpense.Colors[4,AdvExpense.RowCount-1] := clYellow;

AdvExpense.Cells[5,AdvExpense.RowCount-1]  := FormatFloat('#,##0.00',TmpGenelToplam3) ;
AdvExpense.Colors[5,AdvExpense.RowCount-1] := clYellow;

end;

procedure TFrmCar.FormClose(Sender: TObject; var Action: TCloseAction);
begin
Action := caFree;
FrmCar:= nil;
end;

procedure TFrmCar.FormShow(Sender: TObject);
begin
PageControl1.TabIndex := 0;

qry1.Close;
qry1.SQL.Clear;
qry1.SQL.Add('select * from kur where tarih=:tarih and parabirimi=:parabirimi ' );
Qry1.Parameters.ParamByName('tarih').Value :=
IntToStr(YearOf(Date))+'-'+IntToStr(MonthOf(Date))+'-'+IntToStr(DayOf(Date));
Qry1.Parameters.ParamByName('parabirimi').Value := 'STERLIN' ;
qry1.Prepared;
qry1.open;

PubSterlinAlis  := Qry1.FieldByName('alis').AsCurrency ;
PubSterlinSatis := Qry1.FieldByName('satis').AsCurrency ;

qry1.Close;
qry1.SQL.Clear;
qry1.SQL.Add('select * from kur where tarih=:tarih and parabirimi=:parabirimi ' );
Qry1.Parameters.ParamByName('tarih').Value :=
IntToStr(YearOf(Date))+'-'+IntToStr(MonthOf(Date))+'-'+IntToStr(DayOf(Date));
Qry1.Parameters.ParamByName('parabirimi').Value := 'EURO' ;
qry1.Prepared;
qry1.open;

PubEuroAlis  := Qry1.FieldByName('alis').AsCurrency  ;
PubEuroSatis := Qry1.FieldByName('satis').AsCurrency ;

end;

procedure TFrmCar.ImgNewClick(Sender: TObject);
begin
ProgramKullanmaDurumu:=ProgramKullanmaDurumu+1;
temizle;
end;

procedure TFrmCar.ImgDeleteClick(Sender: TObject);
begin

ProgramKullanmaDurumu:=ProgramKullanmaDurumu+1;

qry1.Close;
qry1.SQL.Clear;
qry1.SQL.Add('SELECT id from Reservation where Carid='''+IntToStr(txtmarka.Tag)+''' ');
qry1.open;
if Qry1.RecordCount <> 0 then begin
MsgUyari(' This Car has transaction in the Reservation ... Can Not Delete ');
exit;
end;

qry1.Close;
qry1.SQL.Clear;
qry1.SQL.Add('SELECT id from Transfer where Carid='''+IntToStr(txtmarka.Tag)+''' ');
qry1.open;
if Qry1.RecordCount <> 0 then begin
MsgUyari(' This Car has transaction in the Transfers ... Can Not Delete ');
exit;
end;



if MsgOnay('Do you want to delete ? ') = False Then exit;

qry1.Close;
qry1.SQL.Clear;
qry1.SQL.Add('SELECT id from Carseyrusefer where Carid='''+IntToStr(txtmarka.Tag)+''' ');
qry1.open;
if Qry1.RecordCount <> 0 then begin
if MsgOnay(' This Car has Car Seyrusefer Records ... Do you want to delete ?  ') = False Then exit;
end;

qry1.Close;
qry1.SQL.Clear;
qry1.SQL.Add('SELECT id from Carinsurance where Carid='''+IntToStr(txtmarka.Tag)+''' ');
qry1.open;
if Qry1.RecordCount <> 0 then begin
if MsgOnay(' This Car has Car Insurance Records ... Do you want to delete ?  ') = False Then exit;
end;

qry1.Close;
qry1.SQL.Clear;
qry1.SQL.Add('Delete from car where id='''+IntToStr(txtmarka.Tag)+''' ');
qry1.ExecSQL;

MsgUyari('Records Deleted ...')  ;

self.Close;


end;

procedure TFrmCar.ImgEditClick(Sender: TObject);
var TmpSql,TmpType:String;
i,TmpSiraNo:integer;
begin
ProgramKullanmaDurumu:=ProgramKullanmaDurumu+1;
if trim(txtmarka.Text) = '' Then begin
MsgUyari('Please enter car model !!! ');
exit;
end;

if trim(txtplaka.Text) = '' Then begin
MsgUyari('Please enter car registry number !!! ');
exit;
end;

qry1.Close;
qry1.SQL.Clear;
qry1.SQL.Add('Select RegNo from Car where id<>:id and RegNo=:RegNo ');
Qry1.Parameters.ParamByName('RegNo').Value  := trim(txtplaka.Text) ;
Qry1.Parameters.ParamByName('id').Value     := txtmarka.tag;
qry1.Prepared;
qry1.open;
if qry1.RecordCount <> 0 then Begin
MsgUyari('Reg No Available ..Choose another ...');
exit;
end;


if RbAuto.Checked = True Then
TmpType        := 'Auto' ;
if RbManual.Checked = True Then
TmpType        := 'Manual' ;
if RbTriptronic.Checked = True Then
TmpType       := 'Triptronic' ;

TmpSql:='update car set ' +

' Model=:Model, '+
' RegNo=:RegNo, '+
' Grup=:Grup, ' +
' Type=:Type, '  +
' SiraNo=:SiraNo, '  +
' Sold=:Sold, '  +
' Color=:Color, '  +
' FontColor=:FontColor, '  +
' MuayeneTarihi=:MuayeneTarihi, '  +
' Notes=:Notes '  +
' where id = :id ';

qry1.Close;
qry1.SQL.Clear;
qry1.SQL.Add(TmpSql);
Qry1.Parameters.ParamByName('Model').Value  := trim(txtmarka.Text);
Qry1.Parameters.ParamByName('RegNo').Value  := trim(txtplaka.Text) ;
Qry1.Parameters.ParamByName('Grup').Value   := CmbGroup.Text;
Qry1.Parameters.ParamByName('Type').Value   := TmpType ;
Qry1.Parameters.ParamByName('SiraNo').Value := CurrSiraNo.Value;
if ChkSold.Checked = True then
Qry1.Parameters.ParamByName('Sold').Value     := '1'
Else
Qry1.Parameters.ParamByName('Sold').Value     := '0' ;
Qry1.Parameters.ParamByName('Color').Value     := ColorToString(Label5.Color);

Qry1.Parameters.ParamByName('FontColor').Value := ColorToString(Label8.Color);

Qry1.Parameters.ParamByName('MuayeneTarihi').Value := IntToStr(YearOf(DtMuayeneTarihi.Date))+'-'+
                                                      IntToStr(MonthOf(DtMuayeneTarihi.Date))+'-'+
                                                      IntToStr(DayOf(DtMuayeneTarihi.Date));

Qry1.Parameters.ParamByName('Notes').Value   := MemCar.Text;

Qry1.Parameters.ParamByName('id').Value     := txtmarka.tag;
qry1.Prepared;
qry1.ExecSQL;



TmpSql:='update Reservation set ' +

' CarModel =:CarModel, '+
' CarRegNo =:CarRegNo, '+
' CarGroup =:CarGroup, ' +
' CarType  =:CarType '  +
' where Carid = :Carid ';

qry1.Close;
qry1.SQL.Clear;
qry1.SQL.Add(TmpSql);
Qry1.Parameters.ParamByName('CarModel').Value    := txtmarka.Text ;
Qry1.Parameters.ParamByName('CarRegNo').Value    := txtplaka.Text ;
Qry1.Parameters.ParamByName('CarGroup').Value    := CmbGroup.Text ;
Qry1.Parameters.ParamByName('CarType').Value     := TmpType ;
Qry1.Parameters.ParamByName('Carid').Value       := txtmarka.tag;
qry1.Prepared;
qry1.ExecSQL;


////////////////////////SÝRA NO AYARLA////////////////////77
TmpSiraNo := StrToInt(currtostr(CurrSiraNo.Value)) ;
qry1.Close;
qry1.SQL.Clear;
qry1.SQL.Add('Select id from car where id<>:id and Grup=:Grup and sirano>=:sirano order by sirano asc ');
Qry1.Parameters.ParamByName('id').Value       := txtmarka.tag;
Qry1.Parameters.ParamByName('Grup').Value := CmbGroup.Text ;
Qry1.Parameters.ParamByName('SiraNo').Value   := TmpSiraNo;
qry1.Prepared;
qry1.open;

Qry1.First;
for i:=1 to Qry1.RecordCount do begin

TmpSiraNo:=TmpSiraNo+1;
qry2.Close;
qry2.SQL.Clear;
qry2.SQL.Add('Update Car Set SiraNo=:SiraNo where id=:id ');
Qry2.Parameters.ParamByName('SiraNo').Value   := TmpSiraNo ;
Qry2.Parameters.ParamByName('id').Value       := Qry1.FieldByName('id').AsInteger ;
qry2.Prepared;
qry2.ExecSQL;

Qry1.Next;
end;
///////////////////////////////////

MsgUyari('Update successfully ... ');


end;

procedure TFrmCar.ImgSaveClick(Sender: TObject);
var TmpSql:string;
TmpSiraNo,i,TmpMaxid:integer;
begin

ProgramKullanmaDurumu:=ProgramKullanmaDurumu+1;

if trim(txtmarka.Text) = '' Then begin
MsgUyari('Please enter car model  !!! ');
exit;
end;

if trim(txtplaka.Text) = '' Then begin
MsgUyari('Please enter car registry number !!! ');
exit;
end;

qry1.Close;
qry1.SQL.Clear;
qry1.SQL.Add('Select RegNo from Car where RegNo=:RegNo ');
Qry1.Parameters.ParamByName('RegNo').Value        := trim(txtplaka.Text) ;
qry1.Prepared;
qry1.open;
if qry1.RecordCount <> 0 then Begin
MsgUyari('Reg No Available ..Choose another ...');
exit;
end;


TmpSql:='insert into Car ' +
'(Model,RegNo,Grup,Type,SiraNo,Sold,Color,FontColor,MuayeneTarihi,Notes) ' +
'Values (:Model,:RegNo,:Grup,:Type,:SiraNo,:Sold,:Color,:FontColor,:MuayeneTarihi,:Notes)';

qry1.Close;
qry1.SQL.Clear;
qry1.SQL.Add(TmpSql);
Qry1.Parameters.ParamByName('Model').Value    := trim(txtmarka.Text) ;
Qry1.Parameters.ParamByName('RegNo').Value    := trim(txtplaka.Text) ;
Qry1.Parameters.ParamByName('Grup').Value     := CmbGroup.Text ;
if RbAuto.Checked = True Then
Qry1.Parameters.ParamByName('Type').Value     := 'Auto' ;
if RbManual.Checked = True Then
Qry1.Parameters.ParamByName('Type').Value     := 'Manual' ;
if RbTriptronic.Checked = True Then
Qry1.Parameters.ParamByName('Type').Value     := 'Triptronic' ;
Qry1.Parameters.ParamByName('SiraNo').Value   :=CurrSiraNo.Value;
if ChkSold.Checked = True then
Qry1.Parameters.ParamByName('Sold').Value     := '1'
Else
Qry1.Parameters.ParamByName('Sold').Value     := '0' ;

Qry1.Parameters.ParamByName('Color').Value     := ColorToString(Label5.Color);
Qry1.Parameters.ParamByName('FontColor').Value := ColorToString(Label8.Color);

Qry1.Parameters.ParamByName('MuayeneTarihi').Value    := IntToStr(YearOf(DtMuayeneTarihi.Date))+'-'+
                                                         IntToStr(MonthOf(DtMuayeneTarihi.Date))+'-'+
                                                         IntToStr(DayOf(DtMuayeneTarihi.Date));

Qry1.Parameters.ParamByName('Notes').Value   := MemCar.Text;

qry1.Prepared;
qry1.ExecSQL;



////////////////////////SÝRA NO AYARLA////////////////////77

qry1.Close;
qry1.SQL.Clear;
qry1.SQL.Add('Select Max(id) as d from car ');
qry1.open;
TmpMaxid := Qry1.FieldByName('d').AsInteger ;

TmpSiraNo := StrToInt(currtostr(CurrSiraNo.Value)) ;
qry1.Close;
qry1.SQL.Clear;
qry1.SQL.Add('Select id from car where id<>:id and Grup=:Grup and sirano>=:sirano order by sirano asc ');
Qry1.Parameters.ParamByName('id').Value       := TmpMaxid;
Qry1.Parameters.ParamByName('Grup').Value := CmbGroup.Text ;
Qry1.Parameters.ParamByName('SiraNo').Value   := TmpSiraNo;
qry1.Prepared;
qry1.open;

Qry1.First;
for i:=1 to Qry1.RecordCount do begin

TmpSiraNo:=TmpSiraNo+1;
qry2.Close;
qry2.SQL.Clear;
qry2.SQL.Add('Update Car Set SiraNo=:SiraNo where id=:id ');
Qry2.Parameters.ParamByName('SiraNo').Value   := TmpSiraNo ;
Qry2.Parameters.ParamByName('id').Value       := Qry1.FieldByName('id').AsInteger ;
qry2.Prepared;
qry2.ExecSQL;

Qry1.Next;
end;
///////////////////////////////////

MsgUyari(' Save Successfully ... ');

end;



procedure TFrmCar.insuranceList;
var TmpSql:string;
i:integer;
TmpGenelToplam,TmpGenelToplam2,TmpGenelToplam3:Currency;
begin

Advinsurance.ClearRows(1,Advinsurance.RowCount-1);
Advinsurance.RowCount := 2;

TmpSql := 'Select * from Carinsurance Where Carid='''+IntToStr(txtmarka.Tag)+'''   order by kayittarihi ' ;
qry1.Close;
qry1.SQL.Clear;
qry1.SQL.Add(TmpSql);
qry1.open;

if Qry1.RecordCount <> 0 then  Advinsurance.RowCount :=  Qry1.RecordCount + 1 ;
TmpGenelToplam:=0;
for i:=1 to Qry1.RecordCount do begin

Advinsurance.Cells[1,i] := Qry1.FieldByName('startdate').AsString ;
Advinsurance.Cells[2,i] := Qry1.FieldByName('enddate').AsString ;
Advinsurance.Cells[3,i] := Qry1.FieldByName('company').AsString ;
Advinsurance.Cells[4,i] := Qry1.FieldByName('Notes').AsString ;
Advinsurance.Cells[5,i] := FormatFloat('#,##0.00',Qry1.FieldByName('thirdpartyprice').Asfloat) ;
Advinsurance.Cells[6,i] := FormatFloat('#,##0.00',Qry1.FieldByName('kaskoprice').Asfloat);
Advinsurance.Cells[7,i] := FormatFloat('#,##0.00',Qry1.FieldByName('totalprice').Asfloat);

Advinsurance.Cells[8,i] := FormatFloat('#,##0.00',Qry1.FieldByName('thirdpartypriceSterlin').Asfloat) ;
Advinsurance.Cells[9,i] := FormatFloat('#,##0.00',Qry1.FieldByName('kaskopriceSterlin').Asfloat);
Advinsurance.Cells[10,i] := FormatFloat('#,##0.00',Qry1.FieldByName('totalpriceSterlin').Asfloat);

Advinsurance.Cells[11,i] := FormatFloat('#,##0.00',Qry1.FieldByName('thirdpartypriceEuro').Asfloat) ;
Advinsurance.Cells[12,i] := FormatFloat('#,##0.00',Qry1.FieldByName('kaskopriceEuro').Asfloat);
Advinsurance.Cells[13,i] := FormatFloat('#,##0.00',Qry1.FieldByName('totalpriceEuro').Asfloat);
Advinsurance.Cells[14,i] := Qry1.FieldByName('paymentdate').AsString ;
Advinsurance.Cells[15,i] := Qry1.FieldByName('notes').AsString ;
Advinsurance.Cells[16,i] := Qry1.FieldByName('id').AsString ;

TmpGenelToplam  := TmpGenelToplam + Qry1.FieldByName('totalprice').AsCurrency ;
TmpGenelToplam2 := TmpGenelToplam2 + Qry1.FieldByName('totalpriceSterlin').AsCurrency ;
TmpGenelToplam3 := TmpGenelToplam3 + Qry1.FieldByName('totalpriceEuro').AsCurrency ;
Qry1.Next;
end;

Advinsurance.AutoNumberCol(0);
Advinsurance.AddRow;
Advinsurance.Cells[7,Advinsurance.RowCount-1] :=  FormatFloat('#,##0.00',TmpGenelToplam) ;
Advinsurance.Colors[7,Advinsurance.RowCount-1] := clYellow;

Advinsurance.Cells[10,Advinsurance.RowCount-1] :=  FormatFloat('#,##0.00',TmpGenelToplam2) ;
Advinsurance.Colors[10,Advinsurance.RowCount-1] := clYellow;

Advinsurance.Cells[13,Advinsurance.RowCount-1] :=  FormatFloat('#,##0.00',TmpGenelToplam3) ;
Advinsurance.Colors[13,Advinsurance.RowCount-1] := clYellow;

end;


procedure TFrmCar.seyruseferList;
var TmpSql:string;
i:integer;
TmpGenelToplam,TmpGenelToplam2,TmpGenelToplam3:Currency;
begin

AdvSeyrusefer.ClearRows(1,AdvSeyrusefer.RowCount-1);
AdvSeyrusefer.RowCount := 2;

TmpSql := 'Select * from Carseyrusefer where carid='''+IntToStr(txtmarka.Tag)+''' order by kayittarihi ' ;
qry1.Close;
qry1.SQL.Clear;
qry1.SQL.Add(TmpSql);
qry1.open;

if Qry1.RecordCount <> 0 then  AdvSeyrusefer.RowCount :=  Qry1.RecordCount + 1 ;
TmpGenelToplam:=0;
for i:=1 to Qry1.RecordCount do begin

AdvSeyrusefer.Cells[1,i] := Qry1.FieldByName('startdate').AsString ;
AdvSeyrusefer.Cells[2,i] := Qry1.FieldByName('enddate').AsString ;
AdvSeyrusefer.Cells[3,i] := FormatFloat('#,##0.00',Qry1.FieldByName('price').Asfloat);
AdvSeyrusefer.Cells[4,i] := FormatFloat('#,##0.00',Qry1.FieldByName('priceSterlin').Asfloat);
AdvSeyrusefer.Cells[5,i] := FormatFloat('#,##0.00',Qry1.FieldByName('priceEuro').Asfloat);
AdvSeyrusefer.Cells[6,i] := Qry1.FieldByName('odemetarihi').AsString ;
AdvSeyrusefer.Cells[7,i] := Qry1.FieldByName('Notes').AsString ;
AdvSeyrusefer.Cells[8,i] := Qry1.FieldByName('id').AsString ;

TmpGenelToplam  := TmpGenelToplam  + Qry1.FieldByName('price').AsCurrency ;
TmpGenelToplam2 := TmpGenelToplam2 + Qry1.FieldByName('priceSterlin').AsCurrency ;
TmpGenelToplam3 := TmpGenelToplam3 + Qry1.FieldByName('priceEuro').AsCurrency ;
Qry1.Next;
end;

AdvSeyrusefer.AutoNumberCol(0);
AdvSeyrusefer.AddRow;
AdvSeyrusefer.Cells[3,AdvSeyrusefer.RowCount-1] :=  FormatFloat('#,##0.00',TmpGenelToplam) ;
AdvSeyrusefer.Colors[3,AdvSeyrusefer.RowCount-1] := clYellow;

AdvSeyrusefer.Cells[4,AdvSeyrusefer.RowCount-1] :=  FormatFloat('#,##0.00',TmpGenelToplam2) ;
AdvSeyrusefer.Colors[4,AdvSeyrusefer.RowCount-1] := clYellow;

AdvSeyrusefer.Cells[5,AdvSeyrusefer.RowCount-1] :=  FormatFloat('#,##0.00',TmpGenelToplam3) ;
AdvSeyrusefer.Colors[5,AdvSeyrusefer.RowCount-1] := clYellow;

end;


procedure TFrmCar.temizle;
begin
txtmarka.Clear;
txtplaka.Clear;
CurrSiraNo.Value := 0 ;

txtmarka.Tag := 0 ;

ImgSave.Enabled     := True;
LblSave.Font.Color  := clWhite ;
LblSave.Enabled     := True;

ImgDelete.Enabled   := False;
LblDelete.Font.Color:= clGray ;
LblDelete.Enabled   := False;

ImgEdit.Enabled     := False;
LblEdit.Font.Color  := clGray ;
LblEdit.Enabled     := False;

ChkSold.Checked := False;

LblStatus.Caption := '........';

end;

end.
