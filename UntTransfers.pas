unit UntTransfers;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, BaseGrid, AdvGrid, Menus, DB, ADODB, StdCtrls, Buttons, jpeg, ExtCtrls, Mask,
  MoneyEdit, ComCtrls, AdvEdit, AdvMoneyEdit,DateUtils;

type
  TFrmTransfers = class(TForm)
    Label2: TLabel;
    Panel5: TPanel;
    Qry1: TADOQuery;
    ImgSave: TImage;
    ImgEdit: TImage;
    ImgDelete: TImage;
    ImgNew: TImage;
    LblSave: TLabel;
    LblEdit: TLabel;
    LblDelete: TLabel;
    Label6: TLabel;
    LblStatus: TLabel;
    GroupBox2: TGroupBox;
    Label1: TLabel;
    Label7: TLabel;
    ImgAddCustomer: TImage;
    TxtName: TEdit;
    TxtSurname: TEdit;
    GrpArrival: TGroupBox;
    Label24: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    MemArrivalNotes: TMemo;
    DtArrivalTime: TDateTimePicker;
    DtArrivalDate: TDateTimePicker;
    GrpDeparture: TGroupBox;
    Label19: TLabel;
    Label20: TLabel;
    DtDepartureTime: TDateTimePicker;
    DtDepartureDate: TDateTimePicker;
    MemDepartureNotes: TMemo;
    ChkArrivalTime: TCheckBox;
    ChkDepartureTime: TCheckBox;
    Image1: TImage;
    Label23: TLabel;
    ImgTransferSearch: TImage;
    Label22: TLabel;
    ImgCustomerSearch: TImage;
    Label10: TLabel;
    Label18: TLabel;
    TxtArrivalDestination: TEdit;
    Label4: TLabel;
    CurrArrivalPax: TMoneyEdit;
    CmbArrivalBabySeat: TComboBox;
    CmbArrivalBoosterSeat: TComboBox;
    Label3: TLabel;
    Label5: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    TxtDepartureDestination: TEdit;
    Label13: TLabel;
    CurrDeparturePax: TMoneyEdit;
    Label21: TLabel;
    Label25: TLabel;
    CmbDepartureBoosterSeat: TComboBox;
    CmbDepartureBabySeat: TComboBox;
    Label27: TLabel;
    CmbAgency: TComboBox;
    ChkDeparture: TCheckBox;
    ChkArrival: TCheckBox;
    ChkDeparturePaid: TCheckBox;
    ChkArrivalPaid: TCheckBox;
    Label8: TLabel;
    CurrArrivalPrice: TAdvMoneyEdit;
    CurrDeparturePrice: TAdvMoneyEdit;
    Label28: TLabel;
    Label29: TLabel;
    TxtArrivalFlightNo: TEdit;
    cmbPaidTo: TComboBox;
    Image3: TImage;
    SpeedButton4: TSpeedButton;
    cmbArrivalPaidTo: TComboBox;
    CurrArrCase: TMoneyEdit;
    CmbArrinfantseat: TComboBox;
    Label43: TLabel;
    Label40: TLabel;
    Label32: TLabel;
    CurrDepCase: TMoneyEdit;
    Label33: TLabel;
    cmbDepinfantseat: TComboBox;
    GroupBox1: TGroupBox;
    Label34: TLabel;
    Label35: TLabel;
    TxtModel: TEdit;
    TxtRegNo: TEdit;
    Txtid: TEdit;
    TxtCarGroup: TEdit;
    TxtCarType: TEdit;
    Label36: TLabel;
    Label37: TLabel;
    Label14: TLabel;
    TxtPassportNo: TEdit;
    TxtDrivingLicense: TEdit;
    TxtPlaceofBirth: TEdit;
    Label15: TLabel;
    TxtContactNumber: TEdit;
    Label9: TLabel;
    CmbDriver: TComboBox;
    CmbDriver2: TComboBox;
    Label26: TLabel;
    CmbArrivalCollectFrom: TComboBox;
    CmbDepartureCollectFrom: TComboBox;
    Label38: TLabel;
    CmbCurrency: TComboBox;
    procedure ImgNewClick(Sender: TObject);
    procedure ImgDeleteClick(Sender: TObject);
    procedure ImgEditClick(Sender: TObject);
    procedure ImgSaveClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ImgAddCustomerClick(Sender: TObject);
    procedure ChkArrivalTimeClick(Sender: TObject);
    procedure ChkDepartureTimeClick(Sender: TObject);
    procedure ImgTransferSearchClick(Sender: TObject);
    procedure ImgCustomerSearchClick(Sender: TObject);
    procedure ChkArrivalClick(Sender: TObject);
    procedure ChkDepartureClick(Sender: TObject);
    procedure ChkDeparturePaidClick(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
    procedure ChkArrivalPaidClick(Sender: TObject);
    procedure CmbArrivalCollectFromKeyPress(Sender: TObject; var Key: Char);
    procedure CmbDriverKeyPress(Sender: TObject; var Key: Char);
    procedure CmbDriver2KeyPress(Sender: TObject; var Key: Char);
    procedure CmbDepartureCollectFromKeyPress(Sender: TObject; var Key: Char);
    procedure CmbAgencyKeyPress(Sender: TObject; var Key: Char);
    procedure TxtArrivalFlightNoKeyPress(Sender: TObject; var Key: Char);
    procedure TxtArrivalDestinationKeyPress(Sender: TObject; var Key: Char);
    procedure TxtDepartureDestinationKeyPress(Sender: TObject; var Key: Char);
    procedure MemDepartureNotesKeyPress(Sender: TObject; var Key: Char);
    procedure MemArrivalNotesKeyPress(Sender: TObject; var Key: Char);
    procedure cmbArrivalPaidToKeyPress(Sender: TObject; var Key: Char);
    procedure cmbPaidToKeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);


  private
    { Private declarations }
  public
    procedure CreateParams(var Params: TCreateParams); override;
    Procedure Temizle();
    Procedure PrintTransfer;
   var  PubReservasyonId:String;
        PubTranferid:integer;
    { Public declarations }
  end;

