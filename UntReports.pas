unit UntReports;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, BaseGrid, AdvGrid, Menus, DB, ADODB, StdCtrls, Buttons, jpeg, ExtCtrls, Mask,
  MoneyEdit, ComCtrls, DBGrids, asgprint, asgprev, tmsAdvGridExcel, AdvObj,DateUtils,
  DBAdvGrid;

type
  TFrmReports = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    Label2: TLabel;
    Panel5: TPanel;
    Qry1: TADOQuery;
    Ds1: TDataSource;
    TabSheet3: TTabSheet;
    AdvPreviewDialog1: TAdvPreviewDialog;
    AdvCustomer: TAdvStringGrid;
    AdvCar: TAdvStringGrid;
    Panel1: TPanel;
    ImgList: TImage;
    LblList: TLabel;
    SpeedButton4: TSpeedButton;
    ChkCarCollect: TCheckBox;
    ChkCarDeliver: TCheckBox;
    DtDeliver2: TDateTimePicker;
    DtDeliver1: TDateTimePicker;
    CmbKriter2: TComboBox;
    Panel2: TPanel;
    Image1: TImage;
    Label1: TLabel;
    Image3: TImage;
    Label4: TLabel;
    SpeedButton1: TSpeedButton;
    TxtKriter: TEdit;
    cmbKriter: TComboBox;
    Panel3: TPanel;
    Image2: TImage;
    Label3: TLabel;
    SpeedButton2: TSpeedButton;
    Panel4: TPanel;
    Label7: TLabel;
    PnlBirthDate: TPanel;
    CmbMbd1: TComboBox;
    CmbDbd2: TComboBox;
    CmbMbd2: TComboBox;
    Panel7: TPanel;
    CmbDbd1: TComboBox;
    CmbReservationKriter: TComboBox;
    Label5: TLabel;
    CmbReservationName: TComboBox;
    Label6: TLabel;
    CmbReservationSurname: TComboBox;
    TabSheet4: TTabSheet;
    Panel6: TPanel;
    Image5: TImage;
    Label8: TLabel;
    SpeedButton3: TSpeedButton;
    AdvLoyaltiest: TAdvStringGrid;
    cmbKriter3: TComboBox;
    TabSheetIncome: TTabSheet;
    Panel8: TPanel;
    Image6: TImage;
    Label9: TLabel;
    SpeedButton5: TSpeedButton;
    CmbIncomeSelect: TComboBox;
    AdvIncome: TAdvStringGrid;
    CmbIncomeKriter: TComboBox;
    ChkIncomeCollect: TCheckBox;
    DtIncomeCollect1: TDateTimePicker;
    DtIncomeCollect2: TDateTimePicker;
    CmbKriter33: TComboBox;
    RbByDay: TRadioButton;
    RbByReservation: TRadioButton;
    ChkMRCDateFrom: TCheckBox;
    DtMRCDateFrom: TDateTimePicker;
    DtMRCDateTo: TDateTimePicker;
    ChkMRCDateTo: TCheckBox;
    chkCLDateFrom: TCheckBox;
    DtCLDateFrom: TDateTimePicker;
    DtCLDateTo: TDateTimePicker;
    chkCLDateTo: TCheckBox;
    SpeedButton7: TSpeedButton;
    SpeedButton6: TSpeedButton;
    SpeedButton8: TSpeedButton;
    SpeedButton9: TSpeedButton;
    SpeedButton10: TSpeedButton;
    SaveDialog1: TSaveDialog;
    DataSource1: TDataSource;
    AdvReservation: TAdvStringGrid;
    AdvGridExcelIO1: TAdvGridExcelIO;
    TabSheet5: TTabSheet;
    Panel9: TPanel;
    Image4: TImage;
    Label10: TLabel;
    SpeedButton11: TSpeedButton;
    Label11: TLabel;
    Label12: TLabel;
    SpeedButton12: TSpeedButton;
    CmbTransferName: TComboBox;
    CmbTransferSurName: TComboBox;
    AdvTransfer: TAdvStringGrid;
    TabSheet6: TTabSheet;
    Panel10: TPanel;
    Image7: TImage;
    Label13: TLabel;
    AdvEmpty: TAdvStringGrid;
    Label14: TLabel;
    Dt1: TDateTimePicker;
    Dt2: TDateTimePicker;
    Qry2: TADOQuery;
    CmbEmptyKriter: TComboBox;
    TxtEmptyKriter: TEdit;
    DtSaat1: TDateTimePicker;
    DtSaat2: TDateTimePicker;
    Label15: TLabel;
    TabSheet7: TTabSheet;
    Label16: TLabel;
    CmbTCurrency: TComboBox;
    CmbRCurrency: TComboBox;
    Label17: TLabel;
    Label18: TLabel;
    CmbiCurrency: TComboBox;
    TabSheet8: TTabSheet;
    Panel11: TPanel;
    Image8: TImage;
    Label19: TLabel;
    SpeedButton13: TSpeedButton;
    SpeedButton14: TSpeedButton;
    CmbExpenseKriter: TComboBox;
    CmbExpenseKriter2: TComboBox;
    ChkEDate: TCheckBox;
    DtE1: TDateTimePicker;
    DtE2: TDateTimePicker;
    AdvExpense: TAdvStringGrid;
    Button1: TButton;
    Panel12: TPanel;
    Image9: TImage;
    Label20: TLabel;
    SpeedButton15: TSpeedButton;
    SpeedButton16: TSpeedButton;
    ChkAgency: TCheckBox;
    DtAgency1: TDateTimePicker;
    DtAgency2: TDateTimePicker;
    AdvAgency: TAdvStringGrid;
    CmbAgency: TComboBox;
    Label22: TLabel;
    DtCollect1: TDateTimePicker;
    DtCollect2: TDateTimePicker;
    TabSheet9: TTabSheet;
    Panel13: TPanel;
    Image10: TImage;
    Label21: TLabel;
    SpeedButton17: TSpeedButton;
    Label23: TLabel;
    Label24: TLabel;
    SpeedButton18: TSpeedButton;
    Label25: TLabel;
    ChkCarCollect2: TCheckBox;
    ChkCarDeliver2: TCheckBox;
    DtDeliver22: TDateTimePicker;
    DtDeliver12: TDateTimePicker;
    CmbKriter22: TComboBox;
    CmbReservationKriter2: TComboBox;
    CmbReservationName2: TComboBox;
    CmbReservationSurname2: TComboBox;
    CmbRCurrency2: TComboBox;
    DtCollect12: TDateTimePicker;
    DtCollect22: TDateTimePicker;
    AdvReservation2: TAdvStringGrid;
    ChkArrival: TCheckBox;
    DtArrival1: TDateTimePicker;
    DtArrival2: TDateTimePicker;
    DtDeparture2: TDateTimePicker;
    ChkDeparture: TCheckBox;
    DtDeparture1: TDateTimePicker;
    ChkDeleted1: TCheckBox;
    ChkDeleted2: TCheckBox;
    Label26: TLabel;
    Label27: TLabel;
    CmbName2: TComboBox;
    CmbSurname2: TComboBox;
    Label28: TLabel;
    CmbEmail: TComboBox;
    CurrTotalDays: TMoneyEdit;
    ChkInsurance: TCheckBox;
    ChkSeyrusefer: TCheckBox;
    ChkExpense: TCheckBox;
    TabSheet10: TTabSheet;
    Panel14: TPanel;
    Image11: TImage;
    Label29: TLabel;
    SpeedButton19: TSpeedButton;
    SpeedButton20: TSpeedButton;
    Label30: TLabel;
    ChkCompany: TCheckBox;
    DtCompany1: TDateTimePicker;
    DtCompany2: TDateTimePicker;
    CmbCompany: TComboBox;
    CurrTotalDays2: TMoneyEdit;
    AdvCompany: TAdvStringGrid;
    ChkTransfer: TCheckBox;
    ChkPetrol: TCheckBox;
    Button2: TButton;
    procedure FormShow(Sender: TObject);
    procedure ImgistClick(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
    procedure Image1Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure Image2Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure cmbKriterChange(Sender: TObject);
    procedure CmbKriter2Change(Sender: TObject);
    procedure CmbReservationNameChange(Sender: TObject);
    procedure CmbReservationSurnameChange(Sender: TObject);
    procedure Image5Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure SpeedButton5Click(Sender: TObject);
    procedure CmbIncomeSelectChange(Sender: TObject);
    procedure Image6Click(Sender: TObject);
    procedure cmbKriter3Change(Sender: TObject);
    procedure SpeedButton7Click(Sender: TObject);
    procedure SpeedButton6Click(Sender: TObject);
    procedure SpeedButton8Click(Sender: TObject);
    procedure SpeedButton9Click(Sender: TObject);
    procedure SpeedButton10Click(Sender: TObject);
    procedure AdvIncomeGetAlignment(Sender: TObject; ARow, ACol: Integer;
      var HAlign: TAlignment; var VAlign: TVAlignment);
    procedure CmbReservationKriterKeyPress(Sender: TObject; var Key: Char);
    procedure CmbReservationNameKeyPress(Sender: TObject; var Key: Char);
    procedure CmbReservationSurnameKeyPress(Sender: TObject; var Key: Char);
    procedure CmbKriter33KeyPress(Sender: TObject; var Key: Char);
    procedure AdvCustomerDblClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure AdvReservationGetAlignment(Sender: TObject; ARow, ACol: Integer;
      var HAlign: TAlignment; var VAlign: TVAlignment);
    procedure AdvReservationDblClick(Sender: TObject);
    procedure Image4Click(Sender: TObject);
    procedure SpeedButton11Click(Sender: TObject);
    procedure SpeedButton12Click(Sender: TObject);
    procedure Image7Click(Sender: TObject);
    procedure SpeedButton13Click(Sender: TObject);
    procedure SpeedButton14Click(Sender: TObject);
    procedure Label19Click(Sender: TObject);
    procedure AdvExpenseGetAlignment(Sender: TObject; ARow, ACol: Integer;
      var HAlign: TAlignment; var VAlign: TVAlignment);
    procedure Button1Click(Sender: TObject);
    procedure Image9Click(Sender: TObject);
    procedure AdvAgencyGetAlignment(Sender: TObject; ARow, ACol: Integer;
      var HAlign: TAlignment; var VAlign: TVAlignment);
    procedure Image10Click(Sender: TObject);
    procedure SpeedButton17Click(Sender: TObject);
    procedure SpeedButton18Click(Sender: TObject);
    procedure CmbName2Change(Sender: TObject);
    procedure CmbSurname2Change(Sender: TObject);
    procedure AdvIncomeDblClick(Sender: TObject);
    procedure AdvAgencyDblClick(Sender: TObject);
    procedure Label29Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure AdvExpenseDblClick(Sender: TObject);
    procedure AdvCompanyDblClick(Sender: TObject);

  private
    { Private declarations }
  public
    var
    PubSterlinAlis,PubEuroAlis,PubDollarAlis,PubSterlinSatis,PubEuroSatis,PubDollarSatis:Currency;

    procedure CreateParams(var Params: TCreateParams); override;
    { Public declarations }
  end;

var
 FrmReports: TFrmReports;

implementation

uses UntGlobal, UntDlgCustomer, UntProjectGlobal, UntCustomer, UntReservation2,
  UntCar;

{$R *.dfm}


procedure TFrmReports.AdvAgencyDblClick(Sender: TObject);
begin
if  assigned(FrmReservation2) then begin
if (FrmReservation2.WindowState = wsMinimized ) Then FrmReservation2.WindowState := wsNormal  ;
FrmReservation2.BringToFront;
exit;
end;


FrmReservation2:=TFrmReservation2.Create(Self);

FrmReservation2.SabitDegerler;
PubReservasyonId := Strtoint(AdvAgency.Cells[13,AdvAgency.Row]) ;
FrmReservation2.KayitGetir(AdvAgency.Cells[13,AdvAgency.Row]) ;

FrmReservation2.Show;
end;

procedure TFrmReports.AdvAgencyGetAlignment(Sender: TObject; ARow,
  ACol: Integer; var HAlign: TAlignment; var VAlign: TVAlignment);
begin

if ACol in [6,7,8,9] Then HAlign:=taRightJustify;


end;

procedure TFrmReports.AdvCompanyDblClick(Sender: TObject);
begin
if  assigned(FrmReservation2) then begin
if (FrmReservation2.WindowState = wsMinimized ) Then FrmReservation2.WindowState := wsNormal  ;
FrmReservation2.BringToFront;
exit;
end;


FrmReservation2:=TFrmReservation2.Create(Self);

FrmReservation2.SabitDegerler;
PubReservasyonId := Strtoint(AdvCompany.Cells[13,AdvCompany.Row]) ;
FrmReservation2.KayitGetir(AdvCompany.Cells[13,AdvCompany.Row]) ;

FrmReservation2.Show;
end;

procedure TFrmReports.AdvCustomerDblClick(Sender: TObject);
begin


if  assigned(FrmCustomer) then begin
if (FrmCustomer.WindowState = wsMinimized ) Then FrmCustomer.WindowState := wsNormal  ;
FrmCustomer.BringToFront;
exit;
end;

FrmCustomer:=TFrmCustomer.Create(self);

FrmCustomer.KayitGetir(AdvCustomer.Cells[11,AdvCustomer.Row]);

FrmCustomer.Show;


end;

procedure TFrmReports.AdvExpenseDblClick(Sender: TObject);
begin

if  assigned(FrmCar) then begin
if (FrmCar.WindowState = wsMinimized ) Then FrmCar.WindowState := wsNormal  ;
FrmCar.BringToFront;
exit;
end;

FrmCar:=TFrmCar.Create(Self);

FrmCar.ArabaGetir(AdvExpense.Cells[7,AdvExpense.Row]);

FrmCar.Show;



end;

procedure TFrmReports.AdvExpenseGetAlignment(Sender: TObject; ARow,
  ACol: Integer; var HAlign: TAlignment; var VAlign: TVAlignment);
begin
if Acol in [4,5,6] then HAlign := taRightJustify;
end;

procedure TFrmReports.AdvIncomeDblClick(Sender: TObject);
begin
if  assigned(FrmReservation2) then begin
if (FrmReservation2.WindowState = wsMinimized ) Then FrmReservation2.WindowState := wsNormal  ;
FrmReservation2.BringToFront;
exit;
end;


FrmReservation2:=TFrmReservation2.Create(Self);

FrmReservation2.SabitDegerler;
PubReservasyonId := Strtoint(AdvIncome.Cells[23,AdvIncome.Row]) ;
FrmReservation2.KayitGetir(AdvIncome.Cells[23,AdvIncome.Row]) ;

FrmReservation2.Show;
end;

procedure TFrmReports.AdvIncomeGetAlignment(Sender: TObject; ARow,
  ACol: Integer; var HAlign: TAlignment; var VAlign: TVAlignment);
begin
if Acol in [6,7,8,9,10,11,12,13,14,15,16,17,18,19] then HAlign := taRightJustify;
end;

procedure TFrmReports.AdvReservationDblClick(Sender: TObject);
begin

if  assigned(FrmReservation2) then begin
if (FrmReservation2.WindowState = wsMinimized ) Then FrmReservation2.WindowState := wsNormal  ;
FrmReservation2.BringToFront;
exit;
end;


FrmReservation2:=TFrmReservation2.Create(Self);

FrmReservation2.SabitDegerler;
PubReservasyonId := Strtoint(AdvReservation.Cells[25,AdvReservation.Row]) ;
FrmReservation2.KayitGetir(AdvReservation.Cells[25,AdvReservation.Row]) ;

FrmReservation2.Show;
end;

procedure TFrmReports.AdvReservationGetAlignment(Sender: TObject; ARow,
  ACol: Integer; var HAlign: TAlignment; var VAlign: TVAlignment);
begin
if ARow in [0,1] then begin
HAlign := taCenter;
VAlign := vtaBottom;
end;

end;

procedure TFrmReports.Button1Click(Sender: TObject);
var TmpSql:String;
i:integer;
begin

TmpSql:=' Select id,regno,model from car ';
Qry1.Close;
qry1.SQL.Clear;
qry1.SQL.Add(TmpSql);
qry1.Prepared;
qry1.Open;

for i:=1 to Qry1.RecordCount  do begin

TmpSql:=' Update Carinsurance set CarRegNo=:CarRegNo , CarModel=:CarModel where carid=:Carid ';
Qry2.Close;
qry2.SQL.Clear;
qry2.SQL.Add(TmpSql);
Qry2.Parameters.ParamByName('CarRegNo').Value := Qry1.FieldByName('RegNo').AsString;
Qry2.Parameters.ParamByName('CarModel').Value := Qry1.FieldByName('Model').AsString;
Qry2.Parameters.ParamByName('carid').Value    := Qry1.FieldByName('id').AsInteger;
qry2.Prepared;
qry2.ExecSQL;

TmpSql:=' Update CarSeyrusefer set CarRegNo=:CarRegNo , CarModel=:CarModel where carid=:Carid ';
Qry2.Close;
qry2.SQL.Clear;
qry2.SQL.Add(TmpSql);
Qry2.Parameters.ParamByName('CarRegNo').Value := Qry1.FieldByName('RegNo').AsString;
Qry2.Parameters.ParamByName('CarModel').Value := Qry1.FieldByName('Model').AsString;
Qry2.Parameters.ParamByName('carid').Value    := Qry1.FieldByName('id').AsInteger;
qry2.Prepared;
qry2.ExecSQL;

TmpSql:=' Update CarExpense set CarRegNo=:CarRegNo , CarModel=:CarModel where carid=:Carid ';
Qry2.Close;
qry2.SQL.Clear;
qry2.SQL.Add(TmpSql);
Qry2.Parameters.ParamByName('CarRegNo').Value := Qry1.FieldByName('RegNo').AsString;
Qry2.Parameters.ParamByName('CarModel').Value := Qry1.FieldByName('Model').AsString;
Qry2.Parameters.ParamByName('carid').Value    := Qry1.FieldByName('id').AsInteger;
qry2.Prepared;
qry2.ExecSQL;


Qry1.Next;
end;



showmessage('OK ... ');
end;

procedure TFrmReports.Button2Click(Sender: TObject);
Var TmpSql:String;
begin


TmpSql := 'Update Carinsurance set totalpriceSterlin=(thirdpartypriceSterlin+kaskopriceSterlin), ' +
'totalpriceEuro=(kaskopriceEuro+thirdpartypriceEuro),' +
'totalprice=(kaskoprice+thirdpartyprice)';


Qry1.Close;
Qry1.SQL.Clear;
Qry1.SQL.Add(TmpSql);
Qry1.ExecSql;


end;

procedure TFrmReports.CmbIncomeSelectChange(Sender: TObject);
var i:integer;
begin

if CmbIncomeSelect.ItemIndex = 0  then begin

CmbIncomeKriter.Clear;
Qry1.Close;
Qry1.SQL.Clear;
Qry1.SQL.Add('Select Distinct Model from Car order by Model ');
Qry1.Open;

for i := 1 to Qry1.RecordCount do begin
CmbIncomeKriter.Items.Add(qry1.FieldByName('Model').AsString) ;
qry1.Next;
end;

end;

if CmbIncomeSelect.ItemIndex = 1  then begin

CmbIncomeKriter.Clear;
Qry1.Close;
Qry1.SQL.Clear;
Qry1.SQL.Add('Select RegNo from Car order by RegNo ');
Qry1.Open;

for i := 1 to Qry1.RecordCount do begin
CmbIncomeKriter.Items.Add(qry1.FieldByName('RegNo').AsString) ;
qry1.Next;
end;

end;



end;

procedure TFrmReports.CmbKriter2Change(Sender: TObject);
var i:integer;
TmpSql:String;
begin
CmbReservationKriter.Clear;

if CmbKriter2.Text = 'Reservation No'  then Exit;
if CmbKriter2.Text = 'Internet Referance No'  then Exit;
if CmbKriter2.Text = 'Contract Number'  then Exit;
if CmbKriter2.Text = 'Payment Method'  then Exit;

if CmbKriter2.Text = 'Agency'  then
TmpSql:='Select AgencyName as Tmp from Agency order by AgencyName';

if CmbKriter2.Text = 'Car Model'  then
TmpSql:='Select Distinct Model as Tmp from Car order by Model';

if CmbKriter2.Text = 'Car Reg No'  then
TmpSql:='Select RegNo as Tmp from Car order by RegNo';

Qry1.Close;
Qry1.SQL.Clear;
Qry1.SQL.Add(TmpSql);
Qry1.Open;

for i := 1 to Qry1.RecordCount do begin
CmbReservationKriter.Items.Add(qry1.FieldByName('Tmp').AsString) ;
qry1.Next;
end;

end;

procedure TFrmReports.CmbKriter33KeyPress(Sender: TObject; var Key: Char);
begin
key  := BuyukHarfCombo(key,Sender as TComboBox);
end;

procedure TFrmReports.cmbKriter3Change(Sender: TObject);
var i:integer;
TmpSql:String;
begin

CmbKriter33.Clear;

if CmbKriter3.Text = 'Car Model'  then
TmpSql:='Select Distinct Model as Tmp from Car order by Model';

if CmbKriter3.Text = 'Car Reg No'  then
TmpSql:='Select RegNo as Tmp from Car order by RegNo';

Qry1.Close;
Qry1.SQL.Clear;
Qry1.SQL.Add(TmpSql);
Qry1.Open;

for i := 1 to Qry1.RecordCount do begin
CmbKriter33.Items.Add(qry1.FieldByName('Tmp').AsString) ;
qry1.Next;
end;


end;

procedure TFrmReports.cmbKriterChange(Sender: TObject);
begin
if cmbKriter.Text = 'Birth Date' then begin
TxtKriter.Visible := False;
PnlBirthDate.Visible:=True;
end
Else begin
TxtKriter.Visible := True;
PnlBirthDate.Visible:=False;
end;

end;

procedure TFrmReports.CmbName2Change(Sender: TObject);
begin
cmbsurname2.itemindex :=  cmbName2.itemindex;
end;

procedure TFrmReports.CmbReservationKriterKeyPress(Sender: TObject;
  var Key: Char);
begin
key  := BuyukHarfCombo(key,Sender as TComboBox);
end;

procedure TFrmReports.CmbReservationNameChange(Sender: TObject);
begin
CmbReservationSurname.ItemIndex :=  CmbReservationName.ItemIndex ;
end;

procedure TFrmReports.CmbReservationNameKeyPress(Sender: TObject;
  var Key: Char);
begin
key  := BuyukHarfCombo(key,Sender as TComboBox);
end;

procedure TFrmReports.CmbReservationSurnameChange(Sender: TObject);
begin
CmbReservationName.ItemIndex :=  CmbReservationSurname.ItemIndex ;
end;

procedure TFrmReports.CmbReservationSurnameKeyPress(Sender: TObject;
  var Key: Char);
begin
//key  := BuyukHarfCombo(key,Sender as TComboBox);
end;

procedure TFrmReports.CmbSurname2Change(Sender: TObject);
begin
cmbName2.itemindex :=  cmbsurName2.itemindex;
end;

procedure TFrmReports.CreateParams(var Params: TCreateParams);
begin
 inherited CreateParams(Params);
  Params.ExStyle   := Params.ExStyle or WS_EX_APPWINDOW;
  Params.WndParent := GetDesktopWindow;
end;

procedure TFrmReports.FormClose(Sender: TObject; var Action: TCloseAction);
begin
Action := caFree;
FrmReports:= nil;
end;

procedure TFrmReports.FormShow(Sender: TObject);
var i:integer;
begin


//  SetWindowPos(Handle, HWND_TOPMOST, Left, Top, Width, Height, SWP_NOACTIVATE or SWP_NOMOVE or SWP_NOSIZE);
PageControl1.TabIndex := 0;

DtSaat1.Format := 'HH:mm';
DtSaat2.Format := 'HH:mm';

CmbIncomeKriter.Clear;
CmbKriter33.Clear;

Qry1.Close;
Qry1.SQL.Clear;
Qry1.SQL.Add('Select Distinct Model from Car order by Model ');
Qry1.Open;

CmbIncomeKriter.Items.Add('');
for i := 1 to Qry1.RecordCount do begin
CmbIncomeKriter.Items.Add(qry1.FieldByName('Model').AsString) ;
CmbKriter33.Items.Add(qry1.FieldByName('Model').AsString) ;
qry1.Next;
end;

CmbReservationKriter.Clear;
CmbAgency.Clear;
Qry1.Close;
Qry1.SQL.Clear;
Qry1.SQL.Add('Select AgencyName as Tmp from Agency order by AgencyName ');
Qry1.Open;

for i := 1 to Qry1.RecordCount do begin
CmbReservationKriter.Items.Add(qry1.FieldByName('Tmp').AsString) ;
CmbAgency.Items.Add(qry1.FieldByName('Tmp').AsString) ;
qry1.Next;
end;

/////////////////////////////////////////////////////////////////////////////////
CmbCompany.Clear;
Qry1.Close;
Qry1.SQL.Clear;
Qry1.SQL.Add('Select CompanyName as Tmp from Company order by CompanyName ');
Qry1.Open;

for i := 1 to Qry1.RecordCount do begin
CmbCompany.Items.Add(qry1.FieldByName('Tmp').AsString) ;
qry1.Next;
end;






CmbReservationName.Clear;
CmbReservationSurname.Clear;
CmbReservationName2.Clear;
CmbReservationSurname2.Clear;
CmbTransferName.Clear;
CmbTransferSurName.Clear;

CmbName2.Clear;
CmbSurname2.Clear;

CmbEmail.Clear;

Qry1.Close;
Qry1.SQL.Clear;
Qry1.SQL.Add('Select Name, Surname,Email from Customer order by Surname');
Qry1.Open;

for i := 1 to Qry1.RecordCount do begin
CmbReservationName.Items.Add(qry1.FieldByName('Name').AsString) ;
CmbReservationSurname.Items.Add(qry1.FieldByName('Surname').AsString);
CmbReservationName2.Items.Add(qry1.FieldByName('Name').AsString) ;
CmbReservationSurname2.Items.Add(qry1.FieldByName('Surname').AsString);
CmbTransferName.Items.Add(qry1.FieldByName('Name').AsString) ;
CmbTransferSurName.Items.Add(qry1.FieldByName('Surname').AsString) ;
if qry1.FieldByName('email').AsString<>'' then
CmbEmail.Items.Add(qry1.FieldByName('email').AsString) ;
qry1.Next;
end;


Qry1.Close;
Qry1.SQL.Clear;
Qry1.SQL.Add('Select distinct Name2, Surname2  from Customer order by Surname');
Qry1.Open;
for i := 1 to Qry1.RecordCount do begin

CmbName2.Items.Add(qry1.FieldByName('Name2').AsString) ;
CmbSurname2.Items.Add(qry1.FieldByName('Surname2').AsString) ;
qry1.Next;
end;








DtCollect1.Date       := Date ;
DtCollect2.Date       := Date ;
DtDeliver1.Date       := Date ;
DtDeliver2.Date       := Date ;
DtCollect12.Date      := Date ;
DtCollect22.Date      := Date ;
DtDeliver12.Date      := Date ;
DtDeliver22.Date      := Date ;
DtCLDateFrom.Date     := Date ;
DtCLDateTo.Date       := Date ;
DtMRCDateFrom.Date    := Date ;
DtMRCDateTo.Date      := Date ;
DtArrival1.Date       := Date ;
DtArrival2.Date       := Date ;
DtDeparture1.Date     := Date ;
DtDeparture2.Date     := Date ;
Dt1.Date              := Date ;
Dt2.Date              := Date ;
DtIncomeCollect1.Date := Date ;
DtIncomeCollect2.Date := Date ;
DtAgency1.Date := Date ;
DtAgency2.Date := Date ;
DtE1.Date              := Date ;
DtE2.Date              := Date ;

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

qry1.Close;
qry1.SQL.Clear;
qry1.SQL.Add('select * from kur where tarih=:tarih and parabirimi=:parabirimi ' );
Qry1.Parameters.ParamByName('tarih').Value :=
IntToStr(YearOf(Date))+'-'+IntToStr(MonthOf(Date))+'-'+IntToStr(DayOf(Date));
Qry1.Parameters.ParamByName('parabirimi').Value := 'DOLLAR' ;
qry1.Prepared;
qry1.open;

PubDollarAlis  := Qry1.FieldByName('alis').AsCurrency  ;
PubDollarSatis := Qry1.FieldByName('satis').AsCurrency ;
end;


procedure TFrmReports.Image10Click(Sender: TObject);
var TmpSql,TmpCurr:String;
i:integer;
TmpPaymentAmount:Currency;
begin
ProgramKullanmaDurumu:=ProgramKullanmaDurumu+1;
TmpPaymentAmount:=0;

AdvReservation2.ClearRows(1,AdvReservation2.RowCount-1);
AdvReservation2.RowCount := 3;

TmpSql := 'Select * from Reservation where id<>0 ' ;

if ChkDeleted2.Checked = True  then TmpSql:=TmpSql + ' and Durum=''Deleted'' '
eLSE TmpSql:=TmpSql + ' and Durum<>''Deleted'' ' ;

if CmbRCurrency2.Text <> 'ALL' then
TmpSql:=TmpSql + ' and Currency=:Currency '  ;

if CmbKriter22.Text = 'Reservation No'  then  TmpSql:=TmpSql + ' and id like :Kriter '  ;
if CmbKriter22.Text = 'Internet Referance No'  then TmpSql:=TmpSql + ' and ReservationNo like :Kriter '  ;
if CmbKriter22.Text = 'Contract Number' then TmpSql:=TmpSql + ' and ContractNumber like :Kriter '  ;
if CmbKriter22.Text = 'Agency'          then TmpSql:=TmpSql + ' and Agency like :Kriter '  ;
if CmbKriter22.Text = 'Car Model'       then TmpSql:=TmpSql + ' and CarModel like :Kriter '  ;
if CmbKriter22.Text = 'Car Reg No'      then TmpSql:=TmpSql + ' and CarRegNo like :Kriter '  ;
if CmbKriter22.Text = 'Payment Method'  then TmpSql:=TmpSql + ' and PaymentMethod like :Kriter '  ;

TmpSql:=TmpSql + ' and Name like :Name '  ;
TmpSql:=TmpSql + ' and Surname like :Surname ';

if ChkCarDeliver2.Checked = True  then
TmpSql:=TmpSql + ' and BirakilacakTarih Between :DtDeliver1 and :DtDeliver2 ' ;

if ChkCarCollect2.Checked = True  then
TmpSql:=TmpSql + ' and AlinacakTarih Between :DtCollect1 and :DtCollect2 ' ;

TmpSql:=TmpSql + ' Order By BirakilacakTarih ';

Qry1.Close;
qry1.SQL.Clear;
qry1.SQL.Add(TmpSql);
if CmbRCurrency2.Text <> 'ALL' then
Qry1.Parameters.ParamByName('Currency').Value := CmbRCurrency2.Text ;
Qry1.Parameters.ParamByName('Kriter').Value   := CmbReservationKriter2.Text+ '%' ;
Qry1.Parameters.ParamByName('Name').Value     := CmbReservationName2.Text+ '%' ;
Qry1.Parameters.ParamByName('Surname').Value  := CmbReservationSurname2.Text+ '%' ;

if ChkCarDeliver2.Checked = True  then begin
Qry1.Parameters.ParamByName('DtDeliver1').Value :=
IntToStr(YearOf(DtDeliver12.Date))+'-'+IntToStr(MonthOf(DtDeliver12.Date))+'-'+IntToStr(DayOf(DtDeliver12.Date));
Qry1.Parameters.ParamByName('DtDeliver2').Value :=
IntToStr(YearOf(DtDeliver22.Date))+'-'+IntToStr(MonthOf(DtDeliver22.Date))+'-'+IntToStr(DayOf(DtDeliver22.Date));
end;

if ChkCarCollect2.Checked = True  then begin
Qry1.Parameters.ParamByName('DtCollect1').Value :=
IntToStr(YearOf(DtCollect12.Date))+'-'+IntToStr(MonthOf(DtCollect12.Date))+'-'+IntToStr(DayOf(DtCollect12.Date));
Qry1.Parameters.ParamByName('DtCollect2').Value :=
IntToStr(YearOf(DtCollect22.Date))+'-'+IntToStr(MonthOf(DtCollect22.Date))+'-'+IntToStr(DayOf(DtCollect22.Date));
end;

qry1.Prepared;
qry1.Open;

if qry1.RecordCount = 0 Then Exit;

AdvReservation2.RowCount := qry1.RecordCount + 1 ;

for i:=1 to qry1.RecordCount do Begin
TmpCurr := Qry1.FieldByName('Currency').AsString;
if TmpCurr = 'EURO' Then TmpCurr := '€' ;
if TmpCurr = 'STERLIN' Then TmpCurr := '£' ;
if TmpCurr = 'DOLLAR'  Then TmpCurr := '$' ;

AdvReservation2.Cells[1,i]  := Qry1.FieldByName('id').AsString ;
AdvReservation2.Cells[2,i]  := DateToStr(Qry1.FieldByName('BirakilacakTarih').AsDateTime)+' '+TimeToStr(Qry1.FieldByName('BirakilacakSaat').AsDateTime) ;
AdvReservation2.Cells[3,i]  := Qry1.FieldByName('birakilacakYer').AsString ;
AdvReservation2.Cells[4,i]  := DateToStr(Qry1.FieldByName('alinacakTarih').AsDateTime)+' '+TimeToStr(Qry1.FieldByName('alinacakSaat').AsDateTime) ;
AdvReservation2.Cells[5,i]  := Qry1.FieldByName('AlinacakYer').AsString ;
AdvReservation2.Cells[6,i]  := Qry1.FieldByName('CarModel').AsString ;
AdvReservation2.Cells[7,i]  := Qry1.FieldByName('CarRegNo').AsString ;
AdvReservation2.Cells[8,i]  := Qry1.FieldByName('Name').AsString ;
AdvReservation2.Cells[9,i]  := Qry1.FieldByName('Surname').AsString ;
AdvReservation2.Cells[10,i] := Qry1.FieldByName('LocalNumber').AsString ;
AdvReservation2.Cells[11,i] := Qry1.FieldByName('Email').AsString ;
AdvReservation2.Cells[12,i] := Qry1.FieldByName('Agency').AsString ;
AdvReservation2.Cells[13,i] := FormatFloat('#,##0.00',Qry1.FieldByName('TotalComission').Asfloat)+' '+TmpCurr ;
AdvReservation2.Cells[14,i] := FormatFloat('#,##0.00',Qry1.FieldByName('OutstandingBalance').Asfloat)+' '+TmpCurr ;

AdvReservation2.Cells[15,i]:= FormatFloat('#,##0.00',Qry1.FieldByName('PaidAmount1').AsCurrency+Qry1.FieldByName('PaidAmount2').AsCurrency+
Qry1.FieldByName('PaidAmount3').AsCurrency+Qry1.FieldByName('PaidAmount4').AsCurrency)+' '+TmpCurr ;
TmpPaymentAmount := TmpPaymentAmount +
(Qry1.FieldByName('PaidAmount1').AsCurrency+Qry1.FieldByName('PaidAmount2').AsCurrency+
Qry1.FieldByName('PaidAmount3').AsCurrency+Qry1.FieldByName('PaidAmount4').AsCurrency);


AdvReservation2.Cells[16,i] := Qry1.FieldByName('id').AsString ;

Qry1.Next;
End;
AdvReservation2.AutoNumberCol(0);

AdvReservation2.AddRow;
AdvReservation2.Cells[15,AdvReservation2.RowCount-1]  :=  FormatFloat('#,##0.00',TmpPaymentAmount)+' '+TmpCurr ;
AdvReservation2.Colors[15,AdvReservation2.RowCount-1] := clYellow ;

End;


procedure TFrmReports.Image1Click(Sender: TObject);
var TmpSql:String;
i,x:integer;
begin
ProgramKullanmaDurumu:=ProgramKullanmaDurumu+1;

AdvCustomer.ClearRows(1,AdvCustomer.RowCount-1);
AdvCustomer.RowCount := 2;

AdvCustomer.Cells[1,0] := 'Name' ;
AdvCustomer.Cells[2,0] := 'Surname' ;
AdvCustomer.Cells[4,0] := 'Address' ;
AdvCustomer.Cells[5,0] := 'Passport' ;
AdvCustomer.Cells[6,0] := 'Email' ;
AdvCustomer.Cells[7,0] := 'Birth Date' ;
AdvCustomer.Cells[8,0] := 'License No' ;
AdvCustomer.Cells[9,0] := 'Local Number' ;
AdvCustomer.Cells[10,0] := 'Local Address' ;

TmpSql := 'Select Name,Surname,Address,PassportId,Email,CheckedBirthDate,BirthDate,LicenseNo,LocalNumber,LocalAddress,'+
'Name2,Surname2,PassportId2,CheckedBirthDate2,BirthDate2,LicenseNo2,id '+
'from Customer where id<>0 ' ;

{
if cmbKriter.Text = 'License No' Then
TmpSql:=TmpSql + ' and LicenseNo like :LicenseNo '  ;
}

if cmbKriter.Text = 'Name' Then begin
TmpSql:=TmpSql + ' and (Name  like :Name '  ;
TmpSql:=TmpSql + ' or Name2 like :Name2 ) '  ;
end;

if cmbKriter.Text = 'Surname' Then begin
TmpSql:=TmpSql + ' and (Surname like :Surname '  ;
TmpSql:=TmpSql + ' or Surname2 like :Surname2) '  ;
end;

{
if cmbKriter.Text = 'Birth Date'  then
TmpSql:=TmpSql + ' and (MONTH(BirthDate) >= :MBd1) And (MONTH(BirthDate) <= :MBd2) AND (DAY(BirthDate) >= :Dbd1) AND (DAY(BirthDate) <= :Dbd2) '  ;
}
TmpSql:=TmpSql + ' Order By Surname ' ;

Qry1.Close;
qry1.SQL.Clear;
qry1.SQL.Add(TmpSql);
{
if cmbKriter.Text = 'License No' Then
Qry1.Parameters.ParamByName('LicenseNo').Value := TxtKriter.Text+ '%' ;
}
if cmbKriter.Text = 'Name' Then Begin
Qry1.Parameters.ParamByName('Name').Value := TxtKriter.Text+ '%' ;
Qry1.Parameters.ParamByName('Name2').Value := TxtKriter.Text+ '%' ;
End;

if cmbKriter.Text = 'Surname' Then begin
Qry1.Parameters.ParamByName('Surname').Value  := TxtKriter.Text+ '%' ;
Qry1.Parameters.ParamByName('Surname2').Value := TxtKriter.Text+ '%' ;
end;
{
if cmbKriter.Text = 'Birth Date'  then begin
Qry1.Parameters.ParamByName('Mbd1').Value := CmbMbd1.ItemIndex + 1;
Qry1.Parameters.ParamByName('Mbd2').Value := CmbMbd2.ItemIndex + 1;
Qry1.Parameters.ParamByName('Dbd1').Value := CmbDbd1.Text ;
Qry1.Parameters.ParamByName('Dbd2').Value := CmbDbd2.Text ;
end;
}
qry1.Prepared;
qry1.Open;

if qry1.RecordCount = 0 Then Exit;

x:=1;
for i:=1 to qry1.RecordCount do Begin

if i<>1 then Begin
AdvCustomer.AddRow; x:=x+1;
end;


AdvCustomer.Cells[1,x] := Qry1.FieldByName('Name').AsString ;
AdvCustomer.Cells[2,x] := Qry1.FieldByName('Surname').AsString ;
AdvCustomer.Cells[3,x] := '';
AdvCustomer.Cells[4,x] := Qry1.FieldByName('Address').AsString ;
AdvCustomer.Cells[5,x] := Qry1.FieldByName('PassportId').AsString ;
AdvCustomer.Cells[6,x] := Qry1.FieldByName('Email').AsString ;
if Qry1.FieldByName('CheckedBirthDate').AsString='Y' then
AdvCustomer.Cells[7,x] := DateToStr(Qry1.FieldByName('BirthDate').AsDateTime) ;
AdvCustomer.Cells[8,x] := Qry1.FieldByName('LicenseNo').AsString ;
AdvCustomer.Cells[9,x] := Qry1.FieldByName('LocalNumber').AsString ;
AdvCustomer.Cells[10,x] := Qry1.FieldByName('LocalAddress').AsString ;
AdvCustomer.Cells[11,x] := Qry1.FieldByName('id').AsString ;

//////////////////////////SECOND DRIVER/////////////////////////////////////////
if Qry1.FieldByName('Name2').AsString <>'' then  begin

AdvCustomer.AddRow; x:=x+1;

AdvCustomer.Cells[1,x] := Qry1.FieldByName('Name2').AsString ;
AdvCustomer.Cells[2,x] := Qry1.FieldByName('Surname2').AsString ;
AdvCustomer.Cells[3,x] := 'Second Driver';
AdvCustomer.Cells[4,x] := Qry1.FieldByName('Address').AsString ;
AdvCustomer.Cells[5,x] := Qry1.FieldByName('PassportId2').AsString ;
AdvCustomer.Cells[6,x] := Qry1.FieldByName('Email').AsString ;
if Qry1.FieldByName('CheckedBirthDate2').AsString='Y' then
AdvCustomer.Cells[7,x] := DateToStr(Qry1.FieldByName('BirthDate2').AsDateTime) ;
AdvCustomer.Cells[8,x] := Qry1.FieldByName('LicenseNo2').AsString ;
AdvCustomer.Cells[9,x] := Qry1.FieldByName('LocalNumber').AsString ;
AdvCustomer.Cells[10,x] := Qry1.FieldByName('LocalAddress').AsString ;
AdvCustomer.Cells[11,x] := Qry1.FieldByName('id').AsString ;
end;
///////////////////////////////////////////////////////////////////

qry1.Next;
end;

AdvCustomer.AutoNumberCol(0);
end;






procedure TFrmReports.Image2Click(Sender: TObject);
var TmpSql:String;
i:integer;
begin
ProgramKullanmaDurumu:=ProgramKullanmaDurumu+1;

AdvCar.ClearRows(1,AdvCar.RowCount-1);
AdvCar.RowCount := 2;

AdvCar.Cells[1,0] := 'Rental Days' ;
AdvCar.Cells[2,0] := 'Car Model' ;
AdvCar.Cells[3,0] := 'Car Reg No' ;

TmpSql :='SELECT CarModel, CarRegNo, SUM(DATEDIFF(alinacakTarih,BirakilacakTarih )) AS Fark '+
'FROM Reservation where durum<>''Deleted'' and  ' ;

if cmbKriter3.Text = 'Car Model' Then
TmpSql:=TmpSql + '  CarModel like :CarModel '  ;
if cmbKriter3.Text = 'Car Reg No' Then
TmpSql:=TmpSql + '  CarRegNo like :CarRegNo '  ;


if ChkMRCDateFrom.Checked = True  then
TmpSql:=TmpSql + ' and BirakilacakTarih <= :alinacakTarih ' ;

if ChkMRCDateTo.Checked = True  then
TmpSql:=TmpSql + ' and alinacakTarih >= :BirakilacakTarih ' ;

TmpSql:=TmpSql + 'GROUP BY CarModel, CarRegNo ' +
                 'ORDER BY Fark DESC ' ;

Qry1.Close;
qry1.SQL.Clear;
qry1.SQL.Add(TmpSql);

if ChkMRCDateFrom.Checked = True  then
Qry1.Parameters.ParamByName('BirakilacakTarih').Value := IntToStr(YearOf(DtMRCDateFrom.Date))+'-'+
                                            IntToStr(MonthOf(DtMRCDateFrom.Date))+'-'+
                                            IntToStr(DayOf(DtMRCDateFrom.Date));
if ChkMRCDateTo.Checked = True  then
Qry1.Parameters.ParamByName('alinacakTarih').Value := IntToStr(YearOf(DtMRCDateTo.Date))+'-'+
                                            IntToStr(MonthOf(DtMRCDateTo.Date))+'-'+
                                            IntToStr(DayOf(DtMRCDateTo.Date));



if cmbKriter3.Text = 'Car Model' Then
Qry1.Parameters.ParamByName('CarModel').Value := CmbKriter33.Text+ '%' ;
if cmbKriter3.Text = 'Car Reg No' Then
Qry1.Parameters.ParamByName('CarRegNo').Value := CmbKriter33.Text+ '%' ;
qry1.Prepared;
qry1.Open;

if qry1.RecordCount = 0 Then Exit;

AdvCar.RowCount := qry1.RecordCount + 1 ;

for i:=1 to qry1.RecordCount do Begin

AdvCar.Cells[1,i] := Qry1.FieldByName('fark').AsString ;
AdvCar.Cells[2,i] := Qry1.FieldByName('CarModel').AsString ;
AdvCar.Cells[3,i] := Qry1.FieldByName('CarRegNo').AsString ;
qry1.Next;
end;

AdvCar.AutoNumberCol(0);
end;


procedure TFrmReports.Image4Click(Sender: TObject);
var TmpSql,TmpCurr:String;
i,rr:integer;
TmpTotal:Currency;
begin
ProgramKullanmaDurumu:=ProgramKullanmaDurumu+1;
TmpTotal:=0;
AdvTransfer.ClearRows(1,AdvTransfer.RowCount-1);
AdvTransfer.RowCount := 2;


TmpSql := 'Select DeparturePrice,ArrivalPrice,ArrivalFlightNo,AgencyName,Driver,CheckedDeparture,'+
'DepartureNotes,ArrivalNotes,ArrivalCollectFrom,ArrivalDestination,Currency,Name,Surname,'+
'ContactNumber,CheckedArrival,ArrivalTimeChecked,ArrivalDate,ArrivalTime,DepartureTimeChecked,'+
'ArrivalTimeChecked,DepartureDate,DepartureTime,DepartureCollectFrom,DepartureDestination,'+
'id from Transfer where id<>0 ' ;

if CmbTCurrency.Text <> 'ALL' then
TmpSql:=TmpSql + ' and Currency=:Currency '  ;

TmpSql:=TmpSql + ' and Name like :Name '  ;
TmpSql:=TmpSql + ' and Surname like :Surname ';

if ChkArrival.Checked = True  then
TmpSql:=TmpSql + ' and ArrivalDate Between :DtArrival1 and :DtArrival2 ' ;

if ChkDeparture.Checked = True  then
TmpSql:=TmpSql + ' and DepartureDate Between :DtDeparture1 and :DtDeparture2 ' ;

TmpSql:=TmpSql + ' Order By DepartureDate ';

Qry1.Close;
qry1.SQL.Clear;
qry1.SQL.Add(TmpSql);
if CmbTCurrency.Text <> 'ALL' then
Qry1.Parameters.ParamByName('Currency').Value := CmbTCurrency.Text ;
Qry1.Parameters.ParamByName('Name').Value     := CmbTransferName.Text+ '%' ;
Qry1.Parameters.ParamByName('Surname').Value  := CmbTransferSurName.Text+ '%' ;

if ChkArrival.Checked = True  then begin
Qry1.Parameters.ParamByName('DtArrival1').Value :=
IntToStr(YearOf(DtArrival1.Date))+'-'+IntToStr(MonthOf(DtArrival1.Date))+'-'+IntToStr(DayOf(DtArrival1.Date));
Qry1.Parameters.ParamByName('DtArrival2').Value :=
IntToStr(YearOf(DtArrival2.Date))+'-'+IntToStr(MonthOf(DtArrival2.Date))+'-'+IntToStr(DayOf(DtArrival2.Date));
end;

if ChkDeparture.Checked = True  then begin
Qry1.Parameters.ParamByName('DtDeparture1').Value :=
IntToStr(YearOf(DtDeparture1.Date))+'-'+IntToStr(MonthOf(DtDeparture1.Date))+'-'+IntToStr(DayOf(DtDeparture1.Date));
Qry1.Parameters.ParamByName('DtDeparture2').Value :=
IntToStr(YearOf(DtDeparture2.Date))+'-'+IntToStr(MonthOf(DtDeparture2.Date))+'-'+IntToStr(DayOf(DtDeparture2.Date));
end;

qry1.Prepared;
qry1.Open;

if qry1.RecordCount <> 0  then
AdvTransfer.RowCount := qry1.RecordCount + 1;

rr:= qry1.RecordCount  ;

for i:=1 to qry1.RecordCount do Begin
TmpCurr := Qry1.FieldByName('Currency').AsString;
if TmpCurr = 'EURO'    Then TmpCurr := '€' ;
if TmpCurr = 'STERLIN' Then TmpCurr := '£' ;
if TmpCurr = 'DOLLAR'  Then TmpCurr := '$' ;

AdvTransfer.Cells[1,i]  := Qry1.FieldByName('Name').AsString ;
AdvTransfer.Cells[2,i]  := Qry1.FieldByName('Surname').AsString ;
AdvTransfer.Cells[3,i]  := Qry1.FieldByName('ContactNumber').AsString ;

if Qry1.FieldByName('CheckedArrival').AsString = 'Y' then begin
if Qry1.FieldByName('ArrivalTimeChecked').AsString = 'Y' then
AdvTransfer.Cells[4,i]  := Qry1.FieldByName('ArrivalDate').AsString+' - '+Qry1.FieldByName('ArrivalTime').AsString
else
AdvTransfer.Cells[4,i]  := Qry1.FieldByName('ArrivalDate').AsString;
AdvTransfer.Cells[5,i]  := Qry1.FieldByName('ArrivalCollectFrom').AsString ;
AdvTransfer.Cells[6,i] := Qry1.FieldByName('ArrivalDestination').AsString ;
end;

if Qry1.FieldByName('CheckedDeparture').AsString = 'Y' then begin
if Qry1.FieldByName('DepartureTimeChecked').AsString = 'Y' then
AdvTransfer.Cells[7,i]  := Qry1.FieldByName('DepartureDate').AsString+' - '+Qry1.FieldByName('DepartureTime').AsString
else
AdvTransfer.Cells[7,i]  := Qry1.FieldByName('DepartureDate').AsString;

AdvTransfer.Cells[8,i]  := Qry1.FieldByName('DepartureCollectFrom').AsString ;
AdvTransfer.Cells[9,i]  := Qry1.FieldByName('DepartureDestination').AsString ;
end;

AdvTransfer.Cells[10,i] := Qry1.FieldByName('Driver').AsString ;
AdvTransfer.Cells[11,i] := Qry1.FieldByName('AgencyName').AsString ;
AdvTransfer.Cells[12,i] := Qry1.FieldByName('ArrivalFlightNo').AsString ;
AdvTransfer.Cells[13,i] := FormatFloat('#,##0.00',Qry1.FieldByName('ArrivalPrice').AsCurrency)+' '+TmpCurr ;
AdvTransfer.Cells[14,i] := FormatFloat('#,##0.00',Qry1.FieldByName('DeparturePrice').AsCurrency)+' '+TmpCurr ;
AdvTransfer.Cells[15,i] := FormatFloat('#,##0.00',(Qry1.FieldByName('DeparturePrice').AsCurrency+Qry1.FieldByName('ArrivalPrice').AsCurrency))+' '+TmpCurr ;

AdvTransfer.Cells[16,i] := Qry1.FieldByName('DepartureNotes').AsString ;
AdvTransfer.Cells[17,i] := Qry1.FieldByName('ArrivalNotes').AsString ;



TmpTotal := TmpTotal +  Qry1.FieldByName('DeparturePrice').AsCurrency+Qry1.FieldByName('ArrivalPrice').AsCurrency ;

AdvTransfer.Cells[18,i]:= Qry1.FieldByName('id').AsString ;
Qry1.Next;
End;


///////////////////////////////////////////////////////////////////////////////////////////////////////////////

TmpSql := 'Select TaxiTimeDeliver,TaxiDateDeliver,TaxiDeliverFrom,TaxiDeliverTo,PaxsPickUp,ChkTaxiTimeCollect,ChkTaxiTimeDeliver,'+
'Name,Surname,ContactNumber,Agency,Currency,TaxiPickUp,TaxiDateCollect,TaxiTimeCollect,TaxiCollectFrom,TaxiDeliverTo,FlightNumber,id, '+
' TaxiCollectTo,Notes from Reservation where (TaxiDeliverFrom<>'''' or TaxiCollectFrom<>'''') ' ;

if CmbTCurrency.Text <> 'ALL' then
TmpSql:=TmpSql + ' and Currency=:Currency '  ;

TmpSql:=TmpSql + ' and Name like :Name '  ;
TmpSql:=TmpSql + ' and Surname like :Surname ';

if ChkArrival.Checked = True  then
TmpSql:=TmpSql + ' and TaxiDateDeliver Between :DtArrival1 and :DtArrival2 ' ;

if ChkDeparture.Checked = True  then
TmpSql:=TmpSql + ' and TaxiDateCollect Between :DtDeparture1 and :DtDeparture2 ' ;


TmpSql:=TmpSql + ' order by TaxiDateDeliver, TaxiTimeDeliver ' ;
qry1.Close;
qry1.SQL.Clear;
qry1.SQL.Add(TmpSql);
if CmbTCurrency.Text <> 'ALL' then
Qry1.Parameters.ParamByName('Currency').Value := CmbTCurrency.Text ;
Qry1.Parameters.ParamByName('Name').Value     := CmbTransferName.Text+ '%' ;
Qry1.Parameters.ParamByName('Surname').Value  := CmbTransferSurName.Text+ '%' ;

if ChkArrival.Checked = True  then begin
Qry1.Parameters.ParamByName('DtArrival1').Value :=
IntToStr(YearOf(DtArrival1.Date))+'-'+IntToStr(MonthOf(DtArrival1.Date))+'-'+IntToStr(DayOf(DtArrival1.Date));
Qry1.Parameters.ParamByName('DtArrival2').Value :=
IntToStr(YearOf(DtArrival2.Date))+'-'+IntToStr(MonthOf(DtArrival2.Date))+'-'+IntToStr(DayOf(DtArrival2.Date));
end;

if ChkDeparture.Checked = True  then begin
Qry1.Parameters.ParamByName('DtDeparture1').Value :=
IntToStr(YearOf(DtDeparture1.Date))+'-'+IntToStr(MonthOf(DtDeparture1.Date))+'-'+IntToStr(DayOf(DtDeparture1.Date));
Qry1.Parameters.ParamByName('DtDeparture2').Value :=
IntToStr(YearOf(DtDeparture2.Date))+'-'+IntToStr(MonthOf(DtDeparture2.Date))+'-'+IntToStr(DayOf(DtDeparture2.Date));
end;

qry1.Prepared;
qry1.Open;

for i:=1 to Qry1.RecordCount do begin

AdvTransfer.AddRow;
rr:=rr+1;

AdvTransfer.Cells[1,rr]  := Qry1.FieldByName('Name').AsString ;
AdvTransfer.Cells[2,rr]  := Qry1.FieldByName('Surname').AsString ;
AdvTransfer.Cells[3,rr]  := Qry1.FieldByName('ContactNumber').AsString ;

if Qry1.FieldByName('TaxiDeliverFrom').AsString <> '' then begin
if Qry1.FieldByName('ChkTaxiTimeDeliver').AsString = 'Y' then
AdvTransfer.Cells[4,rr]  := Qry1.FieldByName('TaxiDateDeliver').AsString+' - '+Qry1.FieldByName('TaxiTimeDeliver').AsString
else
AdvTransfer.Cells[4,rr]  := Qry1.FieldByName('TaxiDateDeliver').AsString;
AdvTransfer.Cells[5,rr]  := Qry1.FieldByName('TaxiDeliverFrom').AsString ;
AdvTransfer.Cells[6,rr]  := Qry1.FieldByName('TaxiDeliverTo').AsString ;
end;

if Qry1.FieldByName('TaxiCollectFrom').AsString <> '' then begin
if Qry1.FieldByName('ChkTaxiTimeCollect').AsString = 'Y' then
AdvTransfer.Cells[7,rr]  := Qry1.FieldByName('TaxiDateCollect').AsString+' - '+Qry1.FieldByName('TaxiTimeCollect').AsString
else
AdvTransfer.Cells[7,rr]  := Qry1.FieldByName('TaxiDateCollect').AsString;
AdvTransfer.Cells[8,rr]  := Qry1.FieldByName('TaxiCollectFrom').AsString ;
AdvTransfer.Cells[9,rr]  := Qry1.FieldByName('TaxiCollectTo').AsString ;
end;

AdvTransfer.Cells[10,rr] := '';
AdvTransfer.Cells[11,rr] := Qry1.FieldByName('Agency').AsString ;
AdvTransfer.Cells[12,rr] := Qry1.FieldByName('FlightNumber').AsString ;
AdvTransfer.Cells[13,rr] := '';
AdvTransfer.Cells[14,rr] := '';
AdvTransfer.Cells[15,rr] := '';

AdvTransfer.Cells[16,rr] := Qry1.FieldByName('Notes').AsString ;
AdvTransfer.Cells[17,rr] := '';


AdvTransfer.Cells[18,rr] := Qry1.FieldByName('id').AsString ;
Qry1.Next;
End;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////



AdvTransfer.AutoNumberCol(0);

AdvTransfer.AddRow;
AdvTransfer.Cells[15,AdvTransfer.RowCount-1] := FormatFloat('#,##0.00',TmpTotal)+' '+TmpCurr ;
AdvTransfer.Colors[15,AdvTransfer.RowCount-1] := clYellow ;

End;

procedure TFrmReports.Image5Click(Sender: TObject);
var TmpSql:String;
i:integer;
begin
ProgramKullanmaDurumu:=ProgramKullanmaDurumu+1;

AdvLoyaltiest.ClearRows(1,AdvLoyaltiest.RowCount-1);
AdvLoyaltiest.RowCount := 2;


AdvLoyaltiest.Cells[1,0] := 'Rental Days' ;

if RbByReservation.Checked = True then
AdvLoyaltiest.Cells[1,0] := 'No of reservations' ;

AdvLoyaltiest.Cells[2,0] := 'Name' ;
AdvLoyaltiest.Cells[3,0] := 'Surname' ;


if RbByDay.Checked = True then begin

TmpSql := '' +
'SELECT Name, Surname, SUM(DATEDIFF(alinacakTarih,BirakilacakTarih)) AS Fark '+
'FROM  Reservation where durum<>''Deleted''  ' ;

if chkCLDateFrom.Checked = True  then
TmpSql:=TmpSql + ' and BirakilacakTarih <= :alinacakTarih ' ;

if chkCLDateTo.Checked = True  then
TmpSql:=TmpSql + ' and alinacakTarih >= :BirakilacakTarih ' ;

TmpSql := TmpSql + 'GROUP BY Name, Surname ' ;
TmpSql := TmpSql + 'ORDER BY Fark DESC ' ;

end;

if RbByReservation.Checked = True then begin

TmpSql := '' +
'SELECT Name, Surname, Count(*) AS Fark '+
'FROM  Reservation where id<>0 ' ;

if chkCLDateFrom.Checked = True  then
TmpSql:=TmpSql + ' and BirakilacakTarih >= :BirakilacakTarih ' ;

if chkCLDateTo.Checked = True  then
TmpSql:=TmpSql + ' and alinacakTarih <= :alinacakTarih ' ;


TmpSql := TmpSql + 'GROUP BY Name, Surname ' ;
TmpSql := TmpSql + 'ORDER BY Fark DESC ' ;





end;

Qry1.Close;
qry1.SQL.Clear;
qry1.SQL.Add(TmpSql);

if chkCLDateFrom.Checked = True  then
Qry1.Parameters.ParamByName('BirakilacakTarih').Value := IntToStr(YearOf(DtCLDateFrom.Date))+'-'+
                                            IntToStr(MonthOf(DtCLDateFrom.Date))+'-'+
                                            IntToStr(DayOf(DtCLDateFrom.Date));

if chkCLDateTo.Checked = True  then
Qry1.Parameters.ParamByName('alinacakTarih').Value := IntToStr(YearOf(DtCLDateTo.Date))+'-'+
                                            IntToStr(MonthOf(DtCLDateTo.Date))+'-'+
                                            IntToStr(DayOf(DtCLDateTo.Date));

Qry1.Prepared ;
qry1.Open;


if qry1.RecordCount = 0 Then Exit;

AdvLoyaltiest.RowCount := qry1.RecordCount + 1 ;

for i:=1 to qry1.RecordCount do Begin

AdvLoyaltiest.Cells[1,i] := Qry1.FieldByName('fark').AsString ;
AdvLoyaltiest.Cells[2,i] := Qry1.FieldByName('Name').AsString ;
AdvLoyaltiest.Cells[3,i] := Qry1.FieldByName('Surname').AsString ;

Qry1.Next;
End;

AdvLoyaltiest.AutoNumberCol(0);

End;


procedure TFrmReports.Image6Click(Sender: TObject);
var TmpSql,TmpSql2:String;
TmpTotal,TmpEuro,TmpTl,TmpDollar,TmpSterlin,TmpPetrolStg,TmpPetrolEuro,TmpPetrolDollar,TmpPetrolTL,TmpTransferTL,
TmpTransferSterlin,TmpTransferEuro,TmpTransferDollar,TmpCarTotalincome,TmpTotalTL,TmpTotalEuro,TmpTotalSterlin,
TmpTotalDollar:Currency;
i,rr:integer;
begin
ProgramKullanmaDurumu:=ProgramKullanmaDurumu+1;

AdvIncome.ClearRows(1,AdvIncome.RowCount-1);
AdvIncome.RowCount := 2;

AdvIncome.Cells[1,0]  := 'Car Model'        ;
AdvIncome.Cells[2,0]  := 'Car Reg No'       ;
AdvIncome.Cells[3,0]  := 'Name Company'     ;
AdvIncome.Cells[4,0]  := 'Customer Name'    ;
AdvIncome.Cells[5,0]  := 'Customer Surname' ;


AdvIncome.Cells[6,0]  := 'Petrol TL'        ;
AdvIncome.Cells[7,0]  := 'Petrol Euro'      ;
AdvIncome.Cells[8,0]  := 'Petrol Stg'       ;
AdvIncome.Cells[9,0]  := 'Petrol Dollar'    ;

AdvIncome.Cells[10,0]  := 'Transfer TL'      ;
AdvIncome.Cells[11,0]  := 'Transfer Euro'    ;
AdvIncome.Cells[12,0]  := 'Transfer Sterlin' ;
AdvIncome.Cells[13,0]  := 'Transfer Dollar'  ;

AdvIncome.Cells[14,0]  := 'Car TL'     ;
AdvIncome.Cells[15,0] := 'Car Euro'     ;
AdvIncome.Cells[16,0] := 'Car Sterlin'     ;
AdvIncome.Cells[17,0] := 'Car Dollar'     ;

AdvIncome.Cells[18,0] := 'Car Total Income TL'     ;
AdvIncome.ColWidths[18] := 150 ;
AdvIncome.Cells[19,0] := 'Car Total Income Euro'     ;
AdvIncome.ColWidths[19] := 150 ;
AdvIncome.Cells[20,0] := 'Car Total Income Sterlin'     ;
AdvIncome.ColWidths[20] := 150 ;
AdvIncome.Cells[21,0] := 'Car Total Income Dollar'     ;
AdvIncome.ColWidths[21] := 150 ;



AdvIncome.Cells[22,0] := 'Company Income'     ;

TmpSql := 'Select id,Company,CompanyIncome,CarModel,CarRegNo,Name,Surname,Petrol,GeneralTotal,TaxiPickUp,TaxiDropOff,Currency '+
'from Reservation where durum<>''Deleted''  ' ;
                                                      //and currency='''+CmbiCurrency.Text+'''
if ChkIncomeCollect.Checked = True  then
TmpSql := TmpSql+ ' and BirakilacakTarih between '+
' '''+IntToStr(YearOf(DtIncomeCollect1.Date))+'-'+IntToStr(MonthOf(DtIncomeCollect1.Date))+'-'+IntToStr(DayOf(DtIncomeCollect1.Date))+''' and '+
' '''+IntToStr(YearOf(DtIncomeCollect2.Date))+'-'+IntToStr(MonthOf(DtIncomeCollect2.Date))+'-'+IntToStr(DayOf(DtIncomeCollect2.Date))+''' ' ;

if CmbIncomeSelect.Text = 'Car Model'  then
TmpSql:=TmpSql + ' and CarModel like '''+CmbIncomeKriter.Text+'%'' '  ;
if CmbIncomeSelect.Text = 'Car Reg No'  then
TmpSql:=TmpSql + ' and CarRegNo like '''+CmbIncomeKriter.Text+'%'' '  ;

if ChkTransfer.Checked = True then
TmpSql:=TmpSql + ' and (TaxiPickUp<>0 or TaxiDropOff<>0) '  ;

if ChkPetrol.Checked = True then
TmpSql:=TmpSql + ' and Petrol<>0 '  ;

Qry1.Close;
qry1.SQL.Clear;
qry1.SQL.Add(TmpSql);
qry1.Open;

if qry1.RecordCount = 0 Then Exit;

TmpTotal:=0;
TmpEuro:=0;
TmpDollar:=0;
TmpSterlin:=0;
TmpTl:=0;
TmpPetrolStg:=0;
TmpPetrolTL:=0;
TmpTransferTL:=0;
TmpTransferSterlin:=0;
TmpTransferEuro:=0;
TmpTransferDollar:=0;
TmpTotalTL:=0;
TmpTotalEuro:=0;
TmpTotalSterlin:=0;
TmpTotalDollar:=0;

AdvIncome.RowCount := qry1.RecordCount + 1 ;

for i:=1 to qry1.RecordCount do Begin
AdvIncome.Cells[1,i] := Qry1.FieldByName('CarModel').AsString ;
AdvIncome.Cells[2,i] := Qry1.FieldByName('CarRegNo').AsString ;
AdvIncome.Cells[3,i] := Qry1.FieldByName('Company').AsString ;
AdvIncome.Cells[4,i] := Qry1.FieldByName('Name').AsString ;
AdvIncome.Cells[5,i] := Qry1.FieldByName('Surname').AsString ;


if Qry1.FieldByName('Currency').AsString ='TL' Then begin
AdvIncome.Cells[6,i] := FormatCurr(',0.00',Qry1.FieldByName('Petrol').AsCurrency) ;
TmpPetrolTL := TmpPetrolTL + Qry1.FieldByName('Petrol').AsCurrency;
end; AdvIncome.Colors[6,i]:=clSilver;



if Qry1.FieldByName('Currency').AsString ='EURO' Then begin
AdvIncome.Cells[7,i] := FormatCurr(',0.00',Qry1.FieldByName('Petrol').AsCurrency) ;
TmpPetrolEuro := TmpPetrolEuro + Qry1.FieldByName('Petrol').AsCurrency;
end;   AdvIncome.Colors[7,i]:=clSilver;

if Qry1.FieldByName('Currency').AsString ='STERLIN' Then begin
AdvIncome.Cells[8,i] := FormatCurr(',0.00',Qry1.FieldByName('Petrol').AsCurrency) ;
TmpPetrolStg := TmpPetrolStg + Qry1.FieldByName('Petrol').AsCurrency;
end; AdvIncome.Colors[8,i]:=clSilver;

if Qry1.FieldByName('Currency').AsString ='DOLLAR' Then begin
AdvIncome.Cells[9,i] := FormatCurr(',0.00',Qry1.FieldByName('Petrol').AsCurrency) ;
TmpPetrolDollar := TmpPetrolDollar + Qry1.FieldByName('Petrol').AsCurrency;
end; AdvIncome.Colors[9,i]:=clSilver;



if Qry1.FieldByName('Currency').AsString ='TL' Then begin
AdvIncome.Cells[10,i] := FormatCurr(',0.00',Qry1.FieldByName('TaxiPickUp').AsCurrency+Qry1.FieldByName('TaxiDropOff').AsCurrency) ;
TmpTransferTL := TmpTransferTL + Qry1.FieldByName('TaxiPickUp').AsCurrency+Qry1.FieldByName('TaxiDropOff').AsCurrency;
end;

if Qry1.FieldByName('Currency').AsString ='EURO' Then begin
AdvIncome.Cells[11,i] := FormatCurr(',0.00',Qry1.FieldByName('TaxiPickUp').AsCurrency+Qry1.FieldByName('TaxiDropOff').AsCurrency) ;
TmpTransferEuro := TmpTransferEuro + Qry1.FieldByName('TaxiPickUp').AsCurrency+Qry1.FieldByName('TaxiDropOff').AsCurrency;
end;

if Qry1.FieldByName('Currency').AsString ='STERLIN' Then begin
AdvIncome.Cells[12,i] := FormatCurr(',0.00',Qry1.FieldByName('TaxiPickUp').AsCurrency+Qry1.FieldByName('TaxiDropOff').AsCurrency) ;
TmpTransferSterlin := TmpTransferSterlin + Qry1.FieldByName('TaxiPickUp').AsCurrency+Qry1.FieldByName('TaxiDropOff').AsCurrency;
end;

if Qry1.FieldByName('Currency').AsString ='DOLLAR' Then begin
AdvIncome.Cells[13,i] := FormatCurr(',0.00',Qry1.FieldByName('TaxiPickUp').AsCurrency+Qry1.FieldByName('TaxiDropOff').AsCurrency) ;
TmpTransferDollar := TmpTransferDollar + Qry1.FieldByName('TaxiPickUp').AsCurrency+Qry1.FieldByName('TaxiDropOff').AsCurrency;
end;

if Qry1.FieldByName('Currency').AsString ='TL' Then begin
AdvIncome.Cells[14,i] := FormatCurr(',0.00',Qry1.FieldByName('GeneralTotal').AsCurrency) ;
TmpTl := TmpTl + Qry1.FieldByName('GeneralTotal').AsCurrency ;
end;  AdvIncome.Colors[14,i]:=clSilver;

if Qry1.FieldByName('Currency').AsString ='EURO' Then begin
AdvIncome.Cells[15,i] := FormatCurr(',0.00',Qry1.FieldByName('GeneralTotal').AsCurrency) ;
TmpEuro := TmpEuro + Qry1.FieldByName('GeneralTotal').AsCurrency ;
end;  AdvIncome.Colors[15,i]:=clSilver;

if Qry1.FieldByName('Currency').AsString ='STERLIN' Then begin
AdvIncome.Cells[16,i] := FormatCurr(',0.00',Qry1.FieldByName('GeneralTotal').AsCurrency) ;
TmpSterlin := TmpSterlin + Qry1.FieldByName('GeneralTotal').AsCurrency ;
end; AdvIncome.Colors[16,i]:=clSilver;

if Qry1.FieldByName('Currency').AsString ='DOLLAR' Then begin
AdvIncome.Cells[17,i] := FormatCurr(',0.00',Qry1.FieldByName('GeneralTotal').AsCurrency) ;
TmpDollar := TmpDollar + Qry1.FieldByName('GeneralTotal').AsCurrency ;
end; AdvIncome.Colors[17,i]:=clSilver;




TmpCarTotalincome :=
qry1.FieldByName('GeneralTotal').AsCurrency -
(Qry1.FieldByName('Petrol').AsCurrency+Qry1.FieldByName('TaxiPickUp').AsCurrency+Qry1.FieldByName('TaxiDropOff').AsCurrency) ;

if Qry1.FieldByName('Currency').AsString ='TL' Then begin
AdvIncome.Cells[18,i] :=  FormatCurr(',0.00',TmpCarTotalincome) ;
TmpTotalTL := TmpTotalTL + TmpCarTotalincome ;
end;

if Qry1.FieldByName('Currency').AsString ='EURO' Then begin
AdvIncome.Cells[19,i] :=  FormatCurr(',0.00',TmpCarTotalincome) ;
TmpTotalEuro := TmpTotalEuro + TmpCarTotalincome ;
end;

if Qry1.FieldByName('Currency').AsString ='STERLIN' Then begin
AdvIncome.Cells[20,i] :=  FormatCurr(',0.00',TmpCarTotalincome) ;
TmpTotalSterlin := TmpTotalSterlin + TmpCarTotalincome ;
end;

if Qry1.FieldByName('Currency').AsString ='DOLLAR' Then begin
AdvIncome.Cells[21,i] :=  FormatCurr(',0.00',TmpCarTotalincome) ;
TmpTotalDollar := TmpTotalDollar + TmpCarTotalincome;
end;


AdvIncome.Cells[22,i] := FormatCurr(',0.00',Qry1.FieldByName('CompanyIncome').AsCurrency) ;

AdvIncome.Cells[23,i] :=Qry1.FieldByName('id').Asstring;
rr:=i;
Qry1.Next;
End;

AdvIncome.AutoNumberCol(0);

AdvIncome.AddRow ;
rr:=rr+1;


AdvIncome.Cells[6,rr]:= FormatCurr(',0.00',TmpPetrolTL);
AdvIncome.Colors[6,rr]:=clYellow ;

AdvIncome.Cells[7,rr]:= FormatCurr(',0.00',TmpPetrolEuro);
AdvIncome.Colors[7,rr]:=clYellow ;

AdvIncome.Cells[8,rr]:= FormatCurr(',0.00',TmpPetrolStg);
AdvIncome.Colors[8,rr]:=clYellow ;

AdvIncome.Cells[9,rr]:= FormatCurr(',0.00',TmpPetrolDollar);
AdvIncome.Colors[9,rr]:=clYellow ;


AdvIncome.Cells[10,rr]:= FormatCurr(',0.00',TmpTransferTL);
AdvIncome.Colors[10,rr]:=clYellow ;

AdvIncome.Cells[11,rr]:= FormatCurr(',0.00',TmpTransferEuro);
AdvIncome.Colors[11,rr]:=clYellow ;

AdvIncome.Cells[12,rr]:= FormatCurr(',0.00',TmpTransferSterlin);
AdvIncome.Colors[12,rr]:=clYellow ;

AdvIncome.Cells[13,rr]:= FormatCurr(',0.00',TmpTransferDollar);
AdvIncome.Colors[13,rr]:=clYellow ;


AdvIncome.Cells[14,rr]:= FormatCurr(',0.00',TmpTl);
AdvIncome.Colors[14,rr]:=clYellow ;

AdvIncome.Cells[15,rr]:= FormatCurr(',0.00',TmpEuro);
AdvIncome.Colors[15,rr]:=clYellow ;

AdvIncome.Cells[16,rr]:= FormatCurr(',0.00',TmpSterlin);
AdvIncome.Colors[16,rr]:=clYellow ;

AdvIncome.Cells[17,rr]:= FormatCurr(',0.00',TmpDollar);
AdvIncome.Colors[17,rr]:=clYellow ;

AdvIncome.Cells[18,rr]:= FormatCurr(',0.00',TmpTotalTL);
AdvIncome.Colors[18,rr]:=clYellow ;

AdvIncome.Cells[19,rr]:= FormatCurr(',0.00',TmpTotalEuro);
AdvIncome.Colors[19,rr]:=clYellow ;

AdvIncome.Cells[20,rr]:= FormatCurr(',0.00',TmpTotalSterlin);
AdvIncome.Colors[20,rr]:=clYellow ;

AdvIncome.Cells[21,rr]:= FormatCurr(',0.00',TmpTotalDollar);
AdvIncome.Colors[21,rr]:=clYellow ;
End;




procedure TFrmReports.Image7Click(Sender: TObject);
var TmpSql,TmpCurr:String;
i,x,z,t:integer;
DateBirakilacak,DateBirakilacak1,DateAlinacak,DateAlinacak1:TDateTime;
TimeBirakilacak,TimeBirakilacak1,TimeAlinacak,TimeAlinacak1:TDateTime;
TmpTimeBirakilacak,TmpTimeAlinacak: integer;

begin

ProgramKullanmaDurumu:=ProgramKullanmaDurumu+1;
x:=0;
AdvEmpty.ClearRows(1,AdvEmpty.RowCount-1);
AdvEmpty.RowCount := 2;

TmpSql := 'Select RegNo,Model,Type,id from Car where sold<>1 ' ;
if CmbEmptyKriter.Text = 'Model' then
TmpSql := TmpSql + '  and Model like :Kriter ' ;
if CmbEmptyKriter.Text = 'Reg No' then
TmpSql := TmpSql + '  and RegNo like :Kriter ' ;
if CmbEmptyKriter.Text = 'Type' then
TmpSql := TmpSql + '  and Type like :Kriter ' ;


Qry1.Close;
qry1.SQL.Clear;
qry1.SQL.Add(TmpSql);

Qry1.Parameters.ParamByName('Kriter').Value := TxtEmptyKriter.Text+ '%' ;

Qry1.Prepared;
Qry1.Open;

for i:=1 to Qry1.RecordCount  do begin

TmpSql := 'Select BirakilacakTarih,BirakilacakSaat,alinacakTarih,AlinacakSaat from Reservation where durum<>''Deleted'' and carid=:carid ' ;
Qry2.Close;
qry2.SQL.Clear;
qry2.SQL.Add(TmpSql);
Qry2.Parameters.ParamByName('carid').Value :=  Qry1.FieldByName('id').AsString;
qry2.Prepared;
Qry2.Open;
z:=0;
for t:=1 to Qry2.RecordCount  do begin
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
DateBirakilacak  :=
EncodeDateTime(YearOf(Dt1.Date),MonthOf(Dt1.Date),DayOf(Dt1.Date),HourOf(DtSaat1.Time),MinuteOf(DtSaat1.Time),0,0) ;
DateBirakilacak1 :=
EncodeDateTime(YearOf(Qry2.FieldByName('BirakilacakTarih').AsDateTime),MonthOf(Qry2.FieldByName('BirakilacakTarih').AsDateTime),DayOf(Qry2.FieldByName('BirakilacakTarih').AsDateTime),
HourOf(Qry2.FieldByName('BirakilacakSaat').AsDateTime),MinuteOf(Qry2.FieldByName('BirakilacakSaat').AsDateTime),0,0) ;
DateAlinacak  :=
EncodeDateTime(YearOf(Dt2.Date),MonthOf(Dt2.Date),DayOf(Dt2.Date),HourOf(DtSaat2.Time),MinuteOf(DtSaat2.Time),0,0) ;
DateAlinacak1 :=
EncodeDateTime(YearOf(Qry2.FieldByName('alinacakTarih').AsDateTime),MonthOf(Qry2.FieldByName('alinacakTarih').AsDateTime),DayOf(Qry2.FieldByName('alinacakTarih').AsDateTime),
HourOf(Qry2.FieldByName('AlinacakSaat').AsDateTime),MinuteOf(Qry2.FieldByName('AlinacakSaat').AsDateTime),0,0) ;

if ( DateBirakilacak <= DateAlinacak1 ) and ( DateAlinacak >= DateBirakilacak1 ) Then z:=1;
Qry2.Next;
end;

if z <> 1 then begin
if Qry1.FieldByName('RegNo').AsString<>AdvEmpty.Cells[1,x] then begin


x:=x+1; if x<>1 then AdvEmpty.AddRow;
AdvEmpty.Cells[1,x]:= Qry1.FieldByName('RegNo').AsString;
AdvEmpty.Cells[2,x]:= Qry1.FieldByName('Type').AsString;
AdvEmpty.Cells[3,x]:= Qry1.FieldByName('Model').AsString;
end;
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

end;

Qry1.Next;
end;

AdvEmpty.AutoNumberCol(0);

End;

procedure TFrmReports.Image9Click(Sender: TObject);
var TmpSql,TmpCurr:String;
i,x:integer;
TmpComission,TmpDollar,TmpSterlin,TmpEuro,TmpTl:Currency;
TmpTComission,TmpTDollar,TmpTSterlin,TmpTEuro,TmpTTl,TmpTotalDays:Currency;
begin

ProgramKullanmaDurumu:=ProgramKullanmaDurumu+1;
TmpComission:=0;
AdvAgency.ClearRows(1,AdvAgency.RowCount-1);
AdvAgency.RowCount := 2;

TmpSql := 'Select id,Agency,TotalComission,Currency,ReservationDate,Name,Surname,TotalDays,BirakilacakTarih,AlinacakTarih '+
' from Reservation where durum<>''Deleted'' and agency like :agency '  ;

if ChkAgency.Checked = True  then
TmpSql:=TmpSql + ' and BirakilacakTarih<=:Dt2 ' ;
if ChkAgency.Checked = True  then
TmpSql:=TmpSql + ' and AlinacakTarih>=:Dt1 ' ;

TmpSql:=TmpSql + ' Order By BirakilacakTarih ';

Qry1.Close;
qry1.SQL.Clear;
qry1.SQL.Add(TmpSql);
Qry1.Parameters.ParamByName('Agency').Value := CmbAgency.Text+'%' ;
if ChkAgency.Checked = True  then
Qry1.Parameters.ParamByName('Dt1').Value :=
IntToStr(YearOf(DtAgency1.Date))+'-'+IntToStr(MonthOf(DtAgency1.Date))+'-'+IntToStr(DayOf(DtAgency1.Date));
if ChkAgency.Checked = True  then
Qry1.Parameters.ParamByName('Dt2').Value :=
IntToStr(YearOf(DtAgency2.Date))+'-'+IntToStr(MonthOf(DtAgency2.Date))+'-'+IntToStr(DayOf(DtAgency2.Date));
qry1.Prepared;
qry1.Open;

if qry1.RecordCount = 0 Then Exit;

x:=0;
TmpTTl:=0;
TmpTDollar:=0;
TmpTSterlin:=0;
TmpTEuro := 0;
TmpTotalDays:=0;


for i:=1 to qry1.RecordCount do Begin

if Qry1.FieldByName('Agency').AsString = '' then begin
Qry1.Next;
Continue;
end;

if x<>0 Then AdvAgency.AddRow;
x:=x+1;

TmpCurr := Qry1.FieldByName('Currency').AsString;
//if TmpCurr = 'EURO' Then TmpCurr := '€' ;
//if TmpCurr = 'STERLIN' Then TmpCurr := '£' ;
//if TmpCurr = 'DOLLAR'  Then TmpCurr := '$' ;

AdvAgency.Cells[1,x] := Qry1.FieldByName('id').AsString ;
AdvAgency.Cells[2,x] := Qry1.FieldByName('ReservationDate').AsString ;
AdvAgency.Cells[3,x] := Qry1.FieldByName('Name').AsString ;
AdvAgency.Cells[4,x] := Qry1.FieldByName('Surname').AsString ;
AdvAgency.Cells[5,x] := Qry1.FieldByName('Agency').AsString ;

AdvAgency.Cells[6,x] := DateToStr(Qry1.FieldByName('BirakilacakTarih').AsDateTime) ;
AdvAgency.Cells[7,x] := DateToStr(Qry1.FieldByName('AlinacakTarih').AsDateTime) ;


AdvAgency.Cells[8,x] := Qry1.FieldByName('TotalDays').AsString ;
TmpTotalDays:=TmpTotalDays+Qry1.FieldByName('TotalDays').AsCurrency;

if TmpCurr = 'EURO' then begin
TmpEuro    := Qry1.FieldByName('TotalComission').AsCurrency ;
if PubEuroAlis=0 then begin
TmpDollar  := 0 ;
TmpSterlin := 0 ;
TmpTl      := 0 ;
end
Else begin
TmpDollar  := (TmpEuro*PubEuroAlis)/PubDollarSatis ;
TmpSterlin := (TmpEuro*PubEuroAlis)/PubSterlinSatis ;
TmpTl      := (TmpEuro*PubEuroAlis) ;
end;
end;

if TmpCurr = 'DOLLAR'  then begin
TmpDollar  := Qry1.FieldByName('TotalComission').AsCurrency ;
if PubDollarAlis=0 then begin
TmpEuro    := 0 ;
TmpSterlin := 0 ;
TmpTl      := 0 ;
end
Else
Begin
TmpEuro    := (TmpDollar*PubDollarAlis)/PubEuroSatis ;
TmpSterlin := (TmpDollar*PubDollarAlis)/PubSterlinSatis;
TmpTl      := (TmpDollar*PubDollarAlis) ;
End;
end;

if TmpCurr = 'STERLIN' then begin
TmpSterlin := Qry1.FieldByName('TotalComission').AsCurrency ;
if PubSterlinAlis=0 then begin
TmpDollar  := 0;
TmpEuro    := 0;
TmpTl      := 0 ;
end
Else begin
TmpDollar  := (TmpSterlin*PubSterlinAlis)/PubDollarSatis ;
TmpEuro    := (TmpSterlin*PubSterlinAlis)/PubEuroSatis ;
TmpTl      := (TmpSterlin*PubSterlinAlis) ;
end;
end;

if TmpCurr = 'TL'  then begin
TmpTl      := Qry1.FieldByName('TotalComission').AsCurrency ;
if PubSterlinAlis=0 then begin
TmpSterlin := 0 ;
TmpDollar  := 0 ;
TmpEuro    := 0 ;
end
Else
Begin
TmpSterlin := TmpTl / PubSterlinSatis;
TmpDollar  := TmpTl / PubDollarSatis;
TmpEuro    := TmpTl / PubEuroSatis;
End;
end;

AdvAgency.Cells[9,x] := FormatFloat('#,##0.00',TmpTl) ;
AdvAgency.Cells[10,x] := FormatFloat('#,##0.00',TmpSterlin) ;
AdvAgency.Cells[11,x] := FormatFloat('#,##0.00',TmpEuro) ;
AdvAgency.Cells[12,x] := FormatFloat('#,##0.00',TmpDollar) ;
AdvAgency.Cells[13,x] :=  Qry1.FieldByName('id').AsString ; ;

TmpTTl      := TmpTTl      + TmpTl ;
TmpTDollar  := TmpTDollar  + TmpDollar ;
TmpTSterlin := TmpTSterlin + TmpSterlin ;
TmpTEuro    := TmpTEuro    + TmpEuro ;

Qry1.Next;
End;
AdvAgency.AutoNumberCol(0);


AdvAgency.AddRow;
AdvAgency.Cells[9,AdvAgency.RowCount-1]  :=  FormatFloat('#,##0.00',TmpTTl) ;
AdvAgency.Colors[9,AdvAgency.RowCount-1] := clYellow ;
AdvAgency.Cells[10,AdvAgency.RowCount-1]  :=  FormatFloat('#,##0.00',TmpTSterlin) ;
AdvAgency.Colors[10,AdvAgency.RowCount-1] := clYellow ;
AdvAgency.Cells[11,AdvAgency.RowCount-1]  :=  FormatFloat('#,##0.00',TmpTEuro) ;
AdvAgency.Colors[11,AdvAgency.RowCount-1] := clYellow ;
AdvAgency.Cells[12,AdvAgency.RowCount-1]  :=  FormatFloat('#,##0.00',TmpTDollar) ;
AdvAgency.Colors[12,AdvAgency.RowCount-1] := clYellow ;

CurrTotalDays.Value := TmpTotalDays;


End;



procedure TFrmReports.ImgistClick(Sender: TObject);
var TmpSql,TmpCurr:String;
i:integer;
TmpPaymentAmount:Currency;
begin
ProgramKullanmaDurumu:=ProgramKullanmaDurumu+1;
TmpPaymentAmount:=0;
AdvReservation.ClearRows(1,AdvReservation.RowCount-1);
AdvReservation.RowCount := 3;

AdvReservation.RowHeights[0]:=20;
AdvReservation.RowHeights[1]:=20;
for i:=1 to 5 do
AdvReservation.MergeCells(i,0,1,2);

AdvReservation.MergeCells(13,0,1,2);
AdvReservation.MergeCells(14,0,1,2);

for i:=18 to 22 do
AdvReservation.MergeCells(i,0,1,2);

AdvReservation.MergeCells(10,0,3,1);
AdvReservation.MergeCells(15,0,3,1);
AdvReservation.Cells[10,1] := 'Date';
AdvReservation.Colors[10,1] := clBtnFace;
AdvReservation.Cells[11,1] := 'From';
AdvReservation.Colors[11,1] := clBtnFace;
AdvReservation.Cells[12,1] := 'To';
AdvReservation.Colors[12,1] := clBtnFace;
AdvReservation.Cells[15,1] := 'Date';
AdvReservation.Colors[15,1] := clBtnFace;
AdvReservation.Cells[16,1] := 'From';
AdvReservation.Colors[16,1] := clBtnFace;
AdvReservation.Cells[17,1] := 'To';
AdvReservation.Colors[17,1] := clBtnFace;
              //(Select c.email from customer as C where C.id=R.CustomerId ) as  Tmpemail,
TmpSql := 'Select   '+
' R.* from Reservation as R where id<>0 ';


if ChkDeleted1.Checked = True  then TmpSql:=TmpSql + ' and Durum=''Deleted'' '
eLSE TmpSql:=TmpSql + ' and Durum<>''Deleted'' ' ;



if CmbRCurrency.Text <> 'ALL' then
TmpSql:=TmpSql + ' and Currency=:Currency '  ;

if CmbKriter2.Text = 'Reservation No'         then  TmpSql:=TmpSql + ' and id like :Kriter '  ;
if CmbKriter2.Text = 'Internet Referance No'  then TmpSql:=TmpSql  + ' and ReservationNo like :Kriter '  ;
if CmbKriter2.Text = 'Contract Number'        then TmpSql:=TmpSql  + ' and ContractNumber like :Kriter '  ;
if CmbKriter2.Text = 'Agency'                 then TmpSql:=TmpSql  + ' and Agency like :Kriter '  ;
if CmbKriter2.Text = 'Car Model'              then TmpSql:=TmpSql  + ' and CarModel like :Kriter '  ;
if CmbKriter2.Text = 'Car Reg No'             then TmpSql:=TmpSql  + ' and CarRegNo like :Kriter '  ;
if CmbKriter2.Text = 'Payment Method'         then TmpSql:=TmpSql  + ' and PaymentMethod like :Kriter '  ;

TmpSql:=TmpSql + ' and Name like :Name '  ;
TmpSql:=TmpSql + ' and Surname like :Surname ';

if Trim(cmbname2.text)<>'' then TmpSql:=TmpSql + ' and Name2 like :Name2 '  ;
if Trim(cmbsurname2.text)<>'' then TmpSql:=TmpSql + ' and surname2 like :surname2 '  ;

if ChkCarDeliver.Checked = True  then
TmpSql:=TmpSql + ' and BirakilacakTarih Between :DtDeliver1 and :DtDeliver2 ' ;

if ChkCarCollect.Checked = True  then
TmpSql:=TmpSql + ' and AlinacakTarih Between :DtCollect1 and :DtCollect2 ' ;


if Trim(cmbemail.text)<>'' then TmpSql:=TmpSql + ' and email like :email '  ;


TmpSql:=TmpSql + ' Order By BirakilacakTarih ';

Qry1.Close;
qry1.SQL.Clear;
qry1.SQL.Add(TmpSql);
if CmbRCurrency.Text <> 'ALL' then
Qry1.Parameters.ParamByName('Currency').Value := CmbRCurrency.Text ;
Qry1.Parameters.ParamByName('Kriter').Value   := CmbReservationKriter.Text+ '%' ;
Qry1.Parameters.ParamByName('Name').Value     := CmbReservationName.Text+ '%' ;
Qry1.Parameters.ParamByName('Surname').Value  := CmbReservationSurname.Text+ '%' ;


if Trim(cmbname2.text)<>'' then Qry1.Parameters.ParamByName('Name2').Value := cmbname2.text +'%';
if Trim(cmbsurname2.text)<>'' then Qry1.Parameters.ParamByName('Surname2').Value := cmbsurname2.text +'%';


if ChkCarDeliver.Checked = True  then begin
Qry1.Parameters.ParamByName('DtDeliver1').Value :=
IntToStr(YearOf(DtDeliver1.Date))+'-'+IntToStr(MonthOf(DtDeliver1.Date))+'-'+IntToStr(DayOf(DtDeliver1.Date));
Qry1.Parameters.ParamByName('DtDeliver2').Value :=
IntToStr(YearOf(DtDeliver2.Date))+'-'+IntToStr(MonthOf(DtDeliver2.Date))+'-'+IntToStr(DayOf(DtDeliver2.Date));
end;

if ChkCarCollect.Checked = True  then begin
Qry1.Parameters.ParamByName('DtCollect1').Value :=
IntToStr(YearOf(DtCollect1.Date))+'-'+IntToStr(MonthOf(DtCollect1.Date))+'-'+IntToStr(DayOf(DtCollect1.Date));
Qry1.Parameters.ParamByName('DtCollect2').Value :=
IntToStr(YearOf(DtCollect2.Date))+'-'+IntToStr(MonthOf(DtCollect2.Date))+'-'+IntToStr(DayOf(DtCollect2.Date));
end;


if Trim(cmbemail.text)<>'' then Qry1.Parameters.ParamByName('email').Value := cmbemail.text +'%';


qry1.Prepared;
qry1.Open;

if qry1.RecordCount = 0 Then Exit;

AdvReservation.RowCount := qry1.RecordCount + 2 ;

for i:=2 to qry1.RecordCount+1 do Begin
TmpCurr := Qry1.FieldByName('Currency').AsString;
if TmpCurr = 'EURO' Then TmpCurr := '€' ;
if TmpCurr = 'STERLIN' Then TmpCurr := '£' ;
if TmpCurr = 'DOLLAR'  Then TmpCurr := '$' ;

AdvReservation.Cells[1,i] := Qry1.FieldByName('id').AsString ;
AdvReservation.Cells[2,i] := Qry1.FieldByName('CarModel').AsString ;
AdvReservation.Cells[3,i] := Qry1.FieldByName('CarRegNo').AsString ;
AdvReservation.Cells[4,i] := Qry1.FieldByName('Name').AsString ;
AdvReservation.Cells[5,i] := Qry1.FieldByName('Surname').AsString ;
AdvReservation.Cells[6,i] := Qry1.FieldByName('Name2').AsString ;
AdvReservation.Cells[7,i] := Qry1.FieldByName('Surname2').AsString ;
//AdvReservation.Cells[7,i] := Qry1.FieldByName('Tmpemail').AsString ;

AdvReservation.Cells[8,i] := Qry1.FieldByName('LocalNumber').AsString ;
AdvReservation.Cells[9,i] := Qry1.FieldByName('email').AsString ;

if Qry1.FieldByName('TaxiDeliverFrom').AsString<>'' then begin
AdvReservation.Cells[10,i] := DateToStr(Qry1.FieldByName('TaxiDateDeliver').AsDateTime)+' '+TimeToStr(Qry1.FieldByName('TaxiTimeDeliver').AsDateTime) ;
AdvReservation.Cells[11,i] := Qry1.FieldByName('TaxiDeliverFrom').AsString ;
AdvReservation.Cells[12,i]:= Qry1.FieldByName('TaxiDeliverTo').AsString ;
end;

AdvReservation.Cells[13,i]:= DateToStr(Qry1.FieldByName('BirakilacakTarih').AsDateTime)+' '+TimeToStr(Qry1.FieldByName('BirakilacakSaat').AsDateTime) ;
AdvReservation.Cells[14,i]:= Qry1.FieldByName('birakilacakYer').AsString ;

if Qry1.FieldByName('TaxiCollectFrom').AsString<>'' then begin
AdvReservation.Cells[15,i]:= DateToStr(Qry1.FieldByName('TaxiDateCollect').AsDateTime)+' '+TimeToStr(Qry1.FieldByName('TaxiTimeCollect').AsDateTime) ;
AdvReservation.Cells[16,i]:= Qry1.FieldByName('TaxiCollectFrom').AsString ;
AdvReservation.Cells[17,i]:= Qry1.FieldByName('TaxiCollectTo').AsString ;
end;

AdvReservation.Cells[18,i]:= DateToStr(Qry1.FieldByName('alinacakTarih').AsDateTime)+' '+TimeToStr(Qry1.FieldByName('alinacakSaat').AsDateTime) ;
AdvReservation.Cells[19,i]:= Qry1.FieldByName('AlinacakYer').AsString ;
AdvReservation.Cells[20,i]:= Qry1.FieldByName('Agency').AsString ;
AdvReservation.Cells[21,i]:= FormatFloat('#,##0.00',Qry1.FieldByName('TotalComission').Asfloat)+' '+TmpCurr ;

AdvReservation.Cells[22,i]:= FormatFloat('#,##0.00',Qry1.FieldByName('OutstandingBalance').Asfloat)+' '+TmpCurr ;
AdvReservation.Cells[23,i]:= FormatFloat('#,##0.00',Qry1.FieldByName('PaidAmount1').AsCurrency+Qry1.FieldByName('PaidAmount2').AsCurrency+
Qry1.FieldByName('PaidAmount3').AsCurrency+Qry1.FieldByName('PaidAmount4').AsCurrency)+' '+TmpCurr ;

TmpPaymentAmount := TmpPaymentAmount +
(Qry1.FieldByName('PaidAmount1').AsCurrency+Qry1.FieldByName('PaidAmount2').AsCurrency+
Qry1.FieldByName('PaidAmount3').AsCurrency+Qry1.FieldByName('PaidAmount4').AsCurrency);

AdvReservation.Cells[24,i]:=
FormatFloat('#,##0.00',
(Qry1.FieldByName('PaidAmount1').AsCurrency+Qry1.FieldByName('PaidAmount2').AsCurrency+
Qry1.FieldByName('PaidAmount3').AsCurrency+Qry1.FieldByName('PaidAmount4').AsCurrency+
Qry1.FieldByName('OutstandingBalance').AsCurrency) -
Qry1.FieldByName('TotalComission').AsCurrency );


AdvReservation.Cells[25,i]:= Qry1.FieldByName('id').AsString ;
Qry1.Next;
End;
AdvReservation.AutoNumberCol(0);

AdvReservation.AddRow;
AdvReservation.Cells[23,AdvReservation.RowCount-1]:=  FormatFloat('#,##0.00',TmpPaymentAmount)+' '+TmpCurr ;
AdvReservation.Colors[23,AdvReservation.RowCount-1] := clYellow ;
End;

procedure TFrmReports.Label19Click(Sender: TObject);
var TmpSql,TmpSql2:String;
TmpTotalTL,TmpTotalS,TmpTotalE:Currency;
i,rr:integer;
begin
ProgramKullanmaDurumu:=ProgramKullanmaDurumu+1;

AdvExpense.ClearRows(1,AdvExpense.RowCount-1);
AdvExpense.RowCount := 2;

AdvExpense.Cells[1,0] := ' '     ;
AdvExpense.Cells[2,0] := 'Car Model'     ;
AdvExpense.Cells[3,0] := 'Car Reg No'    ;
AdvExpense.Cells[4,0] := 'Price TL'      ;
AdvExpense.Cells[5,0] := 'Price Sterlin' ;
AdvExpense.Cells[6,0] := 'Price Euro'    ;

/////////////////////////////////////////////////////////////////
TmpSql2:='';

if CmbExpenseKriter.Text = 'Car Model'  then
TmpSql2:=TmpSql2 + ' and CarModel like '''+CmbExpenseKriter2.Text+'%''  '  ;
if CmbExpenseKriter.Text = 'Car Reg No'  then
TmpSql2:=TmpSql2 + ' and CarRegNo like '''+CmbExpenseKriter2.Text+'%'' '  ;

/////////////////////////////////////////////////////////////////

if ChkExpense.Checked=True then begin

TmpSql := 'Select  ''Car Expense'' as Tur,CarModel,CarRegNo,'+
' price as TL,pricesterlin as S,priceeuro as E, Carid from CarExpense as CE where id<>0 ' ;

if ChkEDate.Checked = True  then
TmpSql := TmpSql+ ' and expensedate between '+
' '''+IntToStr(YearOf(DtE1.Date))+'-'+IntToStr(MonthOf(DtE1.Date))+'-'+IntToStr(DayOf(DtE1.Date))+''' and '+
' '''+IntToStr(YearOf(DtE2.Date))+'-'+IntToStr(MonthOf(DtE2.Date))+'-'+IntToStr(DayOf(DtE2.Date))+''' ' ;

TmpSql:=TmpSql + TmpSql2 ;

end;


/////////////////////////////////////////////////////////////////////////////////
if ChkInsurance.Checked=True then begin

if ChkExpense.Checked=True then TmpSql:=TmpSql +  ' Union All ' ;

TmpSql :=TmpSql+ ' Select ''Car Insurance'' as Tur,CarModel,CarRegNo,'+
' Totalprice as TL,Totalpricesterlin as S,Totalpriceeuro as E, Carid from Carinsurance as Ci where id<>0 ' ;


if ChkEDate.Checked = True  then
TmpSql := TmpSql+ ' and kayittarihi between '+
' '''+IntToStr(YearOf(DtE1.Date))+'-'+IntToStr(MonthOf(DtE1.Date))+'-'+IntToStr(DayOf(DtE1.Date))+''' and '+
' '''+IntToStr(YearOf(DtE2.Date))+'-'+IntToStr(MonthOf(DtE2.Date))+'-'+IntToStr(DayOf(DtE2.Date))+''' ' ;

TmpSql:=TmpSql + TmpSql2 ;
end;
/////////////////////////////////////////////////////////////////////////////////

if ChkSeyrusefer.Checked=True then begin;

if (ChkExpense.Checked=True) or (ChkInsurance.Checked=True) then TmpSql:=TmpSql +  ' Union All ' ;

TmpSql :=TmpSql+ ' Select ''Car Seyrusefer'' as Tur,CarModel,CarRegNo,'+
' price as TL,pricesterlin as S,priceeuro as E, Carid from CarSeyrusefer as CS where id<>0 ' ;

if ChkEDate.Checked = True  then
TmpSql := TmpSql+ ' and kayittarihi between '+
' '''+IntToStr(YearOf(DtE1.Date))+'-'+IntToStr(MonthOf(DtE1.Date))+'-'+IntToStr(DayOf(DtE1.Date))+''' and '+
' '''+IntToStr(YearOf(DtE2.Date))+'-'+IntToStr(MonthOf(DtE2.Date))+'-'+IntToStr(DayOf(DtE2.Date))+''' ' ;

TmpSql:=TmpSql + TmpSql2 ;
end;


Qry1.Close;
qry1.SQL.Clear;
qry1.SQL.Add(TmpSql);
qry1.Prepared;
qry1.Open;

if qry1.RecordCount = 0 Then Exit;

TmpTotalTL:=0;
TmpTotalS:=0;
TmpTotalE:=0;

AdvExpense.RowCount := qry1.RecordCount + 1 ;

for i:=1 to qry1.RecordCount do Begin
AdvExpense.Cells[1,i] := Qry1.FieldByName('Tur').AsString ;
AdvExpense.Cells[2,i] := Qry1.FieldByName('CarModel').AsString ;
AdvExpense.Cells[3,i] := Qry1.FieldByName('CarRegNo').AsString ;
AdvExpense.Cells[4,i] := FormatCurr(',0.00',qry1.FieldByName('TL').AsCurrency);
AdvExpense.Cells[5,i] := FormatCurr(',0.00',qry1.FieldByName('S').AsCurrency);
AdvExpense.Cells[6,i] := FormatCurr(',0.00',qry1.FieldByName('E').AsCurrency);

AdvExpense.Cells[7,i] := Qry1.FieldByName('Carid').AsString ;


TmpTotalTL := TmpTotalTL + Qry1.FieldByName('TL').AsCurrency ;
TmpTotalS  := TmpTotalS  + Qry1.FieldByName('S').AsCurrency ;
TmpTotalE  := TmpTotalE  + Qry1.FieldByName('E').AsCurrency ;
rr:=i;
Qry1.Next;
End;

AdvExpense.AutoNumberCol(0);

AdvExpense.AddRow ;
rr:=rr+1;

AdvExpense.Cells[4,rr]:= FormatCurr(',0.00',TmpTotalTL);
AdvExpense.Cells[5,rr]:= FormatCurr(',0.00',TmpTotalS) ;
AdvExpense.Cells[6,rr]:= FormatCurr(',0.00',TmpTotalE) ;

AdvExpense.Colors[4,rr]:=clYellow ;
AdvExpense.Colors[5,rr]:=clYellow ;
AdvExpense.Colors[6,rr]:=clYellow ;

End;



procedure TFrmReports.Label29Click(Sender: TObject);
var TmpSql,TmpCurr:String;
i,x:integer;
TmpComission,TmpDollar,TmpSterlin,TmpEuro,TmpTl:Currency;
TmpTComission,TmpTDollar,TmpTSterlin,TmpTEuro,TmpTTl,TmpTotalDays:Currency;
begin

ProgramKullanmaDurumu:=ProgramKullanmaDurumu+1;
TmpComission:=0;
AdvCompany.ClearRows(1,AdvCompany.RowCount-1);
AdvCompany.RowCount := 2;

TmpSql := 'Select id,Company,Companyincome,Currency,ReservationDate,Name,Surname,TotalDays,BirakilacakTarih,AlinacakTarih '+
' from Reservation where durum<>''Deleted'' and company like :Company '  ;

if ChkCompany.Checked = True  then
TmpSql:=TmpSql + ' and BirakilacakTarih<=:Dt2 ' ;
if ChkCompany.Checked = True  then
TmpSql:=TmpSql + ' and AlinacakTarih>=:Dt1 ' ;



TmpSql:=TmpSql + ' Order By BirakilacakTarih ';

Qry1.Close;
qry1.SQL.Clear;
qry1.SQL.Add(TmpSql);
Qry1.Parameters.ParamByName('Company').Value := CmbCompany.Text+'%' ;

if ChkCompany.Checked = True  then
Qry1.Parameters.ParamByName('Dt1').Value :=
IntToStr(YearOf(DtCompany1.Date))+'-'+IntToStr(MonthOf(DtCompany1.Date))+'-'+IntToStr(DayOf(DtCompany1.Date));
if ChkCompany.Checked = True  then
Qry1.Parameters.ParamByName('Dt2').Value :=
IntToStr(YearOf(DtCompany2.Date))+'-'+IntToStr(MonthOf(DtCompany2.Date))+'-'+IntToStr(DayOf(DtCompany2.Date));
qry1.Prepared;
qry1.Open;

if qry1.RecordCount = 0 Then Exit;

x:=0;
TmpTTl:=0;
TmpTDollar:=0;
TmpTSterlin:=0;
TmpTEuro := 0;
TmpTotalDays:=0;


for i:=1 to qry1.RecordCount do Begin

if Qry1.FieldByName('Company').AsString = '' then begin
Qry1.Next;
Continue;
end;

if x<>0 Then AdvCompany.AddRow;
x:=x+1;

TmpCurr := Qry1.FieldByName('Currency').AsString;
//if TmpCurr = 'EURO' Then TmpCurr := '€' ;
//if TmpCurr = 'STERLIN' Then TmpCurr := '£' ;
//if TmpCurr = 'DOLLAR'  Then TmpCurr := '$' ;

AdvCompany.Cells[1,x] := Qry1.FieldByName('id').AsString ;
AdvCompany.Cells[2,x] := Qry1.FieldByName('ReservationDate').AsString ;
AdvCompany.Cells[3,x] := Qry1.FieldByName('Name').AsString ;
AdvCompany.Cells[4,x] := Qry1.FieldByName('Surname').AsString ;
AdvCompany.Cells[5,x] := Qry1.FieldByName('Company').AsString ;

AdvCompany.Cells[6,x] := DateToStr(Qry1.FieldByName('BirakilacakTarih').AsDateTime) ;
AdvCompany.Cells[7,x] := DateToStr(Qry1.FieldByName('AlinacakTarih').AsDateTime) ;


AdvCompany.Cells[8,x] := Qry1.FieldByName('TotalDays').AsString ;
TmpTotalDays:=TmpTotalDays+Qry1.FieldByName('TotalDays').AsCurrency;

if TmpCurr = 'EURO' then begin
TmpEuro    := Qry1.FieldByName('Companyincome').AsCurrency ;
if PubEuroAlis=0 then begin
TmpDollar  := 0 ;
TmpSterlin := 0 ;
TmpTl      := 0 ;
end
Else begin
TmpDollar  := (TmpEuro*PubEuroAlis)/PubDollarSatis ;
TmpSterlin := (TmpEuro*PubEuroAlis)/PubSterlinSatis ;
TmpTl      := (TmpEuro*PubEuroAlis) ;
end;
end;

if TmpCurr = 'DOLLAR'  then begin
TmpDollar  := Qry1.FieldByName('Companyincome').AsCurrency ;
if PubDollarAlis=0 then begin
TmpEuro    := 0 ;
TmpSterlin := 0 ;
TmpTl      := 0 ;
end
Else
Begin
TmpEuro    := (TmpDollar*PubDollarAlis)/PubEuroSatis ;
TmpSterlin := (TmpDollar*PubDollarAlis)/PubSterlinSatis;
TmpTl      := (TmpDollar*PubDollarAlis) ;
End;
end;

if TmpCurr = 'STERLIN' then begin
TmpSterlin := Qry1.FieldByName('Companyincome').AsCurrency ;
if PubSterlinAlis=0 then begin
TmpDollar  := 0;
TmpEuro    := 0;
TmpTl      := 0 ;
end
Else begin
TmpDollar  := (TmpSterlin*PubSterlinAlis)/PubDollarSatis ;
TmpEuro    := (TmpSterlin*PubSterlinAlis)/PubEuroSatis ;
TmpTl      := (TmpSterlin*PubSterlinAlis) ;
end;
end;

if TmpCurr = 'TL'  then begin
TmpTl      := Qry1.FieldByName('Companyincome').AsCurrency ;
if PubSterlinAlis=0 then begin
TmpSterlin := 0 ;
TmpDollar  := 0 ;
TmpEuro    := 0 ;
end
Else
Begin
TmpSterlin := TmpTl / PubSterlinSatis;
TmpDollar  := TmpTl / PubDollarSatis;
TmpEuro    := TmpTl / PubEuroSatis;
End;
end;

AdvCompany.Cells[9,x] := FormatFloat('#,##0.00',TmpTl) ;
AdvCompany.Cells[10,x] := FormatFloat('#,##0.00',TmpSterlin) ;
AdvCompany.Cells[11,x] := FormatFloat('#,##0.00',TmpEuro) ;
AdvCompany.Cells[12,x] := FormatFloat('#,##0.00',TmpDollar) ;
AdvCompany.Cells[13,x] :=  Qry1.FieldByName('id').AsString ; ;

TmpTTl      := TmpTTl      + TmpTl ;
TmpTDollar  := TmpTDollar  + TmpDollar ;
TmpTSterlin := TmpTSterlin + TmpSterlin ;
TmpTEuro    := TmpTEuro    + TmpEuro ;

Qry1.Next;
End;
AdvCompany.AutoNumberCol(0);


AdvCompany.AddRow;
AdvCompany.Cells[9,AdvCompany.RowCount-1]  :=  FormatFloat('#,##0.00',TmpTTl) ;
AdvCompany.Colors[9,AdvCompany.RowCount-1] := clYellow ;
AdvCompany.Cells[10,AdvCompany.RowCount-1]  :=  FormatFloat('#,##0.00',TmpTSterlin) ;
AdvCompany.Colors[10,AdvCompany.RowCount-1] := clYellow ;
AdvCompany.Cells[11,AdvCompany.RowCount-1]  :=  FormatFloat('#,##0.00',TmpTEuro) ;
AdvCompany.Colors[11,AdvCompany.RowCount-1] := clYellow ;
AdvCompany.Cells[12,AdvCompany.RowCount-1]  :=  FormatFloat('#,##0.00',TmpTDollar) ;
AdvCompany.Colors[12,AdvCompany.RowCount-1] := clYellow ;

CurrTotalDays2.Value := TmpTotalDays;


End;

procedure TFrmReports.SpeedButton10Click(Sender: TObject);
begin
   AdvGridExcelIO1.AdvStringGrid := AdvIncome ;

if SaveDialog1.Execute then
  if SaveDialog1.FileName<>'' then
     AdvGridExcelIO1.XLSExport(SaveDialog1.FileName+'.xls','Tablo');

end;

procedure TFrmReports.SpeedButton11Click(Sender: TObject);
begin
ProgramKullanmaDurumu:=ProgramKullanmaDurumu+1;
AdvPreviewDialog1.Grid := AdvTransfer;
AdvPreviewDialog1.Execute;
end;

procedure TFrmReports.SpeedButton12Click(Sender: TObject);
begin
AdvGridExcelIO1.AdvStringGrid := AdvTransfer;

if SaveDialog1.Execute then
  if SaveDialog1.FileName<>'' then
     AdvGridExcelIO1.XLSExport(SaveDialog1.FileName+'.xls','Tablo');
end;

procedure TFrmReports.SpeedButton13Click(Sender: TObject);
begin
ProgramKullanmaDurumu:=ProgramKullanmaDurumu+1;
AdvPreviewDialog1.Grid := AdvExpense;
AdvPreviewDialog1.Execute;

end;

procedure TFrmReports.SpeedButton14Click(Sender: TObject);
begin
AdvGridExcelIO1.AdvStringGrid := AdvExpense ;

if SaveDialog1.Execute then
  if SaveDialog1.FileName<>'' then
     AdvGridExcelIO1.XLSExport(SaveDialog1.FileName+'.xls','Tablo');

end;

procedure TFrmReports.SpeedButton17Click(Sender: TObject);
begin
ProgramKullanmaDurumu:=ProgramKullanmaDurumu+1;
AdvPreviewDialog1.Grid := AdvReservation2;
AdvPreviewDialog1.Execute;
end;

procedure TFrmReports.SpeedButton18Click(Sender: TObject);
begin
AdvGridExcelIO1.AdvStringGrid := AdvReservation2;

if SaveDialog1.Execute then
  if SaveDialog1.FileName<>'' then
     AdvGridExcelIO1.XLSExport(SaveDialog1.FileName+'.xls','Tablo');
end;

procedure TFrmReports.SpeedButton1Click(Sender: TObject);
begin
ProgramKullanmaDurumu:=ProgramKullanmaDurumu+1;

AdvPreviewDialog1.Grid := AdvCustomer;
AdvPreviewDialog1.Execute;
end;

procedure TFrmReports.SpeedButton2Click(Sender: TObject);
begin
ProgramKullanmaDurumu:=ProgramKullanmaDurumu+1;

AdvPreviewDialog1.Grid := AdvCar;
AdvPreviewDialog1.Execute;
end;

procedure TFrmReports.SpeedButton3Click(Sender: TObject);
begin
ProgramKullanmaDurumu:=ProgramKullanmaDurumu+1;
AdvPreviewDialog1.Grid := AdvLoyaltiest;
AdvPreviewDialog1.Execute;
end;

procedure TFrmReports.SpeedButton4Click(Sender: TObject);
begin
ProgramKullanmaDurumu:=ProgramKullanmaDurumu+1;
AdvPreviewDialog1.Grid := AdvReservation;
AdvPreviewDialog1.Execute;
end;

procedure TFrmReports.SpeedButton5Click(Sender: TObject);
begin
ProgramKullanmaDurumu:=ProgramKullanmaDurumu+1;
AdvPreviewDialog1.Grid := AdvIncome;
AdvPreviewDialog1.Execute;

end;

procedure TFrmReports.SpeedButton6Click(Sender: TObject);
begin
   AdvGridExcelIO1.AdvStringGrid := AdvCustomer ;
   if SaveDialog1.Execute then
  if SaveDialog1.FileName<>'' then
     AdvGridExcelIO1.XLSExport(SaveDialog1.FileName+'.xls','Tablo');

end;

procedure TFrmReports.SpeedButton7Click(Sender: TObject);
begin
AdvGridExcelIO1.AdvStringGrid := AdvReservation;

if SaveDialog1.Execute then
  if SaveDialog1.FileName<>'' then
     AdvGridExcelIO1.XLSExport(SaveDialog1.FileName+'.xls','Tablo');

end;

procedure TFrmReports.SpeedButton8Click(Sender: TObject);
begin
   AdvGridExcelIO1.AdvStringGrid := AdvCar ;

   if SaveDialog1.Execute then
  if SaveDialog1.FileName<>'' then
     AdvGridExcelIO1.XLSExport(SaveDialog1.FileName+'.xls','Tablo');

end;

procedure TFrmReports.SpeedButton9Click(Sender: TObject);
begin
   AdvGridExcelIO1.AdvStringGrid := AdvLoyaltiest ;

   if SaveDialog1.Execute then
  if SaveDialog1.FileName<>'' then
     AdvGridExcelIO1.XLSExport(SaveDialog1.FileName+'.xls','Tablo');

end;

end.