var
 FrmTransfers: TFrmTransfers;

implementation

uses UntGlobal, UntDlgCustomer, UntCustomer, UntProjectGlobal,
  RepTransfer, UntDlgTransfer;

{$R *.dfm}


procedure TFrmTransfers.ChkArrivalClick(Sender: TObject);
begin

if ChkArrival.Checked = True then
GrpArrival.Visible := True
Else GrpArrival.Visible := False;

end;

procedure TFrmTransfers.ChkArrivalPaidClick(Sender: TObject);
begin
if ChkArrivalPaid.Checked = True then
cmbArrivalPaidTo.Visible := True
Else
cmbArrivalPaidTo.Visible := False;
end;

procedure TFrmTransfers.ChkArrivalTimeClick(Sender: TObject);
begin

if ChkArrivalTime.Checked = True then
DtArrivalTime.Visible := True
Else DtArrivalTime.Visible := False ;


end;

procedure TFrmTransfers.ChkDepartureClick(Sender: TObject);
begin
if ChkDeparture.Checked = True then
GrpDeparture.Visible := True
Else GrpDeparture.Visible := False;

end;

procedure TFrmTransfers.ChkDeparturePaidClick(Sender: TObject);
begin

if ChkDeparturePaid.Checked = True then
cmbPaidTo.Visible := True
Else
cmbPaidTo.Visible := False;

end;

procedure TFrmTransfers.ChkDepartureTimeClick(Sender: TObject);
begin
if ChkDepartureTime.Checked = True then
DtDepartureTime.Visible := True
Else DtDepartureTime.Visible := False ;

end;

procedure TFrmTransfers.CmbAgencyKeyPress(Sender: TObject; var Key: Char);
begin
key  := BuyukHarfCombo(key,Sender as TComboBox);
end;

procedure TFrmTransfers.CmbArrivalCollectFromKeyPress(Sender: TObject;
  var Key: Char);
begin
key  := BuyukHarfCombo(key,Sender as TComboBox);
end;

procedure TFrmTransfers.cmbArrivalPaidToKeyPress(Sender: TObject;
  var Key: Char);
begin
key  := BuyukHarfCombo(key,Sender as TComboBox);
end;

procedure TFrmTransfers.CmbDepartureCollectFromKeyPress(Sender: TObject;
  var Key: Char);
begin
key  := BuyukHarfCombo(key,Sender as TComboBox);
end;

procedure TFrmTransfers.CmbDriver2KeyPress(Sender: TObject; var Key: Char);
begin
key  := BuyukHarfCombo(key,Sender as TComboBox);
end;

procedure TFrmTransfers.CmbDriverKeyPress(Sender: TObject; var Key: Char);
begin
key  := BuyukHarfCombo(key,Sender as TComboBox);
end;

procedure TFrmTransfers.cmbPaidToKeyPress(Sender: TObject; var Key: Char);
begin
key  := BuyukHarfCombo(key,Sender as TComboBox);
end;

procedure TFrmTransfers.CreateParams(var Params: TCreateParams);
begin
 inherited CreateParams(Params);
  Params.ExStyle   := Params.ExStyle or WS_EX_APPWINDOW;
  Params.WndParent := GetDesktopWindow;
end;

procedure TFrmTransfers.ImgNewClick(Sender: TObject);
begin
ProgramKullanmaDurumu:=ProgramKullanmaDurumu+1;

temizle;

end;

procedure TFrmTransfers.FormClose(Sender: TObject; var Action: TCloseAction);
begin
Action := caFree;
FrmTransfers:= nil;
end;

procedure TFrmTransfers.FormShow(Sender: TObject);
var i:integer;
begin
 // SetWindowPos(Handle, HWND_TOPMOST, Left, Top, Width, Height, SWP_NOACTIVATE or SWP_NOMOVE or SWP_NOSIZE);





end;

procedure TFrmTransfers.ImgAddCustomerClick(Sender: TObject);
var TmpCustid:String;
begin
ProgramKullanmaDurumu:=ProgramKullanmaDurumu+1;

FrmCustomer:=TFrmCustomer.Create(self);

////////////////////////////////////////////////////////////////////
TmpCustid := inttostr(TxtName.Tag) ;

if TxtName.Tag <> 0 then begin
FrmCustomer.KayitGetir(TmpCustid);
end;

///////////////////////////////////////////////////////////////////////7
FrmCustomer.ShowModal;


ImgCustomerSearch.Tag := FrmCustomer.TxtName.Tag           ;
TxtName.Tag           := FrmCustomer.TxtName.Tag           ;
TxtName.Text          := FrmCustomer.TxtName.Text         ;
TxtSurname.Text       := FrmCustomer.TxtSurname.Text         ;
TxtContactNumber.Text := FrmCustomer.TxtTelNo.Text         ;
TxtPassportNo.Text    := FrmCustomer.TxtPassportId.Text      ;
TxtDrivingLicense.Text:= FrmCustomer.TxtLicenseNo.Text      ;
TxtPlaceofBirth.Text  := FrmCustomer.TxtPlaceofBirth.Text    ;


FrmCustomer.Free;
end;

procedure TFrmTransfers.ImgCustomerSearchClick(Sender: TObject);
begin
ProgramKullanmaDurumu:=ProgramKullanmaDurumu+1;

FrmDlgCustomer:=TFrmDlgCustomer.Create(self);
FrmDlgCustomer.ShowModal;

if FrmDlgCustomer.iptal = False then begin

ImgCustomerSearch.Tag := FrmDlgCustomer.Qry1.fieldbyname('id').AsInteger           ;
TxtName.Tag           := FrmDlgCustomer.Qry1.fieldbyname('id').AsInteger           ;

TxtName.Text          := FrmDlgCustomer.Qry1.FieldByName('Name').AsString          ;
TxtSurname.Text       := FrmDlgCustomer.Qry1.FieldByName('Surname').AsString       ;
TxtContactNumber.Text := FrmDlgCustomer.Qry1.FieldByName('TelNo').AsString ;
TxtPassportNo.Text    := FrmDlgCustomer.Qry1.FieldByName('PassportId').AsString    ;
TxtDrivingLicense.Text:= FrmDlgCustomer.Qry1.FieldByName('LicenseNo').AsString     ;
TxtPlaceofBirth.Text  := FrmDlgCustomer.Qry1.FieldByName('PlaceofBirth').AsString  ;

end;

FrmDlgCustomer.Free;
end;

procedure TFrmTransfers.ImgTransferSearchClick(Sender: TObject);
begin
ProgramKullanmaDurumu:=ProgramKullanmaDurumu+1;

FrmDlgTransfer:=TFrmDlgTransfer.Create(self);
FrmDlgTransfer.ShowModal;

if FrmDlgTransfer.iptal = False then begin

PubTranferid         := FrmDlgTransfer.Qry1.fieldbyname('id').AsInteger  ;

TxtName.Text          := FrmDlgTransfer.Qry1.FieldByName('Name').AsString          ;
TxtSurname.Text       := FrmDlgTransfer.Qry1.FieldByName('Surname').AsString       ;
TxtContactNumber.Text := FrmDlgTransfer.Qry1.FieldByName('ContactNumber').AsString ;
TxtPassportNo.Text    := FrmDlgTransfer.Qry1.FieldByName('PassportId').AsString    ;
TxtDrivingLicense.Text:= FrmDlgTransfer.Qry1.FieldByName('LicenseNo').AsString     ;
TxtPlaceofBirth.Text  := FrmDlgTransfer.Qry1.FieldByName('PlaceofBirth').AsString  ;


CurrArrivalPax.Value         := FrmDlgTransfer.Qry1.fieldbyname('ArrivalPax').Value             ;
CurrDeparturePax.Value       := FrmDlgTransfer.Qry1.fieldbyname('DeparturePax').Value             ;
CmbArrivalBabySeat.Text      := FrmDlgTransfer.Qry1.fieldbyname('ArrivalBabySeat').AsString        ;
CmbDepartureBoosterSeat.Text := FrmDlgTransfer.Qry1.fieldbyname('DepartureBabySeat').AsString        ;
CmbArrivalBabySeat.Text      := FrmDlgTransfer.Qry1.fieldbyname('ArrivalBoosterSeat').AsString     ;
CmbDepartureBoosterSeat.Text := FrmDlgTransfer.Qry1.fieldbyname('DepartureBoosterSeat').AsString     ;


CmbArrivalCollectFrom.Text    := FrmDlgTransfer.Qry1.fieldbyname('ArrivalCollectFrom').AsString     ;
CmbDepartureCollectFrom.Text  := FrmDlgTransfer.Qry1.fieldbyname('DepartureCollectFrom').AsString     ;

DtArrivalDate.Date            := FrmDlgTransfer.Qry1.fieldbyname('ArrivalDate').AsDateTime     ;
DtDepartureDate.Date          := FrmDlgTransfer.Qry1.fieldbyname('DepartureDate').AsDateTime     ;
DtArrivalTime.Time            := FrmDlgTransfer.Qry1.fieldbyname('ArrivalTime').AsDateTime     ;
DtDepartureTime.Time          := FrmDlgTransfer.Qry1.fieldbyname('DepartureTime').AsDateTime     ;
MemArrivalNotes .Text         := FrmDlgTransfer.Qry1.fieldbyname('ArrivalNotes').AsString    ;
MemDepartureNotes.Text        := FrmDlgTransfer.Qry1.fieldbyname('DepartureNotes').AsString    ;

TxtArrivalDestination.Text    := FrmDlgTransfer.Qry1.fieldbyname('ArrivalDestination').AsString     ;
TxtDepartureDestination.Text  := FrmDlgTransfer.Qry1.fieldbyname('DepartureDestination').AsString     ;

CmbAgency.ItemIndex := CmbAgency.Items.IndexOf(FrmDlgTransfer.Qry1.fieldbyname('AgencyName').AsString);

if FrmDlgTransfer.Qry1.fieldbyname('ArrivalTimeChecked').AsString = 'Y' then
    ChkArrivalTime.Checked  := True
Else ChkArrivalTime.Checked := False ;

if FrmDlgTransfer.Qry1.fieldbyname('DepartureTimeChecked').AsString = 'Y' then
    ChkDepartureTime.Checked  := True
Else ChkDepartureTime.Checked := False ;


CmbDriver.Text  := FrmDlgTransfer.Qry1.fieldbyname('Driver').AsString ;
CmbDriver2.Text := FrmDlgTransfer.Qry1.fieldbyname('Driver2').AsString ;

if  FrmDlgTransfer.Qry1.fieldbyname('CheckedDeparture').asstring = 'Y' then
 ChkDeparture.Checked := True
Else ChkDeparture.Checked := False;

if  FrmDlgTransfer.Qry1.fieldbyname('CheckedArrival').asstring = 'Y' then
 ChkArrival.Checked := True
Else ChkArrival.Checked := False;

TxtArrivalFlightNo.Text := FrmDlgTransfer.Qry1.fieldbyname('ArrivalFlightNo').AsString  ;
CurrArrivalPrice.Value  := FrmDlgTransfer.Qry1.fieldbyname('ArrivalPrice').Value ;
CurrDeparturePrice.Value:= FrmDlgTransfer.Qry1.fieldbyname('DeparturePrice').Value ;

if FrmDlgTransfer.Qry1.fieldbyname('ArrivalPaid').AsString = 'Y'  then
ChkArrivalPaid.Checked := True
Else ChkArrivalPaid.Checked := False ;

if FrmDlgTransfer.Qry1.fieldbyname('DeparturePaid').AsString = 'Y'  then
ChkDeparturePaid.Checked := True
Else ChkDeparturePaid.Checked := False ;

cmbPaidTo.ItemIndex := cmbPaidTo.Items.IndexOf(FrmDlgTransfer.Qry1.fieldbyname('PaidTo').AsString);

if FrmDlgTransfer.Qry1.fieldbyname('ArrivalPaid').AsString = 'Y'  then
ChkArrivalPaid.Checked := True
Else ChkArrivalPaid.Checked := False ;

cmbArrivalPaidTo.ItemIndex := cmbArrivalPaidTo.Items.IndexOf(FrmDlgTransfer.Qry1.fieldbyname('ArrivalPaidTo').AsString);
CmbCurrency.ItemIndex := CmbCurrency.Items.IndexOf(FrmDlgTransfer.Qry1.fieldbyname('currency').AsString);

ImgSave.Enabled     := False;
LblSave.Font.Color  := clGray ;
LblSave.Enabled     := False;

ImgDelete.Enabled   := True;
LblDelete.Font.Color:= clWhite ;
LblDelete.Enabled   := True;

ImgEdit.Enabled     := True;
LblEdit.Font.Color  := clWhite ;
LblEdit.Enabled     := True;


LblStatus.Caption   := 'Edit / Delete existing record or click "New" for new entries... ';

end;

FrmDlgTransfer.Free;

end;

procedure TFrmTransfers.MemArrivalNotesKeyPress(Sender: TObject; var Key: Char);
begin
key  := BuyukHarfMemo(key,Sender as TMemo);
end;

procedure TFrmTransfers.MemDepartureNotesKeyPress(Sender: TObject;
  var Key: Char);
begin
key  := BuyukHarfMemo(key,Sender as TMemo);
end;

procedure TFrmTransfers.PrintTransfer;
var TmpSql:String;
begin

TmpSql := 'Select * ' +

//',CASE WHEN CollectTimeChecked = ''Y'' THEN CONVERT(VARCHAR(5), AlinacakSaat, 108) ELSE '''' END AS SLCollectTime ,' +
//'CASE WHEN DeliverTimeChecked = ''Y'' THEN CONVERT(VARCHAR(5), BirakilacakSaat, 108) ELSE '''' END AS SLDeliverTime ' +

'from Transfer   ' +

'where id=:id' +
'';

Qry1.Close;
qry1.SQL.Clear;
qry1.SQL.Add(TmpSql);
Qry1.Parameters.ParamByName('id').Value := TxtName.Tag ;
Qry1.Prepared;
qry1.Open;

TTimeField (Qry1.FieldByName('ArrivalTime')).DisplayFormat := 'HH:mm';
TTimeField (Qry1.FieldByName('DepartureTime')).DisplayFormat := 'HH:mm';
TDateField (Qry1.FieldByName('ArrivalDate')).DisplayFormat := 'DD/MM/yyyy';
TDateField (Qry1.FieldByName('DepartureDate')).DisplayFormat := 'DD/MM/yyyy';
TNumericField (Qry1.FieldByName('ArrivalPrice')).DisplayFormat := ',0.00 £';
TNumericField (Qry1.FieldByName('DeparturePrice')).DisplayFormat := ',0.00 £';




//MsgUyari(inttostr(qry1.RecordCount));

QRepTransfers:=TQRepTransfers.Create(self);
QRepTransfers.QRLKullanici.Caption := 'User : '+Kullanici ;
//QRepTransfers.Preview;
QRepTransfers.Print;
QRepTransfers.Free;

end;

procedure TFrmTransfers.SpeedButton4Click(Sender: TObject);
begin
PrintTransfer;
end;

procedure TFrmTransfers.ImgDeleteClick(Sender: TObject);
begin
ProgramKullanmaDurumu:=ProgramKullanmaDurumu+1;

if MsgOnay('Do you want to delete ? ') Then begin

qry1.Close;
qry1.SQL.Clear;
qry1.SQL.Add('Delete from Transfer where id=:id ');
qry1.Parameters.ParamByName('id').Value :=FrmTransfers.PubTranferid ;
qry1.Prepared;
qry1.ExecSQL;

temizle;

end;

end;

procedure TFrmTransfers.ImgEditClick(Sender: TObject);
var TmpSql:String;
begin
ProgramKullanmaDurumu:=ProgramKullanmaDurumu+1;

if trim(TxtName.Text) = '' Then begin
MsgUyari('Please enter customer name  !!! ');
exit;
end;

if trim(TxtSurname.Text) = '' Then begin
MsgUyari('Please enter customer surname !!! ');
exit;
end;

if trim(CmbAgency.Text) = '' Then begin
if MsgOnay('Agency field is empty, Do you want to continue ? ') = False Then begin
CmbAgency.SetFocus;
exit;
end;
end;

TmpSql:='update Transfer set ' +

' Customerid    =:Customerid, '+
' Name          =:Name, '+
' Surname       =:Surname, ' +
' ContactNumber =:ContactNumber, '  +
' PassportId    =:PassportId, '  +
' LicenseNo     =:LicenseNo, '  +
' PlaceofBirth  =:PlaceofBirth, '  +
' ArrivalPax    =:ArrivalPax, '  +
' DeparturePax  =:DeparturePax, '  +

' ArrivalBabySeat      =:ArrivalBabySeat, '  +
' DepartureBabySeat    =:DepartureBabySeat, '  +
' ArrivalBoosterSeat   =:ArrivalBoosterSeat, '  +
' DepartureBoosterSeat =:DepartureBoosterSeat, '  +
' ArrivalCollectFrom   =:ArrivalCollectFrom, '  +
' DepartureCollectFrom =:DepartureCollectFrom, '  +

' ArrivalDate    =:ArrivalDate, '  +
' DepartureDate  =:DepartureDate, '  +
' ArrivalTime    =:ArrivalTime, '  +
' DepartureTime  =:DepartureTime, '  +
' ArrivalNotes   =:ArrivalNotes, '  +
' DepartureNotes =:DepartureNotes, '  +

' ArrivalDestination   =:ArrivalDestination, '  +
' DepartureDestination =:DepartureDestination, '  +
' ArrivalTimeChecked   =:ArrivalTimeChecked, '  +
' DepartureTimeChecked =:DepartureTimeChecked, '  +
' Driver               =:Driver, '  +
' AgencyName           =:AgencyName, '  +
' CheckedDeparture     =:CheckedDeparture, '  +
' CheckedArrival       =:CheckedArrival, '  +
' ArrivalFlightNo      =:ArrivalFlightNo, '  +
' ArrivalPrice         =:ArrivalPrice, '  +
' DeparturePrice       =:DeparturePrice, '  +
' ArrivalPaid          =:ArrivalPaid, '  +
' DeparturePaid        =:DeparturePaid, '  +
' PaidTo               =:PaidTo, '  +
' ArrivalPaidTo        =:ArrivalPaidTo, '  +
' DepartureCase        =:DepartureCase, '  +
' ArrivalCase          =:ArrivalCase, '  +
' Departureinfant      =:Departureinfant, '  +
' Arrivalinfant        =:Arrivalinfant, '  +

' Carid    =:Carid, '     +
' CarModel =:CarModel, '  +
' CarRegNo =:CarRegNo, '  +
' CarGroup =:CarGroup, '  +
' CarType  =:CarType, '   +
' RegNo    =:RegNo, '     +
' Driver2  =:Driver2, '   +
' Currency  =:Currency '  +

' where id = :id ';

qry1.Close;
qry1.SQL.Clear;
qry1.SQL.Add(TmpSql);

Qry1.Parameters.ParamByName('Customerid').Value:= ImgCustomerSearch.tag ;
Qry1.Parameters.ParamByName('Name').Value                 := trim(TxtName.Text)           ;
Qry1.Parameters.ParamByName('Surname').Value              := trim(TxtSurname.Text)        ;
Qry1.Parameters.ParamByName('ContactNumber').Value        := trim(TxtContactNumber.Text)  ;
Qry1.Parameters.ParamByName('PassportId').Value           := trim(TxtPassportNo.Text)     ;
Qry1.Parameters.ParamByName('LicenseNo').Value            := trim(TxtDrivingLicense.Text) ;
Qry1.Parameters.ParamByName('PlaceofBirth').Value         := trim(TxtPlaceofBirth.Text)   ;

Qry1.Parameters.ParamByName('ArrivalPax').Value           := CurrArrivalPax.Value          ;
Qry1.Parameters.ParamByName('DeparturePax').Value         := CurrDeparturePax.Value          ;
Qry1.Parameters.ParamByName('ArrivalBabySeat').Value      := CmbArrivalBabySeat.Text   ;
Qry1.Parameters.ParamByName('DepartureBabySeat').Value    := CmbDepartureBabySeat.Text   ;
Qry1.Parameters.ParamByName('ArrivalBoosterSeat').Value   := CmbArrivalBoosterSeat.Text ;
Qry1.Parameters.ParamByName('DepartureBoosterSeat').Value := CmbDepartureBoosterSeat.Text ;
Qry1.Parameters.ParamByName('ArrivalCollectFrom').Value   := trim(CmbArrivalCollectFrom.Text);
Qry1.Parameters.ParamByName('DepartureCollectFrom').Value := trim(CmbDepartureCollectFrom.Text);

Qry1.Parameters.ParamByName('ArrivalDate').Value := IntToStr(YearOf(DtArrivalDate.Date))+'-'+
                                                    IntToStr(MonthOf(DtArrivalDate.Date))+'-'+
                                                    IntToStr(DayOf(DtArrivalDate.Date));

Qry1.Parameters.ParamByName('ArrivalTime').Value   :=IntToStr(HourOf(DtArrivalTime.Time))+':'+
                                                     IntToStr(MinuteOf(DtArrivalTime.Time))+':'+
                                                     IntToStr(SecondOf(DtArrivalTime.Time));

Qry1.Parameters.ParamByName('DepartureDate').Value :=IntToStr(YearOf(DtDepartureDate.Date))+'-'+
                                                     IntToStr(MonthOf(DtDepartureDate.Date))+'-'+
                                                     IntToStr(DayOf(DtDepartureDate.Date));

Qry1.Parameters.ParamByName('DepartureTime').Value :=IntToStr(HourOf(DtDepartureTime.Time))+':'+
                                                     IntToStr(MinuteOf(DtDepartureTime.Time))+':'+
                                                     IntToStr(SecondOf(DtDepartureTime.Time));

Qry1.Parameters.ParamByName('ArrivalNotes').Value         := Trim(MemArrivalNotes.Text) ;
Qry1.Parameters.ParamByName('DepartureNotes').Value       := Trim(MemDepartureNotes.Text) ;
Qry1.Parameters.ParamByName('ArrivalDestination').Value   := trim(TxtArrivalDestination.Text);
Qry1.Parameters.ParamByName('DepartureDestination').Value := trim(TxtDepartureDestination.Text);

if ChkArrivalTime.Checked = True then
Qry1.Parameters.ParamByName('ArrivalTimeChecked').Value := 'Y'
Else Qry1.Parameters.ParamByName('ArrivalTimeChecked').Value := 'N';

if ChkDepartureTime.Checked = True then
Qry1.Parameters.ParamByName('DepartureTimeChecked').Value := 'Y'
Else Qry1.Parameters.ParamByName('DepartureTimeChecked').Value := 'N';

Qry1.Parameters.ParamByName('Driver').Value:= Trim(CmbDriver.Text) ;

Qry1.Parameters.ParamByName('AgencyName').Value:= CmbAgency.Text ;

if ChkDeparture.Checked = True then
Qry1.Parameters.ParamByName('CheckedDeparture').Value := 'Y'
Else Qry1.Parameters.ParamByName('CheckedDeparture').Value := 'N';

if ChkArrival.Checked = True then
Qry1.Parameters.ParamByName('CheckedArrival').Value := 'Y'
Else Qry1.Parameters.ParamByName('CheckedArrival').Value := 'N';

Qry1.Parameters.ParamByName('ArrivalFlightNo').Value := Trim(TxtArrivalFlightNo.Text) ;
Qry1.Parameters.ParamByName('ArrivalPrice').Value    := CurrArrivalPrice.Value ;
Qry1.Parameters.ParamByName('DeparturePrice').Value  := CurrDeparturePrice.Value ;

if ChkArrivalPaid.Checked = True then
Qry1.Parameters.ParamByName('ArrivalPaid').Value := 'Y'
Else Qry1.Parameters.ParamByName('ArrivalPaid').Value := 'N';

if ChkDeparturePaid.Checked = True then
Qry1.Parameters.ParamByName('DeparturePaid').Value := 'Y'
Else Qry1.Parameters.ParamByName('DeparturePaid').Value := 'N';

if ChkDeparturePaid.Checked = True then
Qry1.Parameters.ParamByName('PaidTo').Value := cmbPaidTo.Text
Else
Qry1.Parameters.ParamByName('PaidTo').Value := '';

if ChkArrivalPaid.Checked = True then
Qry1.Parameters.ParamByName('ArrivalPaidTo').Value := cmbArrivalPaidTo.Text
Else
Qry1.Parameters.ParamByName('ArrivalPaidTo').Value := '';

Qry1.Parameters.ParamByName('DepartureCase').Value   := CurrDepCase.Value ;
Qry1.Parameters.ParamByName('ArrivalCase').Value     := CurrArrCase.Value ;
Qry1.Parameters.ParamByName('Departureinfant').Value := cmbDepinfantseat.Text ;
Qry1.Parameters.ParamByName('Arrivalinfant').Value   := CmbArrinfantseat.Text ;

if Txtid.Text='' then
Qry1.Parameters.ParamByName('Carid').Value    := '0'
else
Qry1.Parameters.ParamByName('Carid').Value    := Txtid.Text       ;

Qry1.Parameters.ParamByName('CarModel').Value := TxtModel.Text    ;
Qry1.Parameters.ParamByName('CarRegNo').Value := TxtRegNo.Text    ;
Qry1.Parameters.ParamByName('CarGroup').Value := TxtCarGroup.Text ;
Qry1.Parameters.ParamByName('CarType').Value  := TxtCarType.Text  ;

Qry1.Parameters.ParamByName('RegNo').Value    := PubReservasyonId  ;
Qry1.Parameters.ParamByName('Driver2').Value  := Trim(CmbDriver2.Text) ;

Qry1.Parameters.ParamByName('Currency').Value  := CmbCurrency.Text  ;

Qry1.Parameters.ParamByName('id').Value := FrmTransfers.PubTranferid ;

qry1.Prepared;
qry1.ExecSQL;

LblStatus.Caption := 'Update successfully ... ';

end;

procedure TFrmTransfers.ImgSaveClick(Sender: TObject);
var TmpSql:string;
begin
ProgramKullanmaDurumu:=ProgramKullanmaDurumu+1;

if trim(TxtName.Text) = '' Then begin
MsgUyari('Please enter customer name  !!! ');
exit;
end;

if trim(TxtSurname.Text) = '' Then begin
MsgUyari('Please enter customer surname !!! ');
exit;
end;

if trim(CmbAgency.Text) = '' Then begin
if MsgOnay('Agency field is empty, Do you want to continue ? ') = False Then begin
CmbAgency.SetFocus;
exit;
end;
end;


Qry1.Close;
Qry1.SQL.Clear;
Qry1.SQL.Add('Select BlackList from Customer where id=:id ');
Qry1.Parameters.ParamByName('id').Value := ImgCustomerSearch.tag ;
Qry1.Prepared;
Qry1.Open;

if qry1.FieldByName('Blacklist').AsString = 'Y' then
if MsgOnay('The Customer which you choose is at the black list!!!...Do you want to continue ? ') = False Then
exit;


TmpSql:='insert into Transfer ' +
'(Customerid,Name,Surname,ContactNumber,PassportId,LicenseNo,PlaceofBirth,ArrivalPax,DeparturePax,ArrivalBabySeat,DepartureBabySeat,ArrivalBoosterSeat,DepartureBoosterSeat,'+
'ArrivalCollectFrom,DepartureCollectFrom,ArrivalDate,DepartureDate,ArrivalTime,DepartureTime,ArrivalNotes,DepartureNotes,    '+
'ArrivalDestination,DepartureDestination,ArrivalTimeChecked,DepartureTimeChecked,Driver,AgencyName,CheckedDeparture,'+
'CheckedArrival,ArrivalFlightNo,ArrivalPrice,DeparturePrice,ArrivalPaid,DeparturePaid,PaidTo,ArrivalPaidTo,DepartureCase,ArrivalCase,Departureinfant,Arrivalinfant,'+
'Carid,CarModel,CarRegNo,CarGroup,CarType,RegNo,Driver2,Currency)'+

'Values ' +
'(:Customerid,:Name,:Surname,:ContactNumber,:PassportId,:LicenseNo,:PlaceofBirth,:ArrivalPax,:DeparturePax,:ArrivalBabySeat,:DepartureBabySeat,:ArrivalBoosterSeat,:DepartureBoosterSeat,'+
':ArrivalCollectFrom,:DepartureCollectFrom,:ArrivalDate,:DepartureDate,:ArrivalTime,:DepartureTime,:ArrivalNotes,:DepartureNotes,     '+
':ArrivalDestination,:DepartureDestination,:ArrivalTimeChecked,:DepartureTimeChecked,:Driver,:AgencyName,:CheckedDeparture,'+
':CheckedArrival,:ArrivalFlightNo,:ArrivalPrice,:DeparturePrice,:ArrivalPaid,:DeparturePaid,:PaidTo,:ArrivalPaidTo,:DepartureCase,:ArrivalCase,:Departureinfant,:Arrivalinfant,'+
':Carid,:CarModel,:CarRegNo,:CarGroup,:CarType,:RegNo,:Driver2,:Currency)';

qry1.Close;
qry1.SQL.Clear;
qry1.SQL.Add(TmpSql);

Qry1.Parameters.ParamByName('Customerid').Value           := ImgCustomerSearch.tag ;
Qry1.Parameters.ParamByName('Name').Value                 := trim(TxtName.Text)           ;
Qry1.Parameters.ParamByName('Surname').Value              := trim(TxtSurname.Text)        ;
Qry1.Parameters.ParamByName('ContactNumber').Value        := trim(TxtContactNumber.Text)  ;
Qry1.Parameters.ParamByName('PassportId').Value           := trim(TxtPassportNo.Text)     ;
Qry1.Parameters.ParamByName('LicenseNo').Value            := trim(TxtDrivingLicense.Text) ;
Qry1.Parameters.ParamByName('PlaceofBirth').Value         := trim(TxtPlaceofBirth.Text)   ;

Qry1.Parameters.ParamByName('ArrivalPax').Value           := CurrArrivalPax.Value          ;
Qry1.Parameters.ParamByName('DeparturePax').Value         := CurrDeparturePax.Value          ;
Qry1.Parameters.ParamByName('ArrivalBabySeat').Value      := CmbArrivalBabySeat.Text   ;
Qry1.Parameters.ParamByName('DepartureBabySeat').Value    := CmbDepartureBabySeat.Text   ;
Qry1.Parameters.ParamByName('ArrivalBoosterSeat').Value   := CmbArrivalBoosterSeat.Text ;
Qry1.Parameters.ParamByName('DepartureBoosterSeat').Value := CmbDepartureBoosterSeat.Text ;
Qry1.Parameters.ParamByName('ArrivalCollectFrom').Value   := trim(CmbArrivalCollectFrom.Text);
Qry1.Parameters.ParamByName('DepartureCollectFrom').Value := trim(CmbDepartureCollectFrom.Text);

Qry1.Parameters.ParamByName('ArrivalDate').Value := IntToStr(YearOf(DtArrivalDate.Date))+'-'+
                                                    IntToStr(MonthOf(DtArrivalDate.Date))+'-'+
                                                    IntToStr(DayOf(DtArrivalDate.Date));

Qry1.Parameters.ParamByName('ArrivalTime').Value   :=IntToStr(HourOf(DtArrivalTime.Time))+':'+
                                                     IntToStr(MinuteOf(DtArrivalTime.Time))+':'+
                                                     IntToStr(SecondOf(DtArrivalTime.Time));

Qry1.Parameters.ParamByName('DepartureDate').Value :=IntToStr(YearOf(DtDepartureDate.Date))+'-'+
                                                     IntToStr(MonthOf(DtDepartureDate.Date))+'-'+
                                                     IntToStr(DayOf(DtDepartureDate.Date));

Qry1.Parameters.ParamByName('DepartureTime').Value :=IntToStr(HourOf(DtDepartureTime.Time))+':'+
                                                     IntToStr(MinuteOf(DtDepartureTime.Time))+':'+
                                                     IntToStr(SecondOf(DtDepartureTime.Time));


Qry1.Parameters.ParamByName('ArrivalNotes').Value         := Trim(MemArrivalNotes.Text) ;
Qry1.Parameters.ParamByName('DepartureNotes').Value       := Trim(MemDepartureNotes.Text) ;
Qry1.Parameters.ParamByName('ArrivalDestination').Value   := trim(TxtArrivalDestination.Text);
Qry1.Parameters.ParamByName('DepartureDestination').Value := trim(TxtDepartureDestination.Text);

if ChkArrivalTime.Checked = True then
Qry1.Parameters.ParamByName('ArrivalTimeChecked').Value := 'Y'
Else Qry1.Parameters.ParamByName('ArrivalTimeChecked').Value := 'N';

if ChkDepartureTime.Checked = True then
Qry1.Parameters.ParamByName('DepartureTimeChecked').Value := 'Y'
Else Qry1.Parameters.ParamByName('DepartureTimeChecked').Value := 'N';

Qry1.Parameters.ParamByName('Driver').Value:= Trim(CmbDriver.Text) ;


Qry1.Parameters.ParamByName('AgencyName').Value := CmbAgency.Text;


if ChkDeparture.Checked = True then
Qry1.Parameters.ParamByName('CheckedDeparture').Value := 'Y'
Else Qry1.Parameters.ParamByName('CheckedDeparture').Value := 'N';

if ChkArrival.Checked = True then
Qry1.Parameters.ParamByName('CheckedArrival').Value := 'Y'
Else Qry1.Parameters.ParamByName('CheckedArrival').Value := 'N';

Qry1.Parameters.ParamByName('ArrivalFlightNo').Value := Trim(TxtArrivalFlightNo.Text) ;
Qry1.Parameters.ParamByName('ArrivalPrice').Value    := CurrArrivalPrice.Value ;
Qry1.Parameters.ParamByName('DeparturePrice').Value  := CurrDeparturePrice.Value ;

if ChkArrivalPaid.Checked = True then
Qry1.Parameters.ParamByName('ArrivalPaid').Value := 'Y'
Else Qry1.Parameters.ParamByName('ArrivalPaid').Value := 'N';

if ChkDeparturePaid.Checked = True then
Qry1.Parameters.ParamByName('DeparturePaid').Value := 'Y'
Else Qry1.Parameters.ParamByName('DeparturePaid').Value := 'N';

if ChkDeparturePaid.Checked = True then
Qry1.Parameters.ParamByName('PaidTo').Value := cmbPaidTo.Text
Else
Qry1.Parameters.ParamByName('PaidTo').Value := '';

if ChkArrivalPaid.Checked = True then
Qry1.Parameters.ParamByName('ArrivalPaidTo').Value := cmbArrivalPaidTo.Text
Else
Qry1.Parameters.ParamByName('ArrivalPaidTo').Value := '';


Qry1.Parameters.ParamByName('DepartureCase').Value   := CurrDepCase.Value ;
Qry1.Parameters.ParamByName('ArrivalCase').Value     := CurrArrCase.Value ;
Qry1.Parameters.ParamByName('Departureinfant').Value := cmbDepinfantseat.Text ;
Qry1.Parameters.ParamByName('Arrivalinfant').Value   := CmbArrinfantseat.Text ;


if Txtid.Text = ''  Then
Qry1.Parameters.ParamByName('Carid').Value    := '0'
Else
Qry1.Parameters.ParamByName('Carid').Value    := Txtid.Text;


Qry1.Parameters.ParamByName('CarModel').Value := TxtModel.Text    ;
Qry1.Parameters.ParamByName('CarRegNo').Value := TxtRegNo.Text    ;
Qry1.Parameters.ParamByName('CarGroup').Value := TxtCarGroup.Text ;
Qry1.Parameters.ParamByName('CarType').Value  := TxtCarType.Text  ;

Qry1.Parameters.ParamByName('RegNo').Value    := PubReservasyonId  ;
Qry1.Parameters.ParamByName('Driver2').Value  := Trim(CmbDriver2.Text)  ;

Qry1.Parameters.ParamByName('Currency').Value  := CmbCurrency.Text  ;

qry1.Prepared;
qry1.ExecSQL;

if MsgOnay('Do you want to print the current transfer ? ') = True Then begin

Qry1.Close;
Qry1.SQL.Clear;
Qry1.SQL.Add('Select max(id) as Tmpid from Transfer ');
Qry1.Open;

TxtName.Tag := Qry1.FieldByName('Tmpid').AsInteger ;
PrintTransfer;
end;

LblStatus.Caption := 'Save Successfully ...' ;
end;

procedure TFrmTransfers.temizle;
begin

TxtName.Tag := 0 ;
ImgCustomerSearch.Tag :=0;

CmbAgency.Text := ''   ;
CmbDriver.Text := ''   ;
TxtName.Clear     ;
TxtSurname.Clear  ;
TxtContactNumber.Clear   ;
TxtPassportNo.Clear      ;
TxtDrivingLicense.Clear  ;
TxtPlaceofBirth.Clear    ;

CurrArrivalPax.value := 0          ;
CurrDeparturePax.Value := 0          ;
CurrArrivalPrice.Value := 0 ;
CmbArrivalCollectFrom.Text := '';
CmbDepartureCollectFrom.Text := '' ;
MemArrivalNotes.Clear ;
MemDepartureNotes.Clear ;
TxtArrivalDestination.Clear;
TxtDepartureDestination.Clear;

ChkDeparture.Checked := True;
ChkArrival.Checked   := True;

TxtArrivalFlightNo.Clear;
CurrArrivalPrice.Value := 0;
CurrDeparturePrice.Value:=0;
ChkArrivalPaid.Checked := False;
ChkDeparturePaid.Checked := False;

CurrArrCase.Value := 0;
CurrDepCase.Value := 0;
CmbArrinfantseat.ItemIndex := 0;
cmbDepinfantseat.ItemIndex := 0;

Txtid.Clear       ;
TxtModel.Clear    ;
TxtRegNo.Clear    ;
TxtCarGroup.Clear ;
TxtCarType.Clear  ;

ImgSave.Enabled     := True;
LblSave.Font.Color  := clWhite ;
LblSave.Enabled     := True;

ImgDelete.Enabled   := False;
LblDelete.Font.Color:= clGray ;
LblDelete.Enabled   := False;

ImgEdit.Enabled     := False;
LblEdit.Font.Color  := clGray ;
LblEdit.Enabled     := False;


LblStatus.Caption := '........';

end;

procedure TFrmTransfers.TxtArrivalDestinationKeyPress(Sender: TObject;
  var Key: Char);
begin
key  := BuyukHarf(key,Sender as TEdit);
end;

procedure TFrmTransfers.TxtArrivalFlightNoKeyPress(Sender: TObject;
  var Key: Char);
begin
key  := BuyukHarf(key,Sender as TEdit);
end;

procedure TFrmTransfers.TxtDepartureDestinationKeyPress(Sender: TObject;
  var Key: Char);
begin
key  := BuyukHarf(key,Sender as TEdit);
end;

end.
