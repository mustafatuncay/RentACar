unit UntReservation2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, BaseGrid, AdvGrid, Menus, DB, ADODB, StdCtrls, Buttons, jpeg, ExtCtrls, Mask, ComCtrls,
  MoneyEdit, AdvEdit, AdvMoneyEdit, DBCtrls, AdvCombo, AdvDBLookupComboBox,
  Lucombo, dblucomb, AdvSmoothPanel, AdvSmoothExpanderPanel, DBGrids, ImgList,
  QuickRpt,DateUtils;

type
  TFrmReservation2 = class(TForm)
    Label2: TLabel;
    Panel5: TPanel;
    Qry1: TADOQuery;
    GroupBox1: TGroupBox;
    Label8: TLabel;
    Label9: TLabel;
    LblSave: TLabel;
    LblEdit: TLabel;
    LblDelete: TLabel;
    ImgDelete: TImage;
    ImgEdit: TImage;
    ImgSave: TImage;
    GrpCustomer: TGroupBox;
    Label4: TLabel;
    Label11: TLabel;
    Label10: TLabel;
    Label12: TLabel;
    GroupBox4: TGroupBox;
    Label17: TLabel;
    Label18: TLabel;
    GroupBox5: TGroupBox;
    Label5: TLabel;
    Label7: TLabel;
    DtBirakilacakSaat: TDateTimePicker;
    DtBirakilacakTarih: TDateTimePicker;
    Label16: TLabel;
    MemBirakilacakNotlar: TMemo;
    GroupBox6: TGroupBox;
    Label24: TLabel;
    Label3: TLabel;
    Label6: TLabel;
    MemAlinacakNotlar: TMemo;
    DtAlinacakSaat: TDateTimePicker;
    DtAlinacakTarih: TDateTimePicker;
    ChkCollectTime: TCheckBox;
    Label23: TLabel;
    ImgCustomerSearch: TImage;
    CurrLowSeasonRate: TAdvMoneyEdit;
    CurrTotalAmount: TAdvMoneyEdit;
    CmbName: TComboBox;
    CmbSurname: TComboBox;
    CmbContactNumber: TComboBox;
    CmbPlaceofBirth: TComboBox;
    CmbCustomerId: TComboBox;
    Qry2: TADOQuery;
    RGrMode: TRadioGroup;
    BtnOK: TSpeedButton;
    Label30: TLabel;
    BtnCalculate: TButton;
    Label32: TLabel;
    CurrOutstandingBalance: TAdvMoneyEdit;
    Label36: TLabel;
    CmbPassportNo: TComboBox;
    Label37: TLabel;
    CmbDrivingLicense: TComboBox;
    Label41: TLabel;
    CurrTaxiPickUp: TAdvMoneyEdit;
    ChkDeliverTime: TCheckBox;
    Label48: TLabel;
    CurrTaxiDropOff: TAdvMoneyEdit;
    GroupBox8: TGroupBox;
    Label44: TLabel;
    DtTaxiDateDeliver: TDateTimePicker;
    DtTaxiTimeDeliver: TDateTimePicker;
    LblTransfers: TLabel;
    ImgTransfers: TImage;
    ChkTaxiTimeDeliver: TCheckBox;
    GroupBox9: TGroupBox;
    Label45: TLabel;
    DtTaxiDateCollect: TDateTimePicker;
    DtTaxiTimeCollect: TDateTimePicker;
    ChkTaxiTimeCollect: TCheckBox;
    CmbBirakilacakYer: TComboBox;
    CmbTaxiDeliverFrom: TComboBox;
    Cmbalinacakyer: TComboBox;
    CmbTaxiCollectTo: TComboBox;
    Panel2: TPanel;
    SpeedButton4: TSpeedButton;
    Label20: TLabel;
    Label31: TLabel;
    TxtReservationIdNo: TEdit;
    TxtFlightNumber: TEdit;
    DtFlightTime: TDateTimePicker;
    ChkFlightTime: TCheckBox;
    Label51: TLabel;
    Label26: TLabel;
    TxtContractNumber: TEdit;
    CmbCurrency: TComboBox;
    Label27: TLabel;
    CurrMidSeasonRate: TAdvMoneyEdit;
    Label28: TLabel;
    CurrHighSeasonRate: TAdvMoneyEdit;
    Label29: TLabel;
    Label33: TLabel;
    Label38: TLabel;
    CurrLowSeasonTotal: TAdvMoneyEdit;
    Label42: TLabel;
    CurrMidSeasonTotal: TAdvMoneyEdit;
    Label49: TLabel;
    CurrHighSeasonTotal: TAdvMoneyEdit;
    Label39: TLabel;
    CurrPaxPickUp: TMoneyEdit;
    Label50: TLabel;
    CurrPaxDropOff: TMoneyEdit;
    Label25: TLabel;
    CmbTaxiDeliverTo: TComboBox;
    CmbTaxiCollectFrom: TComboBox;
    Label46: TLabel;
    Label47: TLabel;
    MemNotes: TMemo;
    Label19: TLabel;
    CurrPetrol: TAdvMoneyEdit;
    Panel3: TPanel;
    Label13: TLabel;
    CmbModel: TComboBox;
    CmbRegNo: TComboBox;
    CmbCarType: TComboBox;
    Cmbid: TComboBox;
    CmbCarGroup: TComboBox;
    Panel4: TPanel;
    ImgAddCustomer: TImage;
    Label55: TLabel;
    CurrDailyinsurance: TAdvMoneyEdit;
    Label57: TLabel;
    CurrExtra: TAdvMoneyEdit;
    LblC1: TLabel;
    LblC2: TLabel;
    LblC3: TLabel;
    LblC7: TLabel;
    LblC8: TLabel;
    LblC9: TLabel;
    LblC10: TLabel;
    LblC11: TLabel;
    LblC12: TLabel;
    LblC13: TLabel;
    LblC14: TLabel;
    LblC15: TLabel;
    LblC18: TLabel;
    GroupBox3: TGroupBox;
    Label14: TLabel;
    Label15: TLabel;
    Label40: TLabel;
    Label43: TLabel;
    CmbBabySeat: TComboBox;
    CmbBoosterSeat: TComboBox;
    Cmbinfantseat: TComboBox;
    CurrCase: TMoneyEdit;
    Label59: TLabel;
    Label61: TLabel;
    LblC22: TLabel;
    CurrDiscount: TAdvMoneyEdit;
    Label56: TLabel;
    TxtVoucherNo: TEdit;
    Label60: TLabel;
    TxtRoomNo: TEdit;
    BtnGun: TButton;
    LblExtensionDays: TLabel;
    LblExtensionTotal: TLabel;
    CurrExtensionTotal: TAdvMoneyEdit;
    LblC25: TLabel;
    Label63: TLabel;
    CurrTotalinsurance: TAdvMoneyEdit;
    LblC24: TLabel;
    CmbAgency: TComboBox;
    Label1: TLabel;
    Label52: TLabel;
    Label53: TLabel;
    Label54: TLabel;
    LblC20: TLabel;
    LblC21: TLabel;
    CurrTotalComission: TAdvMoneyEdit;
    CurrComission: TMoneyEdit;
    CurrLessinsurance: TAdvMoneyEdit;
    ChkFlightTime2: TCheckBox;
    DtFlightTime2: TDateTimePicker;
    lblExtensionRate: TLabel;
    CurrExtensionRate: TAdvMoneyEdit;
    LblC26: TLabel;
    CurrLowSeasonDays: TMoneyEdit;
    CurrMidSeasonDays: TMoneyEdit;
    CurrHighSeasonDays: TMoneyEdit;
    CurrExtensionDays: TMoneyEdit;
    CurrTotalDays: TMoneyEdit;
    BtnCommission: TButton;
    Panel1: TPanel;
    Panel6: TPanel;
    Label22: TLabel;
    CurrRemainingAmount: TAdvMoneyEdit;
    LblC27: TLabel;
    CmbPaymentMethod4: TComboBox;
    CmbPaidNote4: TComboBox;
    CmbPaidNote3: TComboBox;
    CmbPaidNote2: TComboBox;
    CmbPaidNote1: TComboBox;
    CmbPaymentMethod2: TComboBox;
    CmbPaymentMethod1: TComboBox;
    CurrPaidAmount4: TAdvMoneyEdit;
    CmbPaymentMethod3: TComboBox;
    CurrPaidAmount3: TAdvMoneyEdit;
    CurrPaidAmount2: TAdvMoneyEdit;
    CurrPaidAmount1: TAdvMoneyEdit;
    Label64: TLabel;
    Label62: TLabel;
    LblC23: TLabel;
    Label67: TLabel;
    LblC19: TLabel;
    LblC17: TLabel;
    LblC16: TLabel;
    Label58: TLabel;
    Label21: TLabel;
    CurrCompanyIncome: TAdvMoneyEdit;
    Label34: TLabel;
    CmbCompany: TComboBox;
    ChkDegisim: TCheckBox;
    procedure ImgSaveClick(Sender: TObject);
    procedure ImgEditClick(Sender: TObject);
    procedure ImgDeleteClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure SpeedButton4Click(Sender: TObject);

    procedure ImgAddCustomerClick(Sender: TObject);
    procedure ChkCollectTimeClick(Sender: TObject);
    procedure ChkDeliverTimeClick(Sender: TObject);
    procedure ImgCustomerSearchClick(Sender: TObject);
    procedure CmbNameChange(Sender: TObject);
    procedure CmbSurnameChange(Sender: TObject);
    procedure CmbContactNumberChange(Sender: TObject);
    procedure CmbPlaceofBirthChange(Sender: TObject);
    procedure RGrModeClick(Sender: TObject);
    procedure BtnOKClick(Sender: TObject);
    procedure BtnCalculateClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure CmbPassportNoChange(Sender: TObject);
    procedure CmbDrivingLicenseChange(Sender: TObject);
    procedure ImgTransfersClick(Sender: TObject);
    procedure ChkTaxiTimeDeliverClick(Sender: TObject);
    procedure ChkTaxiTimeCollectClick(Sender: TObject);
    procedure ChkFlightTimeClick(Sender: TObject);
    procedure MemAlinacakNotlarKeyPress(Sender: TObject; var Key: Char);
    procedure MemBirakilacakNotlarKeyPress(Sender: TObject; var Key: Char);
    procedure TxtFlightNumberKeyPress(Sender: TObject; var Key: Char);
    procedure TxtContractNumberKeyPress(Sender: TObject; var Key: Char);
    procedure CmbBirakilacakYerKeyPress(Sender: TObject; var Key: Char);
    procedure CmbTaxiDeliverFromChange(Sender: TObject);
    procedure CmbTaxiDeliverFromKeyPress(Sender: TObject; var Key: Char);
    procedure CmbalinacakyerKeyPress(Sender: TObject; var Key: Char);
    procedure CmbTaxiCollectToKeyPress(Sender: TObject; var Key: Char);
    procedure TxtReservationIdNoKeyPress(Sender: TObject; var Key: Char);
    procedure CurrComissionChange(Sender: TObject);
    procedure CmbTaxiDeliverToKeyPress(Sender: TObject; var Key: Char);
    procedure CmbTaxiCollectFromKeyPress(Sender: TObject; var Key: Char);
    procedure CmbAgencyKeyPress(Sender: TObject; var Key: Char);
    procedure CurrLessinsuranceChange(Sender: TObject);
    procedure CmbModelChange(Sender: TObject);
    procedure CmbRegNoChange(Sender: TObject);
    procedure BtnGunClick(Sender: TObject);
    procedure DtBirakilacakTarihChange(Sender: TObject);
    procedure DtAlinacakTarihChange(Sender: TObject);
    procedure DtBirakilacakSaatChange(Sender: TObject);
    procedure DtAlinacakSaatChange(Sender: TObject);
    procedure CmbCurrencyChange(Sender: TObject);
    procedure CurrExtensionRateChange(Sender: TObject);
    procedure CurrExtensionDaysChange(Sender: TObject);
    procedure BtnCommissionClick(Sender: TObject);
    procedure ChkFlightTime2Click(Sender: TObject);
    procedure ChkDegisimClick(Sender: TObject);
  private
    { Private declarations }
  public
    procedure Temizle; { Public declarations }
    procedure MusteriGetir;
    procedure AgencyGetir;
    Procedure CompanyGetir;
    Procedure PrintReservation;
    Procedure LogReservation(Desc:String);
    Procedure KayitGetir (id:String);
    procedure SabitDegerler;
    procedure ParaBirimi;

    var TmpCustomerID,PubKontrol:integer;
    PubDtAlinacakTarih:TDateTime ;
    PubExtensionDays:Currency;

    PubEmail,PubLocalNumber,PubName,PubSurname:String;
    Procedure TransferGetir;
    procedure CreateParams(var Params: TCreateParams); override;
  end;
 var
  FrmReservation2: TFrmReservation2;


implementation

uses  UntProjectGlobal, UntGlobal,
   UntCustomer, UntDlgCustomer, RepReservation, UntTransfers, UntTimeTable;

{$R *.dfm}

procedure TFrmReservation2.ImgSaveClick(Sender: TObject);
var TmpSql,TmpDateSeperator:string;
i,z:integer;
DateBirakilacak,DateBirakilacak1,DateAlinacak,DateAlinacak1:TDateTime;
TimeBirakilacak,TimeBirakilacak1,TimeAlinacak,TimeAlinacak1:TDateTime;
TmpTimeBirakilacak,TmpTimeAlinacak: integer;
begin
ProgramKullanmaDurumu:=ProgramKullanmaDurumu+1;
                    //FormatSettings.
TmpDateSeperator := FormatSettings.DateSeparator ;

Qry1.Close;
Qry1.SQL.Clear;
Qry1.SQL.Add('Select BlackList from Customer where id=:id ');
Qry1.Parameters.ParamByName('id').Value := TmpCustomerID ;
Qry1.Prepared;
Qry1.Open;

if qry1.FieldByName('Blacklist').AsString = 'Y' then
if MsgOnay('The Customer which you choose is at the black list!!!...Do you want to continue ? ') = False Then exit;

TmpTimeBirakilacak :=  HourOf(DtBirakilacakSaat.DateTime);
TmpTimeAlinacak    :=  HourOf(DtAlinacakSaat.DateTime);

if TmpTimeBirakilacak = 0 then   TmpTimeBirakilacak := 24 ;
if TmpTimeAlinacak = 0 then   TmpTimeAlinacak := 24 ;


if  HoursBetween(StrToDate('1'+TmpDateSeperator+'1'+TmpDateSeperator+'1900'),DtBirakilacakTarih.DateTime)+TmpTimeBirakilacak > HoursBetween(StrToDate('1'+TmpDateSeperator+'1'+TmpDateSeperator+'1900'),DtAlinacakTarih.DateTime)+TmpTimeAlinacak Then
Begin
MsgUyari('Deliver Date and Time Must Be Smaller or Equal Than Collection Date and Time!!! ');
exit;
end;

/////////////////////////////////////////KONTROL KISMI//////////////////////////////////////////////////////////////////

TmpSql := 'Select * from Reservation where Durum<>''Deleted'' and Carid=:Carid  ' ;

z:=0;
Qry1.Close;
qry1.SQL.Clear;
qry1.SQL.Add(TmpSql);
Qry1.Parameters.ParamByName('Carid').Value := Cmbid.Text  ;
qry1.Prepared;
qry1.Open;

for i:=1 to qry1.RecordCount do begin

DateBirakilacak  :=
EncodeDateTime(YearOf(DtBirakilacakTarih.Date),MonthOf(DtBirakilacakTarih.Date),DayOf(DtBirakilacakTarih.Date),HourOf(DtBirakilacakSaat.Time),MinuteOf(DtBirakilacakSaat.Time),0,0) ;
DateBirakilacak1 :=
EncodeDateTime(YearOf(Qry1.FieldByName('BirakilacakTarih').AsDateTime),MonthOf(Qry1.FieldByName('BirakilacakTarih').AsDateTime),DayOf(Qry1.FieldByName('BirakilacakTarih').AsDateTime),
HourOf(Qry1.FieldByName('BirakilacakSaat').AsDateTime),MinuteOf(Qry1.FieldByName('BirakilacakSaat').AsDateTime),0,0) ;
DateAlinacak  :=
EncodeDateTime(YearOf(DtAlinacakTarih.Date),MonthOf(DtAlinacakTarih.Date),DayOf(DtAlinacakTarih.Date),HourOf(DtAlinacakSaat.Time),MinuteOf(DtAlinacakSaat.Time),0,0) ;
DateAlinacak1 :=
EncodeDateTime(YearOf(Qry1.FieldByName('alinacakTarih').AsDateTime),MonthOf(Qry1.FieldByName('alinacakTarih').AsDateTime),DayOf(Qry1.FieldByName('alinacakTarih').AsDateTime),
HourOf(Qry1.FieldByName('AlinacakSaat').AsDateTime),MinuteOf(Qry1.FieldByName('AlinacakSaat').AsDateTime),0,0) ;

if ( DateBirakilacak <= DateAlinacak1 ) and ( DateAlinacak >= DateBirakilacak1 ) Then z:=1;

if z = 1 then begin
   MsgUyari('ERROR'+#13+#13+ 'Desired Date  :'+#13+DateTimeToStr(DateBirakilacak)+' - '+ DateTimeToStr(DateAlinacak) + #13 +
            'Date Crash With :'+#13+DateTimeToStr(DateBirakilacak1)+' - '+DateTimeToStr(DateAlinacak1) ) ;
   exit;
end;

qry1.Next;
end;
////////////////////////////////////////////////////////////////////////////////////////////////////////////

TmpSql:='insert into Reservation ' +
'(Company,Companyincome,Durum,Carid,CarModel,CarRegNo,CarGroup,CarType,Customerid,Name,Surname,ContactNumber,PassportId,LicenseNo,PlaceofBirth,AlinacakYer,alinacakTarih,AlinacakSaat,AlinacakNotlar,birakilacakYer,'+
'BirakilacakTarih,BirakilacakSaat,BirakilacakNotlar,Petrol,BabySeat,BoosterSeat,Agency,LowSeasonRate,LowSeasonDays,LowSeasonTotal,MidSeasonRate,MidSeasonDays,MidSeasonTotal,'+
'HighSeasonRate,HighSeasonDays,HighSeasonTotal,GeneralTotal,CollectTimeChecked,DeliverTimeChecked,FlightNumber,TotalDays,OutstandingBalance,ReservationDate,'+
'FlightTime,PaxsPickUp,PaxsDropOff,infantSeat,Cases,TaxiDeliverFrom,TaxiCollectFrom,TaxiDeliverTo,TaxiCollectTo,TaxiDateDeliver,TaxiTimeDeliver,TaxiDateCollect,TaxiTimeCollect,TaxiPickUp,'+
'TaxiDropOff,ContractNumber,ChkFlightTime,ChkTaxiTimeDeliver,ChkTaxiTimeCollect,currency,Notes,Lessinsurance,Commission,TotalComission,Sigorta,VoucherNo,RoomNo,Extra,Discount,'+
'Totalinsurance,Dailyinsurance,ChkFlightTime2,DtFlightTime2,ExtensionRate,ExtensionDays,Kontrol,ExtensionTotal,Name2,Surname2,'+
'PaymentMethod1,PaidAmount1,PaidNote1,PaymentMethod2,PaidAmount2,PaidNote2,PaymentMethod3,PaidAmount3,PaidNote3,PaymentMethod4,PaidAmount4,PaidNote4,email) ' +
'Values ( ' +
':Company,:Companyincome,:Durum,:Carid,:CarModel,:CarRegNo,:CarGroup,:CarType,:Customerid,:Name,:Surname,:ContactNumber,:PassportId,:LicenseNo,:PlaceofBirth,:AlinacakYer,:alinacakTarih,:AlinacakSaat,:AlinacakNotlar, '+
':birakilacakYer,:BirakilacakTarih,:BirakilacakSaat,:BirakilacakNotlar,:Petrol,:BabySeat,:BoosterSeat,:Agency,:LowSeasonRate,:LowSeasonDays,:LowSeasonTotal,:MidSeasonRate,:MidSeasonDays,'+
':MidSeasonTotal,:HighSeasonRate,:HighSeasonDays,:HighSeasonTotal,:GeneralTotal,:CollectTimeChecked,:DeliverTimeChecked,:FlightNumber,:TotalDays,:OutstandingBalance,'+
':ReservationDate,:FlightTime,:PaxsPickUp,:PaxsDropOff,:infantSeat,:Cases,:TaxiDeliverFrom,:TaxiCollectFrom,:TaxiDeliverTo,:TaxiCollectTo,:TaxiDateDeliver,:TaxiTimeDeliver,:TaxiDateCollect,'+
':TaxiTimeCollect,:TaxiPickUp,:TaxiDropOff,:ContractNumber,:ChkFlightTime,:ChkTaxiTimeDeliver,:ChkTaxiTimeCollect,:currency,:Notes,:Lessinsurance,:Commission,:TotalComission,:Sigorta,:VoucherNo,'+
':RoomNo,:Extra,:Discount,:Totalinsurance,:Dailyinsurance,:ChkFlightTime2,:DtFlightTime2,:ExtensionRate,:ExtensionDays,:Kontrol,:ExtensionTotal,:Name2,:Surname2,'+
':PaymentMethod1,:PaidAmount1,:PaidNote1,:PaymentMethod2,:PaidAmount2,:PaidNote2,:PaymentMethod3,:PaidAmount3,:PaidNote3,:PaymentMethod4,:PaidAmount4,:PaidNote4,:email) ' ;

qry1.Close;
qry1.SQL.Clear;
qry1.SQL.Add(TmpSql);
Qry1.Parameters.ParamByName('Company').Value          := Cmbcompany.text;
Qry1.Parameters.ParamByName('Companyincome').Value    := currCompanyIncome.Value    ;
Qry1.Parameters.ParamByName('Durum').Value            := 'Saved'    ;
Qry1.Parameters.ParamByName('Carid').Value            := Cmbid.Text    ;
Qry1.Parameters.ParamByName('CarModel').Value         := CmbModel.Text ;
Qry1.Parameters.ParamByName('CarRegNo').Value         := CmbRegNo.Text ;
Qry1.Parameters.ParamByName('CarGroup').Value         := CmbCarGroup.Text ;
Qry1.Parameters.ParamByName('CarType').Value          := CmbCarType.Text  ;
Qry1.Parameters.ParamByName('Customerid').Value       := TmpCustomerID;
Qry1.Parameters.ParamByName('Name').Value             := trim(Cmbname.Text);
Qry1.Parameters.ParamByName('Surname').Value          := trim(Cmbsurname.Text) ;
Qry1.Parameters.ParamByName('ContactNumber').Value    := trim(CmbContactNumber.Text);
Qry1.Parameters.ParamByName('PassportId').Value       := trim(CmbPassportNo.Text) ;
Qry1.Parameters.ParamByName('LicenseNo').Value        := trim(CmbDrivingLicense.Text);
Qry1.Parameters.ParamByName('PlaceofBirth').Value     := trim(CmbPlaceofBirth.Text);
Qry1.Parameters.ParamByName('AlinacakYer').Value      := trim(Cmbalinacakyer.Text) ;
Qry1.Parameters.ParamByName('alinacakTarih').Value    :=
IntToStr(YearOf(DtAlinacakTarih.Date))+'-'+IntToStr(MonthOf(DtAlinacakTarih.Date))+'-'+IntToStr(DayOf(DtAlinacakTarih.Date));
Qry1.Parameters.ParamByName('AlinacakSaat').Value     :=
IntToStr(HourOf(DtAlinacakSaat.Time))+':'+IntToStr(MinuteOf(DtAlinacakSaat.Time))+':'+IntToStr(SecondOf(DtAlinacakSaat.Time));
Qry1.Parameters.ParamByName('AlinacakNotlar').Value   := trim(MemAlinacakNotlar.Text) ;
Qry1.Parameters.ParamByName('birakilacakYer').Value   := trim(CmbBirakilacakYer.Text) ;
Qry1.Parameters.ParamByName('BirakilacakTarih').Value :=
IntToStr(YearOf(DtBirakilacakTarih.Date))+'-'+IntToStr(MonthOf(DtBirakilacakTarih.Date))+'-'+IntToStr(DayOf(DtBirakilacakTarih.Date));
Qry1.Parameters.ParamByName('BirakilacakSaat').Value  :=
IntToStr(HourOf(DtBirakilacakSaat.Time))+':'+IntToStr(MinuteOf(DtBirakilacakSaat.Time))+':'+IntToStr(SecondOf(DtBirakilacakSaat.Time));
Qry1.Parameters.ParamByName('BirakilacakNotlar').Value:= trim(MemBirakilacakNotlar.Text)    ;
Qry1.Parameters.ParamByName('Petrol').Value           := CurrPetrol.Value    ;
Qry1.Parameters.ParamByName('BabySeat').Value         := CmbBabySeat.Text    ;
Qry1.Parameters.ParamByName('BoosterSeat').Value      := CmbBoosterSeat.Text    ;
Qry1.Parameters.ParamByName('Agency').Value           := Trim(CmbAgency.Text)    ;
Qry1.Parameters.ParamByName('LowSeasonRate').Value    := CurrLowSeasonRate.Value    ;
Qry1.Parameters.ParamByName('LowSeasonDays').Value    := CurrLowSeasonDays.Value    ;
Qry1.Parameters.ParamByName('LowSeasonTotal').Value   := CurrLowSeasonTotal.Value    ;
Qry1.Parameters.ParamByName('MidSeasonRate').Value    := CurrMidSeasonRate.Value    ;
Qry1.Parameters.ParamByName('MidSeasonDays').Value    := CurrMidSeasonDays.Value    ;
Qry1.Parameters.ParamByName('MidSeasonTotal').Value   := CurrMidSeasonTotal.Value    ;
Qry1.Parameters.ParamByName('HighSeasonRate').Value   := CurrHighSeasonRate.Value    ;
Qry1.Parameters.ParamByName('HighSeasonDays').Value   := CurrHighSeasonDays.Value    ;
Qry1.Parameters.ParamByName('HighSeasonTotal').Value  := CurrHighSeasonTotal.Value    ;
Qry1.Parameters.ParamByName('GeneralTotal').Value     := CurrTotalAmount.Value    ;

if ChkCollectTime.Checked = True then
Qry1.Parameters.ParamByName('CollectTimeChecked').Value := 'Y'
Else Qry1.Parameters.ParamByName('CollectTimeChecked').Value := 'N';
if ChkDeliverTime.Checked = True then
Qry1.Parameters.ParamByName('DeliverTimeChecked').Value := 'Y'
Else Qry1.Parameters.ParamByName('DeliverTimeChecked').Value := 'N';
Qry1.Parameters.ParamByName('FlightNumber').Value      := Trim(TxtFlightNumber.Text) ;

Qry1.Parameters.ParamByName('TotalDays').Value          := CurrTotalDays.Value ;
Qry1.Parameters.ParamByName('OutstandingBalance').Value := CurrOutstandingBalance.Value ;

Qry1.Parameters.ParamByName('ReservationDate').Value    :=
IntToStr(YearOf(Date))+'-'+IntToStr(MonthOf(Date))+'-'+IntToStr(DayOf(Date));

Qry1.Parameters.ParamByName('FlightTime').Value  :=
IntToStr(HourOf(DtFlightTime.Time))+':'+IntToStr(MinuteOf(DtFlightTime.Time))+':'+IntToStr(SecondOf(DtFlightTime.Time));
Qry1.Parameters.ParamByName('PaxsPickUp').Value      := CurrPaxPickUp.Value ;
Qry1.Parameters.ParamByName('PaxsDropOff').Value     := CurrPaxDropOff.Value ;
Qry1.Parameters.ParamByName('infantSeat').Value      := Cmbinfantseat.Text ;
Qry1.Parameters.ParamByName('cases').Value           := CurrCase.Value ;
Qry1.Parameters.ParamByName('TaxiDeliverFrom').Value := Trim(CmbTaxiDeliverFrom.Text) ;
Qry1.Parameters.ParamByName('TaxiCollectFrom').Value := Trim(CmbTaxiCollectFrom.Text);
Qry1.Parameters.ParamByName('TaxiDeliverTo').Value   := Trim(CmbTaxiDeliverTo.Text) ;
Qry1.Parameters.ParamByName('TaxiCollectTo').Value   := Trim(CmbTaxiCollectTo.Text);
Qry1.Parameters.ParamByName('TaxiDateDeliver').Value :=
IntToStr(YearOf(DtTaxiDateDeliver.Date))+'-'+IntToStr(MonthOf(DtTaxiDateDeliver.Date))+'-'+IntToStr(DayOf(DtTaxiDateDeliver.Date));
Qry1.Parameters.ParamByName('TaxiTimeDeliver').Value :=
IntToStr(HourOf(DtTaxiTimeDeliver.Time))+':'+IntToStr(MinuteOf(DtTaxiTimeDeliver.Time))+':'+IntToStr(SecondOf(DtTaxiTimeDeliver.Time));
Qry1.Parameters.ParamByName('TaxiDateCollect').Value :=
IntToStr(YearOf(DtTaxiDateCollect.Date))+'-'+IntToStr(MonthOf(DtTaxiDateCollect.Date))+'-'+IntToStr(DayOf(DtTaxiDateCollect.Date));
Qry1.Parameters.ParamByName('TaxiTimeCollect').Value :=
IntToStr(HourOf(DtTaxiTimeCollect.Time))+':'+IntToStr(MinuteOf(DtTaxiTimeCollect.Time))+':'+IntToStr(SecondOf(DtTaxiTimeCollect.Time));
Qry1.Parameters.ParamByName('TaxiPickUp').Value     := CurrTaxiPickUp.Value ;
Qry1.Parameters.ParamByName('TaxiDropOff').Value    := CurrTaxiDropOff.Value ;
Qry1.Parameters.ParamByName('ContractNumber').Value := trim(TxtContractNumber.Text);
if ChkFlightTime.Checked = True then
Qry1.Parameters.ParamByName('ChkFlightTime').Value := 'Y'
Else Qry1.Parameters.ParamByName('ChkFlightTime').Value := 'N';
if ChkTaxiTimeDeliver.Checked = True then
Qry1.Parameters.ParamByName('ChkTaxiTimeDeliver').Value := 'Y'
Else Qry1.Parameters.ParamByName('ChkTaxiTimeDeliver').Value := 'N';
if ChkTaxiTimeCollect.Checked = True then
Qry1.Parameters.ParamByName('ChkTaxiTimeCollect').Value := 'Y'
Else Qry1.Parameters.ParamByName('ChkTaxiTimeCollect').Value := 'N';
Qry1.Parameters.ParamByName('Currency').Value       := CmbCurrency.Text ;
Qry1.Parameters.ParamByName('Notes').Value          := MemNotes.Text ;
Qry1.Parameters.ParamByName('Lessinsurance').Value  := CurrLessinsurance.Value ;
Qry1.Parameters.ParamByName('Commission').Value     := CurrComission.Value ;
Qry1.Parameters.ParamByName('TotalComission').Value := CurrTotalComission.Value ;
Qry1.Parameters.ParamByName('Sigorta').Value        := CurrTotalinsurance.Value ;
Qry1.Parameters.ParamByName('VoucherNo').Value      := TxtVoucherNo.Text ;
Qry1.Parameters.ParamByName('RoomNo').Value         := TxtRoomNo.Text ;
Qry1.Parameters.ParamByName('Extra').Value          := CurrExtra.Value ;
Qry1.Parameters.ParamByName('Discount').Value       := CurrDiscount.Value ;
Qry1.Parameters.ParamByName('Totalinsurance').Value := CurrTotalinsurance.Value ;
Qry1.Parameters.ParamByName('Dailyinsurance').Value := CurrDailyinsurance.Value ;

if ChkFlightTime2.Checked = True then
Qry1.Parameters.ParamByName('ChkFlightTime2').Value := 'Y'
Else Qry1.Parameters.ParamByName('ChkFlightTime2').Value := 'N';

Qry1.Parameters.ParamByName('DtFlightTime2').Value  :=
IntToStr(HourOf(DtFlightTime2.Time))+':'+IntToStr(MinuteOf(DtFlightTime2.Time))+':'+IntToStr(SecondOf(DtFlightTime2.Time));

Qry1.Parameters.ParamByName('ExtensionRate').Value   := CurrExtensionRate.Value ;
Qry1.Parameters.ParamByName('ExtensionDays').Value   := CurrExtensionDays.Value ;
Qry1.Parameters.ParamByName('ExtensionTotal').Value  := CurrExtensionTotal.Value ;


Qry2.Close;
qry2.SQL.Clear;
qry2.SQL.Add('Select Name2, Surname2,email from customer where id=:id');
Qry2.Parameters.ParamByName('id').Value := TmpCustomerID  ;
qry2.Prepared;
qry2.Open;
Qry1.Parameters.ParamByName('Name2').Value    := qry2.fieldbyname('Name2').asstring ;
Qry1.Parameters.ParamByName('Surname2').Value := qry2.fieldbyname('Surname2').asstring ;
Qry1.Parameters.ParamByName('email').Value    := qry2.fieldbyname('email').asstring ;

Qry1.Parameters.ParamByName('Kontrol').Value         := 'N' ;

///////////////////////////////// PAYMENT ///////////////////////////////////////
Qry1.Parameters.ParamByName('PaymentMethod1').Value  := CmbPaymentMethod1.Text  ;
Qry1.Parameters.ParamByName('PaidAmount1').Value     := CurrPaidAmount1.Value   ;
Qry1.Parameters.ParamByName('PaidNote1').Value       := CmbPaidNote1.Text       ;

Qry1.Parameters.ParamByName('PaymentMethod2').Value  := CmbPaymentMethod2.Text  ;
Qry1.Parameters.ParamByName('PaidAmount2').Value     := CurrPaidAmount2.Value   ;
Qry1.Parameters.ParamByName('PaidNote2').Value       := CmbPaidNote2.Text       ;

Qry1.Parameters.ParamByName('PaymentMethod3').Value  := CmbPaymentMethod3.Text  ;
Qry1.Parameters.ParamByName('PaidAmount3').Value     := CurrPaidAmount3.Value   ;
Qry1.Parameters.ParamByName('PaidNote3').Value       := CmbPaidNote3.Text       ;

Qry1.Parameters.ParamByName('PaymentMethod4').Value  := CmbPaymentMethod4.Text  ;
Qry1.Parameters.ParamByName('PaidAmount4').Value     := CurrPaidAmount4.Value   ;
Qry1.Parameters.ParamByName('PaidNote4').Value       := CmbPaidNote4.Text       ;
/////////////////////////////////////////////////////////////////////////////////


qry1.Prepared;
qry1.ExecSQL;

Qry1.Close;
Qry1.SQL.Clear;
Qry1.SQL.Add('Select max(id) as Tmpid from Reservation ');
Qry1.Open;
CmbModel.Tag := Qry1.FieldByName('Tmpid').AsInteger ;
TxtReservationIdNo.Text := Qry1.FieldByName('Tmpid').AsString ;


if MsgOnay('Do you want to print the current reservation ? ') = True Then PrintReservation;

FrmReservation2.ImgSave.Enabled     := False;
FrmReservation2.LblSave.Font.Color  := clGray;
FrmReservation2.LblSave.Enabled     := False;

FrmReservation2.ImgDelete.Enabled   := True;
FrmReservation2.LblDelete.Font.Color:= clWhite;
FrmReservation2.LblDelete.Enabled   := True;

FrmReservation2.ImgEdit.Enabled     := True ;
FrmReservation2.LblEdit.Font.Color  := clWhite;
FrmReservation2.LblEdit.Enabled     := True;

MsgUyari('Saved Successfull ...');
//PubButton.Click;
FrmReservation2.Temizle;
FrmReservation2.Close;


if Pubt=1 then begin
FrmTimeTable.BtnList.Click;
PubT:=0;
end;

end;


procedure TFrmReservation2.ImgTransfersClick(Sender: TObject);
var i:integer;
begin

if TxtReservationIdNo.Text='' then begin
MsgUyari('Lütfen Rezervasyonu Kaydediniz ...');
exit;
end;

if  assigned(FrmTransfers) then begin
if (FrmTransfers.WindowState = wsMinimized ) Then FrmTransfers.WindowState := wsNormal  ;
FrmTransfers.BringToFront;
exit;
end;

FrmTransfers:=TFrmTransfers.Create(Self);

FrmTransfers.DtArrivalTime.Format   := 'HH:mm';
FrmTransfers.DtDepartureTime.Format := 'HH:mm';

FrmTransfers.CmbAgency.Clear;
qry1.Close;
qry1.SQL.Clear;
qry1.SQL.Add('Select * from Agency');
qry1.open;

FrmTransfers.CmbAgency.Items.Add('') ;
for i := 0 to qry1.RecordCount -1 do begin
FrmTransfers.CmbAgency.Items.Add(qry1.FieldByName('AgencyName').AsString) ;
qry1.Next;
end;

FrmTransfers.DtArrivalDate.Date              := Date;
FrmTransfers.DtDepartureDate.Date            := Date;
FrmTransfers.Txtid.Text                      := Cmbid.Text ;
FrmTransfers.TxtModel.Text                   := CmbModel.Text ;
FrmTransfers.TxtRegNo.Text                   := CmbRegNo.Text ;
FrmTransfers.TxtCarGroup.Text                := CmbCarGroup.Text ;
FrmTransfers.TxtCarType.Text                 := CmbCarType.Text ;
FrmTransfers.DtArrivalTime.Time              := DtTaxiTimeDeliver.Time;
FrmTransfers.DtArrivalDate.Date              := DtTaxiDateDeliver.Date;
FrmTransfers.DtDepartureTime.Time            := DtTaxiTimeCollect.Time;
FrmTransfers.DtDepartureDate.Date            := DtTaxiDateCollect.Date;
FrmTransfers.CurrArrivalPax.Value            := CurrPaxPickUp.Value ;
FrmTransfers.CurrArrCase.Value               := CurrCase.Value ;
FrmTransfers.CmbArrivalBabySeat.ItemIndex    :=FrmTransfers.CmbArrivalBabySeat.items.IndexOf(CmbBabySeat.Text)  ;
FrmTransfers.CmbArrivalBoosterSeat.ItemIndex :=FrmTransfers.CmbArrivalBoosterSeat.items.IndexOf(CmbBoosterSeat.Text)  ;
FrmTransfers.CmbArrinfantseat.ItemIndex      :=FrmTransfers.CmbArrinfantseat.items.IndexOf(Cmbinfantseat.Text)  ;
FrmTransfers.CmbAgency.ItemIndex             :=FrmTransfers.CmbAgency.items.IndexOf(CmbAgency.Text)  ;
FrmTransfers.TxtName.Text                    := CmbName.Text           ;
FrmTransfers.TxtSurname.Text                 := CmbSurname.Text        ;
FrmTransfers.TxtContactNumber.Text           := CmbContactNumber.Text  ;
FrmTransfers.TxtPassportNo.Text              := CmbPassportNo.Text     ;
FrmTransfers.TxtDrivingLicense.Text          := CmbDrivingLicense.Text ;
FrmTransfers.TxtPlaceofBirth.Text            := CmbPlaceofBirth.Text   ;
FrmTransfers.ImgCustomerSearch.tag           := TmpCustomerID;
FrmTransfers.CurrArrivalPrice.Value          := CurrTaxiPickUp.Value ;
FrmTransfers.CurrDeparturePrice.Value        := CurrTaxiDropOff.Value ;
FrmTransfers.TxtArrivalFlightNo.Text         := TxtFlightNumber.Text ;
FrmTransfers.CmbArrivalCollectFrom.Text      := CmbTaxiDeliverFrom.Text ;
FrmTransfers.TxtArrivalDestination.Text      := CmbBirakilacakYer.Text ;
FrmTransfers.CmbDepartureCollectFrom.Text    := Cmbalinacakyer.Text ;
FrmTransfers.TxtDepartureDestination.Text    := CmbTaxiCollectTo.Text ;
FrmTransfers.PubReservasyonId                := TxtReservationIdNo.Text ;

TransferGetir;
FrmTransfers.Show;
end;

procedure TFrmReservation2.KayitGetir(id: String);
begin

PubKontrol := 1 ;

qry1.Close;
qry1.SQL.Clear;
qry1.SQL.Add('Select * from Reservation where id=:id ');
Qry1.Parameters.ParamByName('id').Value := id ;
qry1.Prepared;
qry1.Open;


CmbModel.Tag               := Qry1.FieldByName('id').AsInteger ;
TxtReservationIdNo.Text    := Qry1.FieldByName('id').AsString ;

CmbCompany.Text            := Qry1.FieldByName('Company').AsString ;
CurrCompanyIncome.Value    := Qry1.FieldByName('CompanyIncome').AsCurrency ;


Cmbid.ItemIndex            := Cmbid.Items.IndexOf(Qry1.FieldByName('Carid').AsString) ;
CmbRegNo.ItemIndex         := CmbRegNo.Items.IndexOf(Qry1.FieldByName('CarRegNo').AsString) ;
CmbModel.ItemIndex         := CmbModel.Items.IndexOf(Qry1.FieldByName('CarModel').AsString) ;
CmbCarGroup.ItemIndex      := CmbCarGroup.Items.IndexOf(Qry1.FieldByName('CarGroup').AsString) ;
CmbCarType.ItemIndex       := CmbCarType.Items.IndexOf(Qry1.FieldByName('CarType').AsString) ;
CmbCustomerId.ItemIndex    := FrmReservation2.CmbCustomerId.Items.IndexOf(Qry1.FieldByName('Customerid').AsString)  ;
CmbName.ItemIndex          := FrmReservation2.CmbName.Items.IndexOf(Qry1.FieldByName('Name').AsString)              ;
CmbSurname.ItemIndex       := FrmReservation2.CmbSurname.Items.IndexOf(Qry1.FieldByName('Surname').AsString)        ;
CmbContactNumber.ItemIndex := FrmReservation2.CmbContactNumber.Items.IndexOf(Qry1.FieldByName('ContactNumber').AsString);
CmbPassportNo.ItemIndex    := FrmReservation2.CmbPassportNo.Items.IndexOf(Qry1.FieldByName('PassportId').AsString)  ;
CmbDrivingLicense.ItemIndex:= FrmReservation2.CmbDrivingLicense.Items.IndexOf(Qry1.FieldByName('LicenseNo').AsString);
CmbPlaceofBirth.ItemIndex  := FrmReservation2.CmbPlaceofBirth.Items.IndexOf(Qry1.FieldByName('PlaceofBirth').AsString);
TmpCustomerID              := Qry1.FieldByName('Customerid').AsInteger         ;
Cmbalinacakyer.Text        := Qry1.FieldByName('AlinacakYer').asstring        ;
DtAlinacakTarih.Date       := Qry1.FieldByName('alinacakTarih').AsDateTime    ;
PubDtAlinacakTarih         := Qry1.FieldByName('alinacakTarih').AsDateTime    ;
DtAlinacakSaat.Time        := Qry1.FieldByName('AlinacakSaat').AsDateTime     ;
MemAlinacakNotlar.Text     := Qry1.FieldByName('AlinacakNotlar').asstring     ;
CmbBirakilacakYer.Text     := Qry1.FieldByName('birakilacakYer').asstring     ;
DtBirakilacakTarih.Date    := Qry1.FieldByName('BirakilacakTarih').AsDateTime ;
DtBirakilacakSaat.Time     := Qry1.FieldByName('BirakilacakSaat').AsDateTime  ;
MemBirakilacakNotlar.Text  := Qry1.FieldByName('BirakilacakNotlar').asstring  ;
CurrPetrol.Value           := Qry1.FieldByName('Petrol').AsCurrency;           ;
CmbBabySeat.ItemIndex      := CmbBabySeat.Items.IndexOf(Qry1.FieldByName('BabySeat').asstring)       ;
CmbBoosterSeat.ItemIndex   := CmbBoosterSeat.Items.IndexOf(Qry1.FieldByName('BoosterSeat').asstring) ;
CmbAgency.ItemIndex        := CmbAgency.Items.IndexOf(Qry1.FieldByName('Agency').asstring)           ;


if Qry1.FieldByName('CollectTimeChecked').AsString = 'Y' then ChkCollectTime.Checked := True
Else ChkCollectTime.Checked := False;
if Qry1.FieldByName('DeliverTimeChecked').AsString = 'Y' then ChkDeliverTime.Checked := True
Else ChkDeliverTime.Checked := False;

TxtFlightNumber.Text         := Qry1.FieldByName('FlightNumber').AsString ;
DtFlightTime.Time            := Qry1.FieldByName('FlightTime').AsDateTime  ;
CurrPaxPickUp.Value          := Qry1.FieldByName('PaxsPickUp').AsCurrency ;
CurrPaxDropOff.Value         := Qry1.FieldByName('PaxsDropOff').AsCurrency ;
Cmbinfantseat.ItemIndex      := FrmReservation2.Cmbinfantseat.Items.IndexOf(Qry1.FieldByName('infantSeat').AsString) ;
CurrCase.Value               := Qry1.FieldByName('cases').AsCurrency ;
CmbTaxiDeliverFrom.Text      := Qry1.FieldByName('TaxiDeliverFrom').AsString  ;
CmbTaxiDeliverTo.Text        := Qry1.FieldByName('TaxiDeliverTo').AsString    ;
CmbTaxiCollectFrom.Text      := Qry1.FieldByName('TaxiCollectFrom').AsString  ;
CmbTaxiCollectTo.Text        := Qry1.FieldByName('TaxiCollectTo').AsString    ;
DtTaxiDateDeliver.Date       := Qry1.FieldByName('TaxiDateDeliver').AsDateTime ;
DtTaxiTimeDeliver.Time       := Qry1.FieldByName('TaxiTimeDeliver').AsDateTime ;
DtTaxiDateCollect.Date       := Qry1.FieldByName('TaxiDateCollect').AsDateTime ;
DtTaxiTimeCollect.Time       := Qry1.FieldByName('TaxiTimeCollect').AsDateTime ;
CurrLowSeasonRate.Value      := Qry1.FieldByName('LowSeasonRate').AsFloat  ;
CurrLowSeasonDays.Value      := Qry1.FieldByName('LowSeasonDays').AsFloat  ;
CurrLowSeasonTotal.Value     := Qry1.FieldByName('LowSeasonTotal').AsFloat  ;
CurrMidSeasonRate.Value      := Qry1.FieldByName('MidSeasonRate').AsFloat  ;
CurrMidSeasonDays.Value      := Qry1.FieldByName('MidSeasonDays').AsFloat  ;
CurrMidSeasonTotal.Value     := Qry1.FieldByName('MidSeasonTotal').AsFloat  ;
CurrHighSeasonRate.Value     := Qry1.FieldByName('HighSeasonRate').AsFloat  ;
CurrHighSeasonDays.Value     := Qry1.FieldByName('HighSeasonDays').AsFloat  ;
CurrHighSeasonTotal.Value    := Qry1.FieldByName('HighSeasonTotal').AsFloat  ;
CurrTotalAmount.Value        := Qry1.FieldByName('GeneralTotal').AsFloat      ;
CurrTaxiPickUp.Value         := Qry1.FieldByName('TaxiPickUp').AsCurrency ;
CurrTaxiDropOff.Value        := Qry1.FieldByName('TaxiDropOff').AsCurrency ;
CurrOutstandingBalance.Value := Qry1.FieldByName('OutstandingBalance').AsCurrency ;
TxtContractNumber.Text       := Qry1.FieldByName('ContractNumber').AsString ;
MemNotes.Text                := Qry1.FieldByName('Notes').AsString ;

if Qry1.FieldByName('ChkFlightTime').AsString = 'Y' then FrmReservation2.ChkFlightTime.Checked := True
Else ChkFlightTime.Checked := False;
if Qry1.FieldByName('ChkTaxiTimeDeliver').AsString = 'Y' then FrmReservation2.ChkTaxiTimeDeliver.Checked := True
Else ChkTaxiTimeDeliver.Checked := False;
if Qry1.FieldByName('ChkTaxiTimeCollect').AsString = 'Y' then FrmReservation2.ChkTaxiTimeCollect.Checked := True
Else FrmReservation2.ChkTaxiTimeCollect.Checked := False;

CmbCurrency.ItemIndex    := CmbCurrency.Items.IndexOf(Qry1.FieldByName('currency').AsString) ;
CurrLessinsurance.Value  := Qry1.FieldByName('Lessinsurance').AsCurrency ;
CurrComission.Value      := Qry1.FieldByName('Commission').AsCurrency ;
CurrTotalComission.Value := Qry1.FieldByName('TotalComission').AsCurrency ;

TxtRoomNo.Text        := Qry1.FieldByName('RoomNo').AsString ;
CurrExtra.Value       := Qry1.FieldByName('Extra').AsCurrency ;
CurrTotalDays.Value   := Qry1.FieldByName('TotalDays').AsCurrency ;

CurrTotalinsurance.Value := Qry1.FieldByName('Totalinsurance').AsCurrency ;
CurrDailyinsurance.Value := Qry1.FieldByName('Dailyinsurance').AsCurrency ;
CmbPaymentMethod2.Text   := Qry1.FieldByName('PaymentMethod2').AsString ;
CurrPaidAmount2.Value    := Qry1.FieldByName('PaidAmount2').AsCurrency ;
if Qry1.FieldByName('ChkFlightTime2').AsString = 'Y' then ChkFlightTime2.Checked := True
Else ChkFlightTime2.Checked := False;
DtFlightTime2.DateTime   := Qry1.FieldByName('DtFlightTime2').AsDateTime ;

CurrExtensionRate.Value  := Qry1.FieldByName('ExtensionRate').AsCurrency  ;
CurrExtensionDays.Value  := Qry1.FieldByName('ExtensionDays').AsCurrency  ;
PubExtensionDays         := Qry1.FieldByName('ExtensionDays').AsCurrency  ;
CurrExtensionTotal.Value := Qry1.FieldByName('ExtensionTotal').AsCurrency ;
CurrDiscount.Value       := Qry1.FieldByName('Discount').AsCurrency ;


///////////////////////////////// PAYMENT ///////////////////////////////////////
CmbPaymentMethod1.Text := Qry1.FieldByName('PaymentMethod1').AsString ;
CurrPaidAmount1.Value  := Qry1.FieldByName('PaidAmount1').AsCurrency ;
CmbPaidNote1.Text      := Qry1.FieldByName('PaidNote1').AsString ;

CmbPaymentMethod2.Text := Qry1.FieldByName('PaymentMethod2').AsString ;
CurrPaidAmount2.Value  := Qry1.FieldByName('PaidAmount2').AsCurrency ;
CmbPaidNote2.Text      := Qry1.FieldByName('PaidNote2').AsString ;

CmbPaymentMethod3.Text := Qry1.FieldByName('PaymentMethod3').AsString ;
CurrPaidAmount3.Value  := Qry1.FieldByName('PaidAmount3').AsCurrency ;
CmbPaidNote3.Text      := Qry1.FieldByName('PaidNote3').AsString ;

CmbPaymentMethod4.Text := Qry1.FieldByName('PaymentMethod4').AsString ;
CurrPaidAmount4.Value  := Qry1.FieldByName('PaidAmount4').AsCurrency ;
CmbPaidNote4.Text      := Qry1.FieldByName('PaidNote4').AsString ;
/////////////////////////////////////////////////////////////////////////////////


if TmpCustomerID = 0 Then GrpCustomer.Enabled:=True
Else GrpCustomer.Enabled:=False;

if (Trim(CmbName.Text) = '') and (Trim(CmbSurname.Text) = '') Then GrpCustomer.Enabled:=True
Else GrpCustomer.Enabled:=False;



ParaBirimi;

ImgSave.Enabled     := False;
LblSave.Font.Color  := clGray;
LblSave.Enabled     := False;

ImgDelete.Enabled   := True;
LblDelete.Font.Color:= clWhite;
LblDelete.Enabled   := True;

ImgEdit.Enabled     := True ;
LblEdit.Font.Color  := clWhite;
LblEdit.Enabled     := True;


lblExtensionRate.Visible   := True ;
CurrExtensionRate.Visible  := True ;
LblC26.Visible             := True ;

LblExtensionDays.Visible   := True ;
CurrExtensionDays.Visible  := True ;

LblExtensionTotal.Visible  := True ;
CurrExtensionTotal.Visible := True ;
LblC25.Visible             := True ;

PubKontrol := 0 ;

end;

Procedure TFrmReservation2.LogReservation(Desc:String);
var TmpSql:String ;
begin
{
TmpSql:='insert into LogReservation ' +
'(UserName,TDate,TTime,Description,ReservationId,Carid,CarModel,CarRegNo,CarGroup,CarType,Customerid,Name,Surname,ContactNumber,PassportId,LicenseNo,PlaceofBirth,AlinacakYer,alinacakTarih,AlinacakSaat,AlinacakNotlar, '+
' birakilacakYer,BirakilacakTarih,BirakilacakSaat,BirakilacakNotlar,Petrol,BabySeat,BoosterSeat,Agency,Commission,DailyRate,Total,ReservationNo,Deposit,CollectTimeChecked,DeliverTimeChecked,'+
'FlightNumber,Paid,TotalDays,OutstandingBalance,PaymentAmount) '+
'Values ( ' +
':UserName,:TDate,:TTime,:Description,:ReservationId,:Carid,:CarModel,:CarRegNo,:CarGroup,:CarType,:Customerid,:Name,:Surname,:ContactNumber,:PassportId,:LicenseNo,:PlaceofBirth,:AlinacakYer,:alinacakTarih,:AlinacakSaat,:AlinacakNotlar, '+
':birakilacakYer,:BirakilacakTarih,:BirakilacakSaat,:BirakilacakNotlar,:Petrol,:BabySeat,:BoosterSeat,:Agency,:Commission,:DailyRate,:Total,:ReservationNo,:Deposit,:CollectTimeChecked,:DeliverTimeChecked,'+
':FlightNumber,:Paid,:TotalDays,:OutstandingBalance,:PaymentAmount)';

qry1.Close;
qry1.SQL.Clear;
qry1.SQL.Add(TmpSql);

Qry1.Parameters.ParamByName('UserName').Value         := Kullanici  ;


Qry1.Parameters.ParamByName('TDate').Value := IntToStr(YearOf(Date))+'-'+
                                              IntToStr(MonthOf(Date))+'-'+
                                              IntToStr(DayOf(Date));

Qry1.Parameters.ParamByName('TTime').Value  := IntToStr(HourOf(Now))+':'+
                                               IntToStr(MinuteOf(Now))+':'+
                                               IntToStr(SecondOf(Now));

Qry1.Parameters.ParamByName('Description').Value      := Desc     ;
Qry1.Parameters.ParamByName('ReservationId').Value    := TxtReservationIdNo.Text ;

Qry1.Parameters.ParamByName('Carid').Value            := Txtid.Text    ;
Qry1.Parameters.ParamByName('CarModel').Value         := TxtModel.Text ;
Qry1.Parameters.ParamByName('CarRegNo').Value         := TxtRegNo.Text ;
Qry1.Parameters.ParamByName('CarGroup').Value         := TxtCarGroup.Text ;
Qry1.Parameters.ParamByName('CarType').Value          := TxtCarType.Text  ;

Qry1.Parameters.ParamByName('Customerid').Value       := TmpCustomerID;
Qry1.Parameters.ParamByName('Name').Value             := trim(Cmbname.Text);
Qry1.Parameters.ParamByName('Surname').Value          := trim(Cmbsurname.Text) ;
Qry1.Parameters.ParamByName('ContactNumber').Value    := trim(CmbContactNumber.Text);
Qry1.Parameters.ParamByName('PassportId').Value       := trim(CmbPassportNo.Text) ;
Qry1.Parameters.ParamByName('LicenseNo').Value        := trim(CmbDrivingLicense.Text);
Qry1.Parameters.ParamByName('PlaceofBirth').Value     := trim(CmbPlaceofBirth.Text);

Qry1.Parameters.ParamByName('AlinacakYer').Value      := trim(Cmbalinacakyer.Text) ;

Qry1.Parameters.ParamByName('alinacakTarih').Value := IntToStr(YearOf(DtAlinacakTarih.Date))+'-'+
                                                      IntToStr(MonthOf(DtAlinacakTarih.Date))+'-'+
                                                      IntToStr(DayOf(DtAlinacakTarih.Date));

Qry1.Parameters.ParamByName('AlinacakSaat').Value     := IntToStr(HourOf(DtAlinacakSaat.Time))+':'+
                                                         IntToStr(MinuteOf(DtAlinacakSaat.Time))+':'+
                                                         IntToStr(SecondOf(DtAlinacakSaat.Time));

Qry1.Parameters.ParamByName('AlinacakNotlar').Value   := trim(MemAlinacakNotlar.Text)    ;
Qry1.Parameters.ParamByName('birakilacakYer').Value   := trim(CmbBirakilacakYer.Text) ;

Qry1.Parameters.ParamByName('BirakilacakTarih').Value := IntToStr(YearOf(DtBirakilacakTarih.Date))+'-'+
                                                         IntToStr(MonthOf(DtBirakilacakTarih.Date))+'-'+
                                                         IntToStr(DayOf(DtBirakilacakTarih.Date));

Qry1.Parameters.ParamByName('BirakilacakSaat').Value  := IntToStr(HourOf(DtBirakilacakSaat.Time))+':'+
                                                         IntToStr(MinuteOf(DtBirakilacakSaat.Time))+':'+
                                                         IntToStr(SecondOf(DtBirakilacakSaat.Time));

Qry1.Parameters.ParamByName('BirakilacakNotlar').Value:= trim(MemBirakilacakNotlar.Text)    ;
Qry1.Parameters.ParamByName('Petrol').Value           := CmbPetrol.Text    ;
Qry1.Parameters.ParamByName('BabySeat').Value         := CmbBabySeat.Text    ;
Qry1.Parameters.ParamByName('BoosterSeat').Value      := CmbBoosterSeat.Text    ;
Qry1.Parameters.ParamByName('Agency').Value           := Trim(CmbAgency.Text)    ;
Qry1.Parameters.ParamByName('Commission').Value       := CurrCommission.Value    ;
Qry1.Parameters.ParamByName('DailyRate').Value        := CurrDailyRate.Value    ;
Qry1.Parameters.ParamByName('Total').Value            := CurrTotal.Value    ;
Qry1.Parameters.ParamByName('ReservationNo').Value    := TxtReservationNo.Text    ;
Qry1.Parameters.ParamByName('Deposit').Value          := CurrDeposit.Value    ;


if ChkCollectTime.Checked = True then
Qry1.Parameters.ParamByName('CollectTimeChecked').Value := 'Y'
Else Qry1.Parameters.ParamByName('CollectTimeChecked').Value := 'N';

if ChkDeliverTime.Checked = True then
Qry1.Parameters.ParamByName('DeliverTimeChecked').Value := 'Y'
Else Qry1.Parameters.ParamByName('DeliverTimeChecked').Value := 'N';

Qry1.Parameters.ParamByName('FlightNumber').Value   := Trim(TxtFlightNumber.Text) ;

if ChkPaid.Checked = True then
Qry1.Parameters.ParamByName('Paid').Value := 'Y'
Else Qry1.Parameters.ParamByName('Paid').Value := 'N';

Qry1.Parameters.ParamByName('TotalDays').Value          := CurrTotalDays.Value ;
Qry1.Parameters.ParamByName('OutstandingBalance').Value := CurrOutstandingBalance.Value ;

Qry1.Parameters.ParamByName('PaymentAmount').Value := CurrPaymentAmount.Value ;
}
qry1.Prepared;
qry1.ExecSQL;

end;

procedure TFrmReservation2.MemAlinacakNotlarKeyPress(Sender: TObject;
  var Key: Char);
begin
key  := BuyukHarfMemo(key,Sender as TMemo);
end;

procedure TFrmReservation2.MemBirakilacakNotlarKeyPress(Sender: TObject;
  var Key: Char);
begin
key  := BuyukHarfMemo(key,Sender as TMemo);
end;

procedure TFrmReservation2.CurrLessinsuranceChange(Sender: TObject);
begin
BtnCommission.Click;


end;

procedure TFrmReservation2.DtAlinacakSaatChange(Sender: TObject);
begin
BtnGun.Click;
end;

procedure TFrmReservation2.DtAlinacakTarihChange(Sender: TObject);
begin
BtnGun.Click;
end;

procedure TFrmReservation2.DtBirakilacakSaatChange(Sender: TObject);
begin
BtnGun.Click;
end;

procedure TFrmReservation2.DtBirakilacakTarihChange(Sender: TObject);
begin
BtnGun.Click;
end;

procedure TFrmReservation2.CurrComissionChange(Sender: TObject);
begin
BtnCommission.Click;

end;

procedure TFrmReservation2.CurrExtensionDaysChange(Sender: TObject);
begin
if PubKontrol=1 Then Exit;

DtAlinacakTarih.Date :=  PubDtAlinacakTarih + (CurrExtensionDays.Value - PubExtensionDays ) ;
BtnCalculate.Click;
end;

procedure TFrmReservation2.CurrExtensionRateChange(Sender: TObject);
begin
BtnCalculate.Click;
end;

procedure TFrmReservation2.MusteriGetir;
var i:integer;
begin

CmbPassportNo.Clear;
CmbCustomerId.Clear;
CmbContactNumber.Clear;
CmbName.Clear;
CmbSurname.Clear;
CmbDrivingLicense.Clear;
CmbPlaceofBirth.Clear;

qry1.Close;
qry1.SQL.Clear;
qry1.SQL.Add('Select * from Customer order by surname,name');
qry1.open;
for i := 0 to qry1.RecordCount-1 do begin

CmbPassportNo.Items.Add(qry1.FieldByName('PassportId').AsString) ;
CmbCustomerId.Items.Add(qry1.FieldByName('id').AsString) ;
CmbPlaceofBirth.Items.Add(qry1.FieldByName('PlaceofBirth').AsString) ;
CmbName.Items.Add(qry1.FieldByName('Name').AsString) ;
CmbSurname.Items.Add(qry1.FieldByName('Surname').AsString) ;
CmbContactNumber.Items.Add(qry1.FieldByName('TelNo').AsString) ;
CmbDrivingLicense.Items.Add(qry1.FieldByName('LicenseNo').AsString) ;

qry1.Next;
end;

end;

procedure TFrmReservation2.ParaBirimi;
var TmpCurr:String;
begin

if CmbCurrency.Text = 'TL'      then TmpCurr:='TL';
if CmbCurrency.Text = 'EURO'    then TmpCurr:='€' ;
if CmbCurrency.Text = 'STERLIN' then TmpCurr:='£' ;
if CmbCurrency.Text = 'DOLLAR'  then TmpCurr:='$' ;

LblC1.Caption  := TmpCurr ;
LblC2.Caption  := TmpCurr ;
LblC3.Caption  := TmpCurr ;
LblC7.Caption  := TmpCurr ;
LblC8.Caption  := TmpCurr ;
LblC9.Caption  := TmpCurr ;
LblC10.Caption := TmpCurr ;
LblC11.Caption := TmpCurr ;
LblC12.Caption := TmpCurr ;
LblC13.Caption := TmpCurr ;
LblC14.Caption := TmpCurr ;
LblC15.Caption := TmpCurr ;
LblC16.Caption := TmpCurr ;
LblC17.Caption := TmpCurr ;
LblC18.Caption := TmpCurr ;
LblC19.Caption := TmpCurr ;
LblC20.Caption := TmpCurr ;
LblC21.Caption := TmpCurr ;
LblC22.Caption := TmpCurr ;
LblC23.Caption := TmpCurr ;
LblC24.Caption := TmpCurr ;
LblC25.Caption := TmpCurr ;
LblC26.Caption := TmpCurr ;
LblC27.Caption := TmpCurr ;
end;

procedure TFrmReservation2.PrintReservation;
var TmpSql,TmpCurr:String;
begin

if CmbCurrency.Text = 'TL'      then TmpCurr:='TL';
if CmbCurrency.Text = 'EURO'    then TmpCurr:='€' ;
if CmbCurrency.Text = 'STERLIN' then TmpCurr:='£' ;
if CmbCurrency.Text = 'DOLLAR'  then TmpCurr:='$' ;



TmpSql := 'Select * from reservation where id=:id' ;

Qry1.Close;
qry1.SQL.Clear;
qry1.SQL.Add(TmpSql);
Qry1.Parameters.ParamByName('id').Value := CmbModel.Tag ;
Qry1.Prepared;
qry1.Open;

QRepReservation:=TQRepReservation.Create(self);


QRepReservation.QrlTarih.Caption                   := DateToStr(date) +'   '+TimeTostr(Time) ;
QRepReservation.QrlPickupDateDeliver.Caption       := Qry1.FieldByName('TaxiDateDeliver').AsString ;
QRepReservation.QrlPickUpTimeDeliver.Caption       := Qry1.FieldByName('TaxiTimeDeliver').AsString ;
QRepReservation.QrlPickUpPaxs.Caption              := 'Paxs : '+Qry1.FieldByName('PaxsPickUp').AsString ;
QRepReservation.QrlDropOffDateDeliver.Caption      := Qry1.FieldByName('TaxiDateCollect').AsString ;
QRepReservation.QrlDropOffTimeDeliver.Caption      := Qry1.FieldByName('TaxiTimeCollect').AsString ;
QRepReservation.QrlDropOffPaxs.Caption             := 'Paxs : '+Qry1.FieldByName('PaxsDropOff').AsString ;
QRepReservation.QrlReservarionNo.Caption           := Qry1.FieldByName('id').AsString ;
QRepReservation.QrlFlightNumber.Caption            := Qry1.FieldByName('FlightNumber').AsString ;
QRepReservation.QrlFlightTime.Caption              := Qry1.FieldByName('FlightTime').AsString ;
QRepReservation.QrlRoomNo.Caption                  := Qry1.FieldByName('RoomNo').AsString ;
QRepReservation.QrlCurrency.Caption                := Qry1.FieldByName('currency').AsString ;
QRepReservation.QrlContactNumber.Caption           := Qry1.FieldByName('ContractNumber').AsString ;
QRepReservation.QrlNotes.Caption                   := Qry1.FieldByName('Notes').AsString ;
QRepReservation.QrlVoutcherNo.Caption              := Qry1.FieldByName('VoucherNo').AsString ;
QRepReservation.QrlDeliverTo.Caption               := Qry1.FieldByName('BirakilacakYer').AsString ;
QRepReservation.QrlDeliverDateandTime.Caption      := Qry1.FieldByName('BirakilacakTarih').AsString +' '+ Qry1.FieldByName('BirakilacakSaat').AsString  ;
QRepReservation.QrlDeliverNotes.Caption            := Qry1.FieldByName('BirakilacakNotlar').AsString ;
QRepReservation.QrlCollectDateandTime.Caption      := Qry1.FieldByName('AlinacakTarih').AsString ;
QRepReservation.QrlCollectFrom.Caption             := Qry1.FieldByName('AlinacakYer').AsString ;
QRepReservation.QrlCollectNotes.Caption            := Qry1.FieldByName('AlinacakNotlar').AsString +' '+ Qry1.FieldByName('AlinacakSaat').AsString  ;
QRepReservation.QrlDropOffFlightTime.Caption       := Qry1.FieldByName('DtFlightTime2').AsString ;
QRepReservation.QrlPickUpFrom.Caption              := Qry1.FieldByName('TaxiDeliverFrom').AsString ;
QRepReservation.QrlPickUpTo.Caption                := Qry1.FieldByName('TaxiDeliverTo').AsString ;
QRepReservation.QrlDropOfFrom.Caption              := Qry1.FieldByName('TaxiCollectFrom').AsString ;
QRepReservation.QrlDropOfTo.Caption                := Qry1.FieldByName('TaxiCollectTo').AsString ;
QRepReservation.QrlCarModel.Caption                := Qry1.FieldByName('CarModel').AsString ;
QRepReservation.QrlCarRegNo.Caption                := Qry1.FieldByName('CarRegNo').AsString ;
QRepReservation.QrlSurname.Caption                 := Qry1.FieldByName('Surname').AsString ;
QRepReservation.QrlCustomerContactNumber.Caption   := Qry1.FieldByName('ContactNumber').AsString ;
QRepReservation.QrlPassportNo.Caption              := Qry1.FieldByName('Passportid').AsString ;
QRepReservation.QrlDrivingLicense.Caption          := Qry1.FieldByName('LicenseNo').AsString ;
QRepReservation.QrlPlaceOfBirth.Caption            := Qry1.FieldByName('PlaceOfBirth').AsString ;
QRepReservation.QrlName.Caption                    := Qry1.FieldByName('Name').AsString ;
QRepReservation.QrlAgency.Caption                  := Qry1.FieldByName('Agency').AsString ;
QRepReservation.QrlLessInsurance.Caption           := FormatFloat('#,##0.00',Qry1.FieldByName('Lessinsurance').AsCurrency)+' '+TmpCurr ;
QRepReservation.QrlCommission.Caption              := FormatFloat('#,##0.00',Qry1.FieldByName('Commission').AsCurrency)+' '+TmpCurr ;
QRepReservation.QrlTotalCommission.Caption         := FormatFloat('#,##0.00',Qry1.FieldByName('TotalComission').AsCurrency)+' '+TmpCurr ;
QRepReservation.QrlCases.Caption                   := Qry1.FieldByName('Cases').AsString ;
QRepReservation.QrlInfantSeat.Caption              := Qry1.FieldByName('infantseat').AsString ;
QRepReservation.QrlBabySeat.Caption                := Qry1.FieldByName('BabySeat').AsString ;
QRepReservation.QrlBoosterSeat.Caption             := Qry1.FieldByName('BoosterSeat').AsString ;
QRepReservation.QrlLowSeasonRate.Caption           := FormatFloat('#,##0.00',Qry1.FieldByName('LowSeasonRate').AsCurrency)+' '+TmpCurr ;
QRepReservation.QrlMidSeasonRate.Caption           := FormatFloat('#,##0.00',Qry1.FieldByName('MidSeasonRate').AsCurrency)+' '+TmpCurr ;
QRepReservation.QrlExtensionRate.Caption           := FormatFloat('#,##0.00',Qry1.FieldByName('extensionrate').AsCurrency)+' '+TmpCurr ;
QRepReservation.QrlHighSeasonRate.Caption          := FormatFloat('#,##0.00',Qry1.FieldByName('highSeasonRate').AsCurrency)+' '+TmpCurr ;
QRepReservation.QrlInsuranceRate.Caption           := FormatFloat('#,##0.00',Qry1.FieldByName('dailyinsurance').AsCurrency)+' '+TmpCurr ;
QRepReservation.QrlLowSeasonDays.Caption           := Qry1.FieldByName('LowSeasonDays').AsString ;
QRepReservation.QrlMidSeasonDays.Caption           := Qry1.FieldByName('MidSeasonDays').AsString ;
QRepReservation.QrlExtensionDays.Caption           := Qry1.FieldByName('extensiondays').AsString ;
QRepReservation.QrlHighSeasonDays.Caption          := Qry1.FieldByName('HighSeasonDays').AsString ;
QRepReservation.QrlTotalDays.Caption               := Qry1.FieldByName('TotalDays').AsString ;
QRepReservation.QrlLowseasonTotal.Caption          := FormatFloat('#,##0.00',Qry1.FieldByName('LowSeasonTotal').AsCurrency)+' '+TmpCurr ;
QRepReservation.QrlMidSeasonTotal.Caption          := FormatFloat('#,##0.00',Qry1.FieldByName('MidSeasonTotal').AsCurrency)+' '+TmpCurr ;
QRepReservation.QrlExtensionTotal.Caption          := FormatFloat('#,##0.00',Qry1.FieldByName('extensionTotal').AsCurrency)+' '+TmpCurr ;
QRepReservation.QrlHighSeasonTotal.Caption         := FormatFloat('#,##0.00',Qry1.FieldByName('HighSeasonTotal').AsCurrency)+' '+TmpCurr ;
QRepReservation.QrlTotalInsurance.Caption          := FormatFloat('#,##0.00',Qry1.FieldByName('Totalinsurance').AsCurrency)+' '+TmpCurr ;
QRepReservation.QrlPetrol.Caption                  := Qry1.FieldByName('Petrol').AsString ;
QRepReservation.QrlExtra.Caption                   := Qry1.FieldByName('Extra').AsString ;
QRepReservation.QrlTaxiDropOff.Caption             := Qry1.FieldByName('TaxiDropOff').AsString ;
QRepReservation.QrlTaxiPickUp.Caption              := Qry1.FieldByName('TaxiPickUp').AsString ;
QRepReservation.QrlTotalAmount.Caption             := FormatFloat('#,##0.00',Qry1.FieldByName('GeneralTotal').AsCurrency)+' '+TmpCurr ;
QRepReservation.QrlPaidAmount3.Caption             := FormatFloat('#,##0.00',Qry1.FieldByName('PaidAmount3').AsCurrency)+' '+TmpCurr ;
QRepReservation.QrlOutsBalance.Caption             := FormatFloat('#,##0.00',Qry1.FieldByName('OutstandingBalance').AsCurrency)+' '+TmpCurr ;
QRepReservation.QrlPaidAmount4.Caption             := FormatFloat('#,##0.00',Qry1.FieldByName('PaidAmount4').AsCurrency)+' '+TmpCurr ;
QRepReservation.QrlPaidAmount2.Caption             := FormatFloat('#,##0.00',Qry1.FieldByName('PaidAmount2').AsCurrency)+' '+TmpCurr ;
QRepReservation.QrlPaidAmount1.Caption             := FormatFloat('#,##0.00',Qry1.FieldByName('PaidAmount1').AsCurrency)+' '+TmpCurr ;
QRepReservation.QrlDiscount.Caption                := FormatFloat('#,##0.00',Qry1.FieldByName('discount').AsCurrency)+' '+TmpCurr ;
QRepReservation.QrlPaidNote1.Caption               := Qry1.FieldByName('PaidNote1').AsString ;
QRepReservation.QrlPaidNote2.Caption               := Qry1.FieldByName('PaidNote2').AsString ;
QRepReservation.QrlPaidNote3.Caption               := Qry1.FieldByName('PaidNote3').AsString ;
QRepReservation.QrlPaidNote4.Caption               := Qry1.FieldByName('PaidNote4').AsString ;
QRepReservation.QrlPaymentMethod2.Caption          := Qry1.FieldByName('PaymentMethod2').AsString ;
QRepReservation.QrlPaymentMethod4.Caption          := Qry1.FieldByName('PaymentMethod4').AsString ;
QRepReservation.QrlPaymentMethod3.Caption          := Qry1.FieldByName('PaymentMethod3').AsString ;
QRepReservation.QrlPaymentMethod1.Caption          := Qry1.FieldByName('PaymentMethod1').AsString ;

QRepReservation.QRLCompany.Caption                 := Qry1.FieldByName('Company').AsString ;
QRepReservation.QRLCompanyIncome.Caption           := Qry1.FieldByName('CompanyIncome').AsString ;

QRepReservation.Preview;
QRepReservation.Free;
end;


procedure TFrmReservation2.RGrModeClick(Sender: TObject);
var
TmpName,TmpPassportId,TmpSurname,TmpCustNumber,TmpContactNumber,TmpDrivingLicense,TmpPlaceofBirth:String;
begin

if RGrMode.ItemIndex = 0 then begin

CmbContactNumber.Style  := csDropDownList;
CmbPassportNo.Style     := csDropDownList;
CmbName.Style           := csDropDownList;
CmbSurname.Style        := csDropDownList;
CmbDrivingLicense.Style := csDropDownList;
CmbPlaceofBirth.Style   := csDropDownList;

CmbContactNumber.AutoComplete := True;
CmbPassportNo.AutoComplete    := True;
CmbName.AutoComplete          := True;
CmbSurname.AutoComplete       := True;
CmbDrivingLicense.AutoComplete:= True;
CmbPlaceofBirth.AutoComplete  := True;

MusteriGetir;

CmbCustomerId.ItemIndex    := CmbCustomerId.Items.IndexOf(IntToStr(TmpCustomerID));
CmbPassportNo.ItemIndex    := CmbCustomerId.ItemIndex;
CmbContactNumber.ItemIndex := CmbCustomerId.ItemIndex;
CmbName.ItemIndex          := CmbCustomerId.ItemIndex;
CmbSurname.ItemIndex       := CmbCustomerId.ItemIndex;
CmbDrivingLicense.ItemIndex:= CmbCustomerId.ItemIndex;
CmbPlaceofBirth.ItemIndex  := CmbCustomerId.ItemIndex;

BtnOK.Visible := False;

end
Else if RGrMode.ItemIndex = 1 then begin

TmpCustomerID := StrToInt(CmbCustomerId.Text) ;

CmbContactNumber.Style  := csDropDown;
CmbPassportNo.Style     := csDropDown;
CmbName.Style           := csDropDown;
CmbSurname.Style        := csDropDown;
CmbDrivingLicense.Style := csDropDown;
CmbPlaceofBirth.Style   := csDropDown;


TmpPassportId    := CmbPassportNo.Text;
TmpPlaceofBirth  := CmbPlaceofBirth.Text;
TmpName          := CmbName.Text;
TmpSurname       := CmbSurname.Text;
TmpDrivingLicense:= CmbDrivingLicense.Text;
TmpContactNumber := CmbContactNumber.Text;

CmbCustomerId.Clear;
CmbPassportNo.Clear;
CmbPlaceofBirth.Clear;
CmbName.Clear;
CmbSurname.Clear;
CmbDrivingLicense.Clear;
CmbContactNumber.Clear;

CmbPassportNo.Text     := TmpPassportId ;
CmbContactNumber.Text  := TmpContactNumber;
CmbName.Text           := TmpName ;
CmbSurname.Text        := TmpSurname ;
CmbDrivingLicense.Text := TmpDrivingLicense ;
CmbPlaceofBirth.Text   := TmpPlaceofBirth ;

BtnOK.Visible := True;

end

Else if RGrMode.ItemIndex = 2 then begin

TmpCustomerID := 0 ;

CmbContactNumber.Style  := csDropDown;
CmbPassportNo.Style     := csDropDown;
CmbName.Style           := csDropDown;
CmbSurname.Style        := csDropDown;
CmbDrivingLicense.Style := csDropDown;
CmbPlaceofBirth.Style   := csDropDown;

CmbContactNumber.AutoComplete := False;
CmbPassportNo.AutoComplete    := False;
CmbName.AutoComplete          := False;
CmbSurname.AutoComplete       := False;
CmbDrivingLicense.AutoComplete:= False;
CmbPlaceofBirth.AutoComplete  := False;

BtnOK.Visible := True;

end;


end;

procedure TFrmReservation2.SabitDegerler;
var i:integer;
begin
Cmbalinacakyer.Clear;
qry2.Close;
qry2.SQL.Clear;
qry2.SQL.Add('Select Distinct AlinacakYer from Reservation order by AlinacakYer ');
qry2.Open;
for i:=1 to qry2.RecordCount do begin
Cmbalinacakyer.Items.Add(qry2.FieldByName('AlinacakYer').AsString);
qry2.Next;
end;

CmbBirakilacakYer.Clear;
qry2.Close;
qry2.SQL.Clear;
qry2.SQL.Add('Select Distinct BirakilacakYer from Reservation order by BirakilacakYer ');
qry2.Open;
for i:=1 to qry2.RecordCount do begin
CmbBirakilacakYer.Items.Add(qry2.FieldByName('BirakilacakYer').AsString);
qry2.Next;
end;

Cmbid.Clear;
CmbRegNo.Clear;
CmbModel.Clear;
CmbCarType.Clear;
CmbCarGroup.Clear;

qry2.Close;
qry2.SQL.Clear;
qry2.SQL.Add('Select Model,RegNo,Grup,Type,id from Car order by Model ');
qry2.Open;
for i:=1 to qry2.RecordCount do begin
Cmbid.Items.Add(qry2.FieldByName('id').AsString);
CmbRegNo.Items.Add(qry2.FieldByName('RegNo').AsString);
CmbModel.Items.Add(qry2.FieldByName('Model').AsString);
CmbCarType.Items.Add(qry2.FieldByName('Type').AsString);
CmbCarGroup.Items.Add(qry2.FieldByName('Grup').AsString);
qry2.Next;
end;

Temizle;

AgencyGetir;
CompanyGetir;


MusteriGetir;

DtBirakilacakSaat.Format := 'HH:mm';
DtAlinacakSaat.Format    := 'HH:mm';
DtTaxiTimeDeliver.Format := 'HH:mm';
DtTaxiTimeCollect.Format := 'HH:mm';
DtFlightTime.Format      := 'HH:mm';
end;

procedure TFrmReservation2.SpeedButton4Click(Sender: TObject);
begin
PrintReservation;
end;

procedure TFrmReservation2.Temizle;
begin
 FrmReservation2.LblSave.Enabled    := True;
 FrmReservation2.ImgSave.Enabled    := True;
 FrmReservation2.LblSave.Font.Color := clWhite;

 FrmReservation2.LblEdit.Enabled    := False;
 FrmReservation2.ImgEdit.Enabled    := False;
 FrmReservation2.LblEdit.Font.Color := clGray;

 FrmReservation2.LblDelete.Enabled    := False;
 FrmReservation2.ImgDelete.Enabled    := False;
 FrmReservation2.LblDelete.Font.Color := clGray;

 DtBirakilacakSaat.Time  := Time ;
 DtAlinacakSaat.Time     := Time ;
 DtFlightTime.Time       := Time ;
 DtTaxiTimeDeliver.Time  := Time ;
 DtTaxiTimeCollect.Time  := Time ;

 DtBirakilacakTarih.Date := Date ;
 DtAlinacakTarih.Date    := Date ;
 DtTaxiDateDeliver.Date  := Date ;
 DtTaxiDateCollect.Date  := Date ;

DtBirakilacakSaat.Format := 'HH:mm';
DtAlinacakSaat.Format    := 'HH:mm';
DtTaxiTimeDeliver.Format := 'HH:mm';
DtTaxiTimeCollect.Format := 'HH:mm';

CmbModel.Tag := 0 ;
ImgCustomerSearch.Tag := 0 ;

CmbModel.ItemIndex := -1;
CmbRegNo.ItemIndex := -1;
Cmbid.ItemIndex := -1;
CmbCarGroup.ItemIndex := -1;
CmbCarType.ItemIndex := -1 ;
Cmbalinacakyer.Text:='';
CmbBirakilacakYer.Text :='';
TxtReservationIdNo.Clear;
TxtContractNumber.Clear;
CmbTaxiDeliverFrom.Text :='';
CmbTaxiCollectTo.Text:='';
TxtFlightNumber.Clear;

MemAlinacakNotlar.Clear;
MemBirakilacakNotlar.Clear;

CmbContactNumber.Clear;
CmbPassportNo.Clear;

CmbCustomerId.Clear;
CmbName.Clear;
CmbSurname.Clear;
CmbPlaceofBirth.Clear;
CmbContactNumber.Clear;
CmbPassportNo.Clear;
CmbDrivingLicense.Clear;

CmbAgency.Clear;

CmbBabySeat.ItemIndex     :=0;
CmbBoosterSeat.ItemIndex  :=0;
CurrPaxPickUp.Value       :=0;
CurrPaxDropOff.Value       :=0;

Cmbinfantseat.ItemIndex   :=0;
CurrCase.Value            :=0;
CurrPetrol.Value          :=0;

CurrLowSeasonRate.Value      := 0;
CurrLowSeasonDays.Value      := 0;
CurrLowSeasonTotal.Value     := 0;
CurrMidSeasonRate.Value      := 0;
CurrMidSeasonDays.Value      := 0;
CurrMidSeasonTotal.Value     := 0;
CurrHighSeasonRate.Value     := 0;
CurrHighSeasonDays.Value     := 0;
CurrHighSeasonTotal.Value    := 0;
CurrTotalAmount.Value        := 0;
CurrTaxiPickUp.Value         := 0;
CurrTaxiDropOff.Value        := 0;
CurrOutstandingBalance.Value := 0;
CurrComission.Value          := 0;
CurrLessinsurance.Value      := 0;
CurrTotalComission.Value     := 0;
TxtRoomNo.Clear;
CurrExtra.Value      := 0 ;
CurrDiscount.Value   := 0 ;




CmbPaymentMethod1.Text := '';
CurrPaidAmount1.Value  := 0 ;
CmbPaidNote1.Text      := '';

CmbPaymentMethod2.Text := '';
CurrPaidAmount2.Value  := 0 ;
CmbPaidNote2.Text      := '';

CmbPaymentMethod3.Text := '';
CurrPaidAmount3.Value  := 0;
CmbPaidNote3.Text      := '';

CmbPaymentMethod4.Text := '';
CurrPaidAmount4.Value  := 0;
CmbPaidNote4.Text      := '';

end;


procedure TFrmReservation2.TransferGetir;

begin


Qry1.Close;
qry1.SQL.Clear;
qry1.SQL.Add('Select * from Transfer where RegNo=:RegNo');
Qry1.Parameters.ParamByName('RegNo').Value := TxtReservationIdNo.Text ;
Qry1.Prepared;
qry1.Open;

if qry1.RecordCount = 0 then exit;
//FrmTransfers.TxtName.tag  := Qry1.FieldByName('id').AsInteger   ;

FrmTransfers.PubTranferid :=  Qry1.FieldByName('id').AsInteger   ;

FrmTransfers.ImgCustomerSearch.tag  := Qry1.FieldByName('Customerid').AsInteger   ;
FrmTransfers.TxtName.Text           := Qry1.FieldByName('Name').AsString          ;
FrmTransfers.TxtSurname.Text        := Qry1.FieldByName('Surname').AsString       ;
FrmTransfers.TxtContactNumber.Text  := Qry1.FieldByName('ContactNumber').AsString ;
FrmTransfers.TxtPassportNo.Text     := Qry1.FieldByName('PassportId').AsString    ;
FrmTransfers.TxtDrivingLicense.Text := Qry1.FieldByName('LicenseNo').AsString     ;
FrmTransfers.TxtPlaceofBirth.Text   := Qry1.FieldByName('PlaceofBirth').AsString  ;

FrmTransfers.CurrArrivalPax.Value        := Qry1.FieldByName('ArrivalPax').AsCurrency ;
FrmTransfers.CurrDeparturePax.Value      := Qry1.FieldByName('DeparturePax').AsCurrency ;
FrmTransfers.CmbArrivalBabySeat.Text     := Qry1.FieldByName('ArrivalBabySeat').AsString ;
FrmTransfers.CmbDepartureBabySeat.Text   := Qry1.FieldByName('DepartureBabySeat').AsString ;
FrmTransfers.CmbArrivalBoosterSeat.Text  := Qry1.FieldByName('ArrivalBoosterSeat').AsString ;
FrmTransfers.CmbDepartureBoosterSeat.Text:= Qry1.FieldByName('DepartureBoosterSeat').AsString ;

if Qry1.FieldByName('ArrivalTimeChecked').AsString='Y' then FrmTransfers.ChkArrivalTime.Checked := True
Else FrmTransfers.ChkArrivalTime.Checked := False;

if Qry1.FieldByName('DepartureTimeChecked').AsString='Y' then FrmTransfers.ChkDepartureTime.Checked := True
Else FrmTransfers.ChkDepartureTime.Checked := False;

if Qry1.FieldByName('CheckedDeparture').AsString='Y' then FrmTransfers.ChkDeparture.Checked := True
Else FrmTransfers.ChkDeparture.Checked := False;

if Qry1.FieldByName('CheckedArrival').AsString='Y' then FrmTransfers.ChkArrival.Checked := True
Else FrmTransfers.ChkArrival.Checked := False;

if Qry1.FieldByName('ArrivalPaid').AsString='Y' then FrmTransfers.ChkArrivalPaid.Checked := True
Else FrmTransfers.ChkArrivalPaid.Checked := False;

if Qry1.FieldByName('DeparturePaid').AsString='Y' then FrmTransfers.ChkDeparturePaid.Checked := True
Else FrmTransfers.ChkDeparturePaid.Checked := False;

FrmTransfers.CmbArrivalCollectFrom.Text  := Qry1.FieldByName('ArrivalCollectFrom').AsString ;
FrmTransfers.CmbDepartureCollectFrom.Text:= Qry1.FieldByName('DepartureCollectFrom').AsString ;
FrmTransfers.DtArrivalDate.Date          := Qry1.FieldByName('ArrivalDate').AsDateTime ;
FrmTransfers.DtArrivalTime.Time          := Qry1.FieldByName('ArrivalTime').AsDateTime ;
FrmTransfers.DtDepartureDate.Date        := Qry1.FieldByName('DepartureDate').AsDateTime ;
FrmTransfers.DtDepartureTime.Time        := Qry1.FieldByName('DepartureTime').AsDateTime ;
FrmTransfers.MemArrivalNotes.Text        := Qry1.FieldByName('ArrivalNotes').AsString ;
FrmTransfers.MemDepartureNotes.Text      := Qry1.FieldByName('DepartureNotes').AsString ;
FrmTransfers.TxtArrivalDestination.Text  := Qry1.FieldByName('ArrivalDestination').AsString ;

FrmTransfers.CmbDriver.Text        := Qry1.FieldByName('Driver').AsString ;
FrmTransfers.CmbDriver2.Text       := Qry1.FieldByName('Driver2').AsString ;
FrmTransfers.ImgCustomerSearch.tag := Qry1.FieldByName('Customerid').AsInteger ;

FrmTransfers.CmbAgency.ItemIndex        := FrmTransfers.CmbAgency.Items.IndexOf(Qry1.FieldByName('AgencyName').AsString) ;

FrmTransfers.TxtArrivalFlightNo.Text  := Qry1.FieldByName('ArrivalFlightNo').AsString ;
FrmTransfers.CurrArrivalPrice.Text    := Qry1.FieldByName('ArrivalPrice').AsString ;
FrmTransfers.CurrDeparturePrice.Value := Qry1.FieldByName('DeparturePrice').AsCurrency ;

FrmTransfers.cmbPaidTo.Text        := Qry1.FieldByName('PaidTo').AsString ;
FrmTransfers.cmbArrivalPaidTo.Text := Qry1.FieldByName('ArrivalPaidTo').AsString ;

FrmTransfers.CurrDepCase.value := Qry1.FieldByName('DepartureCase').AsCurrency ;

FrmTransfers.CurrArrCase.value     := Qry1.FieldByName('ArrivalCase').AsCurrency ;
FrmTransfers.cmbDepinfantseat.Text := Qry1.FieldByName('Departureinfant').AsString ;
FrmTransfers.CmbArrinfantseat.Text := Qry1.FieldByName('Arrivalinfant').AsString ;
FrmTransfers.Txtid.Text            := Qry1.FieldByName('Carid').AsString ;

FrmTransfers.TxtModel.Text    := Qry1.FieldByName('CarModel').AsString ;
FrmTransfers.TxtRegNo.Text    := Qry1.FieldByName('CarRegNo').AsString ;
FrmTransfers.TxtCarGroup.Text := Qry1.FieldByName('CarGroup').AsString ;
FrmTransfers.TxtCarType.Text  := Qry1.FieldByName('CarType').AsString ;

FrmTransfers.TxtDepartureDestination.Text := Qry1.FieldByName('DepartureDestination').AsString ;
FrmTransfers.CmbCurrency.ItemIndex        := FrmTransfers.CmbCurrency.Items.IndexOf(Qry1.FieldByName('currency').AsString) ;


FrmTransfers.ImgSave.Enabled     := False;
FrmTransfers.LblSave.Font.Color  := clGray;
FrmTransfers.LblSave.Enabled     := False;

FrmTransfers.ImgDelete.Enabled   := True;
FrmTransfers.LblDelete.Font.Color:= clWhite;
FrmTransfers.LblDelete.Enabled   := True;

FrmTransfers.ImgEdit.Enabled     := True ;
FrmTransfers.LblEdit.Font.Color  := clWhite;
FrmTransfers.LblEdit.Enabled     := True;


end;

procedure TFrmReservation2.TxtContractNumberKeyPress(Sender: TObject;
  var Key: Char);
begin
key  := BuyukHarf(key,Sender as Tedit);
end;

procedure TFrmReservation2.TxtFlightNumberKeyPress(Sender: TObject;
  var Key: Char);
begin
key  := BuyukHarf(key,Sender as Tedit);
end;

procedure TFrmReservation2.TxtReservationIdNoKeyPress(Sender: TObject;
  var Key: Char);
begin
key  := BuyukHarf(key,Sender as TEdit);
end;

procedure TFrmReservation2.ImgEditClick(Sender: TObject);
var TmpSql,TmpDateSeperator:string;
i,z:integer;
DateBirakilacak,DateBirakilacak1,DateAlinacak,DateAlinacak1:TDateTime;
TimeBirakilacak,TimeBirakilacak1,TimeAlinacak,TimeAlinacak1:TDateTime;
TmpTimeBirakilacak,TmpTimeAlinacak : Integer;
begin

TmpDateSeperator := FormatSettings.DateSeparator ;
ProgramKullanmaDurumu:=ProgramKullanmaDurumu+1;

TmpTimeBirakilacak :=  HourOf(DtBirakilacakSaat.DateTime);
TmpTimeAlinacak    :=  HourOf(DtAlinacakSaat.DateTime);

if TmpTimeBirakilacak = 0 then   TmpTimeBirakilacak := 24 ;
if TmpTimeAlinacak = 0 then   TmpTimeAlinacak := 24 ;

if  HoursBetween(StrToDate('1'+TmpDateSeperator+'1'+TmpDateSeperator+'1900'),DtBirakilacakTarih.DateTime)+TmpTimeBirakilacak > HoursBetween(StrToDate('1'+TmpDateSeperator+'1'+TmpDateSeperator+'1900'),DtAlinacakTarih.DateTime)+TmpTimeAlinacak Then
Begin
MsgUyari('Deliver Date and Time Must Be Smaller or Equal Than Collection Date and Time!!! ');
exit;
end;

//////////////////////////////////////////KONTROL KISMI///////////////////////////////////

TmpSql := 'Select * from Reservation where Durum<>''Deleted'' and id<>:id and Carid=:CariD ' ;
z:=0;
Qry1.Close;
qry1.SQL.Clear;
qry1.SQL.Add(TmpSql);
Qry1.Parameters.ParamByName('Carid').Value := Cmbid.Text  ;
Qry1.Parameters.ParamByName('id').Value := PubReservasyonId  ;
qry1.Prepared;
qry1.Open;

if qry1.recordcount <> 0 Then Begin
for i:=1 to qry1.RecordCount do begin

////////////////////////////////////////////////////////////////////////////////////
DateBirakilacak  :=
EncodeDateTime(YearOf(DtBirakilacakTarih.Date),MonthOf(DtBirakilacakTarih.Date),DayOf(DtBirakilacakTarih.Date),HourOf(DtBirakilacakSaat.Time),MinuteOf(DtBirakilacakSaat.Time),0,0) ;
DateBirakilacak1 :=
EncodeDateTime(YearOf(Qry1.FieldByName('BirakilacakTarih').AsDateTime),MonthOf(Qry1.FieldByName('BirakilacakTarih').AsDateTime),DayOf(Qry1.FieldByName('BirakilacakTarih').AsDateTime),
HourOf(Qry1.FieldByName('BirakilacakSaat').AsDateTime),MinuteOf(Qry1.FieldByName('BirakilacakSaat').AsDateTime),0,0) ;
DateAlinacak  :=
EncodeDateTime(YearOf(DtAlinacakTarih.Date),MonthOf(DtAlinacakTarih.Date),DayOf(DtAlinacakTarih.Date),HourOf(DtAlinacakSaat.Time),MinuteOf(DtAlinacakSaat.Time),0,0) ;
DateAlinacak1 :=
EncodeDateTime(YearOf(Qry1.FieldByName('alinacakTarih').AsDateTime),MonthOf(Qry1.FieldByName('alinacakTarih').AsDateTime),DayOf(Qry1.FieldByName('alinacakTarih').AsDateTime),
HourOf(Qry1.FieldByName('AlinacakSaat').AsDateTime),MinuteOf(Qry1.FieldByName('AlinacakSaat').AsDateTime),0,0) ;

if ( DateBirakilacak <= DateAlinacak1 ) and ( DateAlinacak >= DateBirakilacak1 ) Then z:=1;

if z = 1 then begin
   MsgUyari('ERROR'+#13+#13+ 'Desired Date  :'+#13+DateTimeToStr(DateBirakilacak)+' - '+  DateTimeToStr(DateAlinacak) + #13 +
            'Date Crash With :'+#13+DateTimeToStr(DateBirakilacak1)+' - '+DateTimeToStr(DateAlinacak1) ) ;
   exit;
end;

qry1.Next;
end;
end;
///////////////////////////////////////////////////////////////////////////////////////


TmpSql:='update Reservation set ' +
' Company=:Company, '+
' Companyincome=:Companyincome, '+


' Durum=:Durum, '+

' Carid=:Carid, '+
' CarModel=:CarModel, '+
' CarRegNo=:CarRegNo, ' +
' CarGroup=:CarGroup, '  +
' CarType=:CarType, '  +
' Customerid=:Customerid, '  +
' Name=:Name, '  +
' Surname=:Surname, '  +
' ContactNumber=:ContactNumber, '  +
' PassportId=:PassportId, '  +
' LicenseNo=:LicenseNo, '  +
' PlaceofBirth=:PlaceofBirth, '  +
' AlinacakYer=:AlinacakYer, '  +
' alinacakTarih=:alinacakTarih, '  +
' AlinacakSaat=:AlinacakSaat, '  +
' AlinacakNotlar=:AlinacakNotlar, '  +
' birakilacakYer=:birakilacakYer, '  +
' BirakilacakTarih=:BirakilacakTarih, '  +
' BirakilacakSaat=:BirakilacakSaat, '  +
' BirakilacakNotlar=:BirakilacakNotlar, '  +
' Petrol=:Petrol, '  +
' BabySeat=:BabySeat, '  +
' BoosterSeat=:BoosterSeat, '  +
' Agency=:Agency, '  +
' LowSeasonRate=:LowSeasonRate, '  +
' LowSeasonDays=:LowSeasonDays, '  +
' LowSeasonTotal=:LowSeasonTotal, '  +
' MidSeasonRate=:MidSeasonRate, '  +
' MidSeasonDays=:MidSeasonDays, '  +
' MidSeasonTotal=:MidSeasonTotal, '  +
' HighSeasonRate=:HighSeasonRate, '  +
' HighSeasonDays=:HighSeasonDays, '  +
' HighSeasonTotal=:HighSeasonTotal, '  +
' GeneralTotal=:GeneralTotal, '  +
' CollectTimeChecked=:CollectTimeChecked, '  +
' DeliverTimeChecked=:DeliverTimeChecked, '  +
' FlightNumber=:FlightNumber, '  +
' TotalDays =:TotalDays, '  +
' OutstandingBalance =:OutstandingBalance, '  +
' FlightTime=:FlightTime,'+
' PaxsPickUp=:PaxsPickUp,'+
' PaxsDropOff=:PaxsDropOff,'+
' infantSeat=:infantSeat,'+
' cases=:cases,'+
' TaxiDeliverTo=:TaxiDeliverTo,'+
' TaxiCollectTo=:TaxiCollectTo,'+
' TaxiDeliverFrom=:TaxiDeliverFrom,'+
' TaxiCollectFrom=:TaxiCollectFrom,'+
' TaxiDateDeliver=:TaxiDateDeliver,'+
' TaxiTimeDeliver=:TaxiTimeDeliver,'+
' TaxiDateCollect=:TaxiDateCollect,'+
' TaxiTimeCollect=:TaxiTimeCollect,'+
' TaxiPickUp=:TaxiPickUp,'+
' TaxiDropOff=:TaxiDropOff, '+
' ContractNumber=:ContractNumber, '+
' ChkFlightTime=:ChkFlightTime, '+
' ChkTaxiTimeDeliver=:ChkTaxiTimeDeliver, '+
' ChkTaxiTimeCollect=:ChkTaxiTimeCollect, '+
' Currency=:Currency, '+
' Notes=:Notes, '+
' Lessinsurance=:Lessinsurance, '+
' Commission=:Commission, '+
' TotalComission=:TotalComission, '+
' Sigorta=:Sigorta, '+
' VoucherNo=:VoucherNo, '+
' RoomNo=:RoomNo, '+
' Extra=:Extra, '+
' Discount=:Discount, '+
' Totalinsurance=:Totalinsurance, '+
' Dailyinsurance=:Dailyinsurance, '+
' ChkFlightTime2=:ChkFlightTime2, '+
' DtFlightTime2=:DtFlightTime2, '+
' ExtensionRate=:ExtensionRate, '+
' ExtensionDays=:ExtensionDays, '+
' ExtensionTotal=:ExtensionTotal, '+

' PaymentMethod1=:PaymentMethod1, '+
' PaidAmount1=:PaidAmount1, '+
' PaidNote1=:PaidNote1, '+

' PaymentMethod2=:PaymentMethod2, '+
' PaidAmount2=:PaidAmount2, '+
' PaidNote2=:PaidNote2, '+

' PaymentMethod3=:PaymentMethod3, '+
' PaidAmount3=:PaidAmount3, '+
' PaidNote3=:PaidNote3, '+

' PaymentMethod4=:PaymentMethod4, '+
' PaidAmount4=:PaidAmount4, '+
' PaidNote4=:PaidNote4, '+
' Name2=:Name2, '+
' Surname2=:Surname2, '+
' email=:email '+


' where id = :id ';

qry1.Close;
qry1.SQL.Clear;
qry1.SQL.Add(TmpSql);
Qry1.Parameters.ParamByName('Company').Value          := Cmbcompany.text;
Qry1.Parameters.ParamByName('Companyincome').Value    := currCompanyIncome.Value    ;

Qry1.Parameters.ParamByName('Durum').Value            := 'Updated'    ;
Qry1.Parameters.ParamByName('Carid').Value            := Cmbid.Text    ;
Qry1.Parameters.ParamByName('CarModel').Value         := CmbModel.Text ;
Qry1.Parameters.ParamByName('CarRegNo').Value         := CmbRegNo.Text ;
Qry1.Parameters.ParamByName('CarGroup').Value         := CmbCarGroup.Text ;
Qry1.Parameters.ParamByName('CarType').Value          := CmbCarType.Text  ;
Qry1.Parameters.ParamByName('Customerid').Value       := TmpCustomerID;
Qry1.Parameters.ParamByName('Name').Value             := trim(Cmbname.Text);
Qry1.Parameters.ParamByName('Surname').Value          := trim(Cmbsurname.Text) ;
Qry1.Parameters.ParamByName('ContactNumber').Value    := trim(CmbContactNumber.Text);
Qry1.Parameters.ParamByName('PassportId').Value       := trim(CmbPassportNo.Text) ;
Qry1.Parameters.ParamByName('LicenseNo').Value        := trim(CmbDrivingLicense.Text);
Qry1.Parameters.ParamByName('PlaceofBirth').Value     := trim(CmbPlaceofBirth.Text);
Qry1.Parameters.ParamByName('AlinacakYer').Value      := trim(Cmbalinacakyer.Text) ;
Qry1.Parameters.ParamByName('alinacakTarih').Value    :=
IntToStr(YearOf(DtAlinacakTarih.Date))+'-'+IntToStr(MonthOf(DtAlinacakTarih.Date))+'-'+IntToStr(DayOf(DtAlinacakTarih.Date));
Qry1.Parameters.ParamByName('AlinacakSaat').Value     :=
IntToStr(HourOf(DtAlinacakSaat.Time))+':'+IntToStr(MinuteOf(DtAlinacakSaat.Time))+':'+IntToStr(SecondOf(DtAlinacakSaat.Time));
Qry1.Parameters.ParamByName('AlinacakNotlar').Value   := trim(MemAlinacakNotlar.Text) ;
Qry1.Parameters.ParamByName('birakilacakYer').Value   := trim(CmbBirakilacakYer.Text) ;
Qry1.Parameters.ParamByName('BirakilacakTarih').Value :=
IntToStr(YearOf(DtBirakilacakTarih.Date))+'-'+IntToStr(MonthOf(DtBirakilacakTarih.Date))+'-'+IntToStr(DayOf(DtBirakilacakTarih.Date));
Qry1.Parameters.ParamByName('BirakilacakSaat').Value  :=
IntToStr(HourOf(DtBirakilacakSaat.Time))+':'+IntToStr(MinuteOf(DtBirakilacakSaat.Time))+':'+IntToStr(SecondOf(DtBirakilacakSaat.Time));
Qry1.Parameters.ParamByName('BirakilacakNotlar').Value:= trim(MemBirakilacakNotlar.Text)    ;
Qry1.Parameters.ParamByName('Petrol').Value           := CurrPetrol.Value    ;
Qry1.Parameters.ParamByName('BabySeat').Value         := CmbBabySeat.Text    ;
Qry1.Parameters.ParamByName('BoosterSeat').Value      := CmbBoosterSeat.Text    ;
Qry1.Parameters.ParamByName('Agency').Value           := Trim(CmbAgency.Text)    ;
Qry1.Parameters.ParamByName('LowSeasonRate').Value    := CurrLowSeasonRate.Value    ;
Qry1.Parameters.ParamByName('LowSeasonDays').Value    := CurrLowSeasonDays.Value    ;
Qry1.Parameters.ParamByName('LowSeasonTotal').Value   := CurrLowSeasonTotal.Value    ;
Qry1.Parameters.ParamByName('MidSeasonRate').Value    := CurrMidSeasonRate.Value    ;
Qry1.Parameters.ParamByName('MidSeasonDays').Value    := CurrMidSeasonDays.Value    ;
Qry1.Parameters.ParamByName('MidSeasonTotal').Value   := CurrMidSeasonTotal.Value    ;
Qry1.Parameters.ParamByName('HighSeasonRate').Value   := CurrHighSeasonRate.Value    ;
Qry1.Parameters.ParamByName('HighSeasonDays').Value   := CurrHighSeasonDays.Value    ;
Qry1.Parameters.ParamByName('HighSeasonTotal').Value  := CurrHighSeasonTotal.Value    ;
Qry1.Parameters.ParamByName('GeneralTotal').Value     := CurrTotalAmount.Value    ;

if ChkCollectTime.Checked = True then
Qry1.Parameters.ParamByName('CollectTimeChecked').Value := 'Y'
Else Qry1.Parameters.ParamByName('CollectTimeChecked').Value := 'N';

if ChkDeliverTime.Checked = True then
Qry1.Parameters.ParamByName('DeliverTimeChecked').Value := 'Y'
Else Qry1.Parameters.ParamByName('DeliverTimeChecked').Value := 'N';

Qry1.Parameters.ParamByName('FlightNumber').Value   := Trim(TxtFlightNumber.Text) ;

Qry1.Parameters.ParamByName('TotalDays').Value          := CurrTotalDays.Value ;
Qry1.Parameters.ParamByName('OutstandingBalance').Value := CurrOutstandingBalance.Value ;

Qry1.Parameters.ParamByName('FlightTime').Value  :=
IntToStr(HourOf(DtFlightTime.Time))+':'+IntToStr(MinuteOf(DtFlightTime.Time))+':'+IntToStr(SecondOf(DtFlightTime.Time));

Qry1.Parameters.ParamByName('PaxsPickUp').Value      := CurrPaxPickUp.Value ;
Qry1.Parameters.ParamByName('PaxsDropOff').Value     := CurrPaxDropOff.Value ;
Qry1.Parameters.ParamByName('infantSeat').Value      := Cmbinfantseat.Text ;
Qry1.Parameters.ParamByName('cases').Value           := CurrCase.Value ;
Qry1.Parameters.ParamByName('TaxiDeliverTo').Value   := Trim(CmbTaxiDeliverTo.Text) ;
Qry1.Parameters.ParamByName('TaxiCollectTo').Value   := Trim(CmbTaxiCollectTo.Text);
Qry1.Parameters.ParamByName('TaxiDeliverFrom').Value := Trim(CmbTaxiDeliverFrom.Text) ;
Qry1.Parameters.ParamByName('TaxiCollectFrom').Value := Trim(CmbTaxiCollectFrom.Text);
Qry1.Parameters.ParamByName('TaxiDateDeliver').Value :=
IntToStr(YearOf(DtTaxiDateDeliver.Date))+'-'+IntToStr(MonthOf(DtTaxiDateDeliver.Date))+'-'+IntToStr(DayOf(DtTaxiDateDeliver.Date));
Qry1.Parameters.ParamByName('TaxiTimeDeliver').Value :=
IntToStr(HourOf(DtTaxiTimeDeliver.Time))+':'+IntToStr(MinuteOf(DtTaxiTimeDeliver.Time))+':'+IntToStr(SecondOf(DtTaxiTimeDeliver.Time));
Qry1.Parameters.ParamByName('TaxiDateCollect').Value :=
IntToStr(YearOf(DtTaxiDateCollect.Date))+'-'+IntToStr(MonthOf(DtTaxiDateCollect.Date))+'-'+IntToStr(DayOf(DtTaxiDateCollect.Date));
Qry1.Parameters.ParamByName('TaxiTimeCollect').Value :=
IntToStr(HourOf(DtTaxiTimeCollect.Time))+':'+IntToStr(MinuteOf(DtTaxiTimeCollect.Time))+':'+IntToStr(SecondOf(DtTaxiTimeCollect.Time));
Qry1.Parameters.ParamByName('TaxiPickUp').Value      := CurrTaxiPickUp.Value ;
Qry1.Parameters.ParamByName('TaxiDropOff').Value     := CurrTaxiDropOff.Value ;
Qry1.Parameters.ParamByName('ContractNumber').Value  := trim(TxtContractNumber.Text);

if ChkFlightTime.Checked = True then
Qry1.Parameters.ParamByName('ChkFlightTime').Value := 'Y'
Else Qry1.Parameters.ParamByName('ChkFlightTime').Value := 'N';

if ChkTaxiTimeDeliver.Checked = True then
Qry1.Parameters.ParamByName('ChkTaxiTimeDeliver').Value := 'Y'
Else Qry1.Parameters.ParamByName('ChkTaxiTimeDeliver').Value := 'N';

if ChkTaxiTimeCollect.Checked = True then
Qry1.Parameters.ParamByName('ChkTaxiTimeCollect').Value := 'Y'
Else Qry1.Parameters.ParamByName('ChkTaxiTimeCollect').Value := 'N';

Qry1.Parameters.ParamByName('Currency').Value    := CmbCurrency.Text ;
Qry1.Parameters.ParamByName('Notes').Value       := MemNotes.Text ;

Qry1.Parameters.ParamByName('Lessinsurance').Value   := CurrLessinsurance.Value ;
Qry1.Parameters.ParamByName('Commission').Value       := CurrComission.Value ;
Qry1.Parameters.ParamByName('TotalComission').Value  := CurrTotalComission.Value ;

Qry1.Parameters.ParamByName('Sigorta').Value   := CurrTotalinsurance.Value ;
Qry1.Parameters.ParamByName('VoucherNo').Value := TxtVoucherNo.Text ;

Qry1.Parameters.ParamByName('RoomNo').Value        := TxtRoomNo.Text ;
Qry1.Parameters.ParamByName('Extra').Value         := CurrExtra.Value ;
Qry1.Parameters.ParamByName('Discount').Value      := CurrDiscount.Value ;

Qry1.Parameters.ParamByName('Totalinsurance').Value := CurrTotalinsurance.Value ;
Qry1.Parameters.ParamByName('Dailyinsurance').Value := CurrDailyinsurance.Value ;

Qry1.Parameters.ParamByName('PaymentMethod2').Value := CmbPaymentMethod2.Text ;
Qry1.Parameters.ParamByName('PaidAmount2').Value    := CurrPaidAmount2.Value ;
if ChkFlightTime2.Checked = True then
Qry1.Parameters.ParamByName('ChkFlightTime2').Value := 'Y'
Else Qry1.Parameters.ParamByName('ChkFlightTime2').Value := 'N';

Qry1.Parameters.ParamByName('DtFlightTime2').Value  :=
IntToStr(HourOf(DtFlightTime2.Time))+':'+IntToStr(MinuteOf(DtFlightTime2.Time))+':'+IntToStr(SecondOf(DtFlightTime2.Time));

Qry1.Parameters.ParamByName('ExtensionRate').Value   := CurrExtensionRate.Value ;
Qry1.Parameters.ParamByName('ExtensionDays').Value   := CurrExtensionDays.Value ;
Qry1.Parameters.ParamByName('ExtensionTotal').Value  := CurrExtensionTotal.Value ;

///////////////////////////////// PAYMENT ///////////////////////////////////////
Qry1.Parameters.ParamByName('PaymentMethod1').Value  := CmbPaymentMethod1.Text  ;
Qry1.Parameters.ParamByName('PaidAmount1').Value     := CurrPaidAmount1.Value   ;
Qry1.Parameters.ParamByName('PaidNote1').Value       := CmbPaidNote1.Text       ;

Qry1.Parameters.ParamByName('PaymentMethod2').Value  := CmbPaymentMethod2.Text  ;
Qry1.Parameters.ParamByName('PaidAmount2').Value     := CurrPaidAmount2.Value   ;
Qry1.Parameters.ParamByName('PaidNote2').Value       := CmbPaidNote2.Text       ;

Qry1.Parameters.ParamByName('PaymentMethod3').Value  := CmbPaymentMethod3.Text  ;
Qry1.Parameters.ParamByName('PaidAmount3').Value     := CurrPaidAmount3.Value   ;
Qry1.Parameters.ParamByName('PaidNote3').Value       := CmbPaidNote3.Text       ;

Qry1.Parameters.ParamByName('PaymentMethod4').Value  := CmbPaymentMethod4.Text  ;
Qry1.Parameters.ParamByName('PaidAmount4').Value     := CurrPaidAmount4.Value   ;
Qry1.Parameters.ParamByName('PaidNote4').Value       := CmbPaidNote4.Text       ;
/////////////////////////////////////////////////////////////////////////////////


Qry2.Close;
qry2.SQL.Clear;
qry2.SQL.Add('Select Name2, Surname2,email from customer where id=:id');
Qry2.Parameters.ParamByName('id').Value := TmpCustomerID  ;
qry2.Prepared;
qry2.Open;
Qry1.Parameters.ParamByName('Name2').Value    := qry2.fieldbyname('Name2').asstring ;
Qry1.Parameters.ParamByName('Surname2').Value := qry2.fieldbyname('Surname2').asstring ;
Qry1.Parameters.ParamByName('email').Value    := qry2.fieldbyname('email').asstring ;

Qry1.Parameters.ParamByName('id').Value       := IntToStr(CmbModel.Tag) ;

qry1.Prepared;
qry1.ExecSQL;

MsgUyari('Update Successfull ...') ;
//PubButton.Click;

FrmReservation2.Temizle;
FrmReservation2.Close;

if Pubt=1 then begin
FrmTimeTable.BtnList.Click;
PubT:=0;
end;

end;

procedure TFrmReservation2.ImgAddCustomerClick(Sender: TObject);
var TmpCustid:String;
begin
ProgramKullanmaDurumu:=ProgramKullanmaDurumu+1;

FrmCustomer:=TFrmCustomer.Create(self);

////////////////////////////////////////////////////////////////////
TmpCustid := CmbCustomerId.Text ;

if CmbCustomerId.Text <> '' then begin
FrmCustomer.KayitGetir(CmbCustomerId.Text);
end;

///////////////////////////////////////////////////////////////////////7
FrmCustomer.FileListBoxEx1.clear;

if directoryexists('c:\dosyalar\'+inttostr(FrmCustomer.TxtName.Tag))=True Then
   FrmCustomer.FileListBoxEx1.Directory :='c:\dosyalar\'+inttostr(FrmCustomer.TxtName.Tag)
Else
   FrmCustomer.FileListBoxEx1.Directory :=  'c:\dosyalar\empty' ;


if FrmCustomer.TxtName.Tag=0 then begin
FrmCustomer.FileListBoxEx1.visible := False;
FrmCustomer.BtnDosyaSec.visible := False;
end
Else begin
FrmCustomer.FileListBoxEx1.visible := True;
FrmCustomer.BtnDosyaSec.visible := True;
end;

FrmCustomer.ShowModal;

MusteriGetir;

CmbCustomerId.ItemIndex := CmbCustomerId.Items.IndexOf(TmpCustid);
CmbPlaceofBirth.ItemIndex   := CmbCustomerId.ItemIndex;
CmbName.ItemIndex           := CmbCustomerId.ItemIndex;
Cmbsurname.ItemIndex        := CmbCustomerId.ItemIndex;
CmbContactNumber.ItemIndex  := CmbCustomerId.ItemIndex;
CmbPassportNo.ItemIndex     := CmbCustomerId.ItemIndex;
CmbDrivingLicense.ItemIndex := CmbCustomerId.ItemIndex;
if CmbCustomerId.Text  = '' then
TmpCustomerID               := 0
Else
TmpCustomerID               := StrToInt(CmbCustomerId.Text) ;




FrmCustomer.Free;
end;

procedure TFrmReservation2.ImgCustomerSearchClick(Sender: TObject);
begin
FrmDlgCustomer:=TFrmDlgCustomer.Create(self);
FrmDlgCustomer.ShowModal;

if FrmDlgCustomer.iptal = False then begin

ImgCustomerSearch.Tag := FrmDlgCustomer.Qry1.fieldbyname('id').AsInteger ;
TmpCustomerID         := FrmDlgCustomer.Qry1.fieldbyname('id').AsInteger ;

Cmbname.Text           := FrmDlgCustomer.Qry1.fieldbyname('Name').AsString ;
Cmbsurname.Text        := FrmDlgCustomer.Qry1.fieldbyname('Surname').AsString ;
CmbContactNumber.Text  := FrmDlgCustomer.Qry1.fieldbyname('ContactNumber').AsString ;
CmbPassportNo.Text     := FrmDlgCustomer.Qry1.fieldbyname('PassportId').AsString ;
CmbDrivingLicense.Text := FrmDlgCustomer.Qry1.fieldbyname('LicenseNo').AsString ;
CmbPlaceofBirth.Text   := FrmDlgCustomer.Qry1.fieldbyname('PlaceofBirth').AsString ;
end;

FrmDlgCustomer.Free;

end;

procedure TFrmReservation2.ImgDeleteClick(Sender: TObject);
begin



ProgramKullanmaDurumu:=ProgramKullanmaDurumu+1;


if MsgOnay('Do you want to delete ? ') Then begin

qry1.Close;
qry1.SQL.Clear;
qry1.SQL.Add('Update Reservation set Durum=''Deleted'' where id='''+IntToStr(CmbModel.Tag)+''' ');
qry1.ExecSQL;
{
qry1.Close;
qry1.SQL.Clear;
qry1.SQL.Add('Delete from Reservation where id='''+IntToStr(CmbModel.Tag)+''' ');
qry1.ExecSQL;
}

//PubButton.Click;
FrmReservation2.Temizle;
FrmReservation2.Close;
end;

if Pubt=1 then begin
FrmTimeTable.BtnList.Click;
PubT:=0;
end;

end;

procedure TFrmReservation2.BtnOKClick(Sender: TObject);
begin

if RGrMode.ItemIndex = 0 then begin


end
Else if RGrMode.ItemIndex = 1 then begin


if TmpCustomerID=0 then begin
MsgUyari('You Do Not Need To Edit This Entry ... ');
exit;
end;

if trim(CmbName.Text) = '' Then begin
MsgUyari('Please enter customer name  !!! ');
exit;
end;

if trim(CmbSurname.Text) = '' Then begin
MsgUyari('Please enter customer surname !!! ');
exit;
end;



qry1.Close;
qry1.SQL.Clear;
qry1.SQL.Add('Select id from Customer where id<>:id and Name=:Name and Surname=:Surname ');
Qry1.Parameters.ParamByName('Name').Value    := trim(CmbName.Text) ;
Qry1.Parameters.ParamByName('Surname').Value := trim(CmbSurname.Text) ;
Qry1.Parameters.ParamByName('id').Value      := TmpCustomerID ;
qry1.Prepared;
qry1.open;
if qry1.RecordCount <> 0 then Begin
MsgUyari('Customer Available , Can Not Save ...');
exit;
end;


qry1.Close;
Qry1.SQL.Clear;
Qry1.SQL.Add('update  customer set PassportId=:PassportId,Name=:Name,Surname=:Surname,LocalNumber=:LocalNumber,Email=:Email,CustNumber=:CustNumber  where id=:id');

Qry1.Parameters.ParamByName('Name').Value             := trim(Cmbname.Text);
Qry1.Parameters.ParamByName('Surname').Value          := trim(Cmbsurname.Text) ;
Qry1.Parameters.ParamByName('ContactNumber').Value    := trim(CmbContactNumber.Text);
Qry1.Parameters.ParamByName('PassportId').Value       := trim(CmbPassportNo.Text) ;
Qry1.Parameters.ParamByName('LicenseNo').Value        := trim(CmbDrivingLicense.Text);
Qry1.Parameters.ParamByName('PlaceofBirth').Value     := trim(CmbPlaceofBirth.Text);
Qry1.Parameters.ParamByName('id').Value               := TmpCustomerID ;

Qry1.Prepared;
Qry1.ExecSQL;


RGrMode.ItemIndex := 0;

end
Else if RGrMode.ItemIndex = 2 then begin

if trim(CmbName.Text) = '' Then begin
MsgUyari('Please enter customer name  !!! ');
exit;
end;

if trim(CmbSurname.Text) = '' Then begin
MsgUyari('Please enter customer surname !!! ');
exit;
end;

qry1.Close;
qry1.SQL.Clear;
qry1.SQL.Add('Select id from Customer where Name=:Name and Surname=:Surname ');
Qry1.Parameters.ParamByName('Name').Value    := trim(CmbName.Text) ;
Qry1.Parameters.ParamByName('Surname').Value := trim(CmbSurname.Text) ;
qry1.Prepared;
qry1.open;
if qry1.RecordCount <> 0 then Begin
MsgUyari('Customer Available , Can Not Save ...');
exit;
end;


qry1.Close;
Qry1.SQL.Clear;
Qry1.SQL.Add('insert into customer (PassportId,Name,Surname,LocalNumber,Email,CustNumber)  values(:PassportId,:Name,:Surname,:LocalNumber,:Email,:CustNumber)');
Qry1.Parameters.ParamByName('Name').Value             := trim(Cmbname.Text);
Qry1.Parameters.ParamByName('Surname').Value          := trim(Cmbsurname.Text) ;
Qry1.Parameters.ParamByName('ContactNumber').Value    := trim(CmbContactNumber.Text);
Qry1.Parameters.ParamByName('PassportId').Value       := trim(CmbPassportNo.Text) ;
Qry1.Parameters.ParamByName('LicenseNo').Value        := trim(CmbDrivingLicense.Text);
Qry1.Parameters.ParamByName('PlaceofBirth').Value     := trim(CmbPlaceofBirth.Text);
Qry1.Prepared;
Qry1.ExecSQL;

Qry1.Close;
qry1.SQL.Clear;
Qry1.SQL.Add('Select max(id) as id from customer');
Qry1.Open ;

TmpCustomerID := qry1.FieldByName('id').AsInteger ;

RGrMode.ItemIndex := 0;

end;

end;


procedure TFrmReservation2.BtnCommissionClick(Sender: TObject);
begin
if PubKontrol=1 Then Exit;

CurrTotalComission.Value :=
( (CurrLowSeasonTotal.Value + CurrMidSeasonTotal.Value + CurrHighSeasonTotal.Value+CurrExtensionTotal.Value) -
(CurrLessinsurance.Value * (CurrLowSeasonDays.Value + CurrMidSeasonDays.Value + CurrHighSeasonDays.Value+CurrExtensionDays.Value)) )
* CurrComission.Value/100 ;
end;

procedure TFrmReservation2.BtnGunClick(Sender: TObject);
var DateBirakilacak,DateAlinacak:TDateTime;
    i,x,TmpDays,TmpLow,TmpHigh,TmpMid:integer;
const
      Aylar: array [0..11] of string=
        ('January','February','March','April','May','June','July','August',
         'September','October','November','December');
      Hafta: array [0..6] of string= ('PT','SL','ÇR','PR','CU','CT','PZ');

begin
if PubKontrol=1 Then Exit;

TmpDays:=0; TmpLow:=0; TmpHigh:=0; TmpMid:=0;

DateBirakilacak  :=
EncodeDateTime(YearOf(DtBirakilacakTarih.Date),MonthOf(DtBirakilacakTarih.Date),DayOf(DtBirakilacakTarih.Date),HourOf(DtBirakilacakSaat.Time),MinuteOf(DtBirakilacakSaat.Time),0,0) ;

DateAlinacak  :=
EncodeDateTime(YearOf(DtAlinacakTarih.Date),MonthOf(DtAlinacakTarih.Date),DayOf(DtAlinacakTarih.Date),HourOf(DtAlinacakSaat.Time),MinuteOf(DtAlinacakSaat.Time),0,0) ;

TmpDays  := DaysBetween(DateBirakilacak,DateAlinacak) ;

if HourOf(DateAlinacak)> 12 Then
TmpDays  := TmpDays  + 1;

for i:=1 to TmpDays do begin

if  MonthOf(DtBirakilacakTarih.Date+i) in [11,12,1,2,3] Then TmpLow  := TmpLow  + 1;
if  MonthOf(DtBirakilacakTarih.Date+i) in [4,5,6]       Then TmpMid  := TmpMid  + 1;
if  MonthOf(DtBirakilacakTarih.Date+i) in [7,8,9,10]    Then TmpHigh := TmpHigh + 1;

end;

CurrTotalDays.Value      := TmpDays;
CurrLowSeasonDays.Value  := TmpLow;
CurrMidSeasonDays.Value  := TmpMid;
CurrHighSeasonDays.Value := TmpHigh;

BtnCalculate.Click;

end;

procedure TFrmReservation2.AgencyGetir;
var i:integer;
begin
CmbAgency.Clear;
qry1.Close;
qry1.SQL.Clear;
qry1.SQL.Add('Select * from Agency');
qry1.open;
CmbAgency.Items.Add('') ;
for i := 0 to qry1.RecordCount -1 do begin
CmbAgency.Items.Add(qry1.FieldByName('AgencyName').AsString) ;
qry1.Next;
end;
end;

procedure TFrmReservation2.BtnCalculateClick(Sender: TObject);
var x,TmpSaat1,TmpSaat2,TmpSaat:integer;
TmpDailyRate:Currency;
begin
if PubKontrol=1 Then Exit;

CurrTotalDays.Value       := CurrLowSeasonDays.Value + CurrMidSeasonDays.Value + CurrHighSeasonDays.Value + CurrExtensionDays.Value ;

CurrLowSeasonTotal.Value  := CurrLowSeasonRate.Value  * CurrLowSeasonDays.Value  ;
CurrMidSeasonTotal.Value  := CurrMidSeasonRate.Value  * CurrMidSeasonDays.Value  ;
CurrHighSeasonTotal.Value := CurrHighSeasonRate.Value * CurrHighSeasonDays.Value ;
CurrTotalinsurance.Value  := CurrDailyinsurance.Value * CurrTotalDays.Value      ;
CurrExtensionTotal.Value  := CurrExtensionRate.Value  * CurrExtensionDays.Value  ;


CurrTotalAmount.Value     :=
CurrLowSeasonTotal.Value + CurrMidSeasonTotal.Value + CurrHighSeasonTotal.Value + CurrTaxiPickUp.Value+CurrExtensionTotal.Value +
CurrTaxiDropOff.Value + CurrPetrol.Value + CurrExtra.Value + CurrTotalinsurance.Value ;

CurrOutstandingBalance.Value := (CurrTotalAmount.Value - CurrDiscount.Value) - (CurrPaidAmount1.Value+CurrPaidAmount2.Value+CurrPaidAmount3.Value+CurrPaidAmount4.Value);


//CurrRemainingAmount.Value := CurrOutstandingBalance.Value - (CurrPaidAmount1.Value+CurrPaidAmount2.Value+CurrPaidAmount3.Value+CurrPaidAmount4.Value);

BtnCommission.Click;

end;

procedure TFrmReservation2.ChkCollectTimeClick(Sender: TObject);
begin
if ChkCollectTime.Checked = True then
DtAlinacakSaat.Visible := True
Else DtAlinacakSaat.Visible := False ;

end;

procedure TFrmReservation2.ChkDegisimClick(Sender: TObject);
begin

if ChkDegisim.Checked = True then begin

if MessageDlg('Do you want to change the Customer ? ',mtConfirmation,[mbYes,mbNo],0) = mrYes Then begin

GrpCustomer.Enabled:=True;

end
Else ChkDegisim.Checked := False ;

end
Else  GrpCustomer.Enabled:=False;



end;

procedure TFrmReservation2.ChkDeliverTimeClick(Sender: TObject);
begin
if ChkDeliverTime.Checked = True then
DtBirakilacakSaat.Visible := True
Else DtBirakilacakSaat.Visible := False ;
end;

procedure TFrmReservation2.ChkFlightTime2Click(Sender: TObject);
begin
if ChkFlightTime2.Checked = True then
DtFlightTime2.Visible := True
Else DtFlightTime2.Visible := False ;
end;

procedure TFrmReservation2.ChkFlightTimeClick(Sender: TObject);
begin
if ChkFlightTime.Checked = True then
DtFlightTime.Visible := True
Else DtFlightTime.Visible := False ;
end;

procedure TFrmReservation2.ChkTaxiTimeCollectClick(Sender: TObject);
begin
if ChkTaxiTimeCollect.Checked = True then
DtTaxiTimeCollect.Visible := True
Else DtTaxiTimeCollect.Visible := False ;
end;

procedure TFrmReservation2.ChkTaxiTimeDeliverClick(Sender: TObject);
begin
if ChkTaxiTimeDeliver.Checked = True then
DtTaxiTimeDeliver.Visible := True
Else DtTaxiTimeDeliver.Visible := False ;
end;

procedure TFrmReservation2.CmbDrivingLicenseChange(Sender: TObject);
begin
CmbCustomerId.ItemIndex     := CmbDrivingLicense.ItemIndex;
CmbName.ItemIndex           := CmbDrivingLicense.ItemIndex;
Cmbsurname.ItemIndex        := CmbDrivingLicense.ItemIndex;
CmbContactNumber.ItemIndex  := CmbDrivingLicense.ItemIndex;
CmbPassportNo.ItemIndex     := CmbDrivingLicense.ItemIndex;
CmbPlaceofBirth.ItemIndex   := CmbDrivingLicense.ItemIndex;
TmpCustomerID               := StrToInt(CmbCustomerId.Text) ;

end;


procedure TFrmReservation2.CmbModelChange(Sender: TObject);
begin

Cmbid.ItemIndex       := CmbModel.ItemIndex;
CmbRegNo.ItemIndex    := CmbModel.ItemIndex;
CmbModel.ItemIndex    := CmbModel.ItemIndex;
CmbCarType.ItemIndex  := CmbModel.ItemIndex;
CmbCarGroup.ItemIndex := CmbModel.ItemIndex;

end;

procedure TFrmReservation2.CmbPlaceofBirthChange(Sender: TObject);
begin
CmbCustomerId.ItemIndex     := CmbPlaceofBirth.ItemIndex;
CmbName.ItemIndex           := CmbPlaceofBirth.ItemIndex;
Cmbsurname.ItemIndex        := CmbPlaceofBirth.ItemIndex;
CmbContactNumber.ItemIndex  := CmbPlaceofBirth.ItemIndex;
CmbPassportNo.ItemIndex     := CmbPlaceofBirth.ItemIndex;
CmbDrivingLicense.ItemIndex := CmbPlaceofBirth.ItemIndex;
TmpCustomerID               := StrToInt(CmbCustomerId.Text) ;
end;

procedure TFrmReservation2.CmbRegNoChange(Sender: TObject);
begin
Cmbid.ItemIndex       := CmbRegNo.ItemIndex;
CmbModel.ItemIndex    := CmbRegNo.ItemIndex;
CmbModel.ItemIndex    := CmbRegNo.ItemIndex;
CmbCarType.ItemIndex  := CmbRegNo.ItemIndex;
CmbCarGroup.ItemIndex := CmbRegNo.ItemIndex;
end;

procedure TFrmReservation2.CmbBirakilacakYerKeyPress(Sender: TObject;
  var Key: Char);
begin
key  := BuyukHarfCombo(key,Sender as TComboBox);
end;

procedure TFrmReservation2.CmbContactNumberChange(Sender: TObject);
begin
CmbCustomerId.ItemIndex     := CmbContactNumber.ItemIndex;
CmbName.ItemIndex           := CmbContactNumber.ItemIndex;
Cmbsurname.ItemIndex        := CmbContactNumber.ItemIndex;
CmbPassportNo.ItemIndex     := CmbContactNumber.ItemIndex;
CmbDrivingLicense.ItemIndex := CmbContactNumber.ItemIndex;
CmbPlaceofBirth.ItemIndex   := CmbContactNumber.ItemIndex;
TmpCustomerID               := StrToInt(CmbCustomerId.Text) ;

end;

procedure TFrmReservation2.CmbCurrencyChange(Sender: TObject);
begin
ParaBirimi;
end;

procedure TFrmReservation2.CmbNameChange(Sender: TObject);
begin
CmbCustomerId.ItemIndex     := CmbName.ItemIndex;
Cmbsurname.ItemIndex        := CmbName.ItemIndex;
CmbContactNumber.ItemIndex  := CmbName.ItemIndex;
CmbPassportNo.ItemIndex     := CmbName.ItemIndex;
CmbDrivingLicense.ItemIndex := CmbName.ItemIndex;
CmbPlaceofBirth.ItemIndex   := CmbName.ItemIndex;
TmpCustomerID               := StrToInt(CmbCustomerId.Text) ;


Qry1.Close;
qry1.SQL.Clear;
qry1.SQL.Add('Select id,Expire1 from customer where id=:id  ');
Qry1.Parameters.ParamByName('id').Value := TmpCustomerID  ;
qry1.Prepared;
qry1.Open;

if qry1.fieldbyname('Expire1').asDateTime <date then  showmessage('License Expired !!!');



end;

procedure TFrmReservation2.CmbPassportNoChange(Sender: TObject);
begin
CmbCustomerId.ItemIndex     := CmbPassportNo.ItemIndex;
CmbName.ItemIndex           := CmbPassportNo.ItemIndex;
Cmbsurname.ItemIndex        := CmbPassportNo.ItemIndex;
CmbContactNumber.ItemIndex  := CmbPassportNo.ItemIndex;
CmbDrivingLicense.ItemIndex := CmbPassportNo.ItemIndex;
CmbPlaceofBirth.ItemIndex   := CmbPassportNo.ItemIndex;
TmpCustomerID               := StrToInt(CmbCustomerId.Text) ;
end;

procedure TFrmReservation2.CmbSurnameChange(Sender: TObject);
begin
CmbCustomerId.ItemIndex     := CmbSurname.ItemIndex;
CmbName.ItemIndex           := CmbSurname.ItemIndex;
CmbPassportNo.ItemIndex     := CmbSurname.ItemIndex;
CmbContactNumber.ItemIndex  := CmbSurname.ItemIndex;
CmbDrivingLicense.ItemIndex := CmbSurname.ItemIndex;
CmbPlaceofBirth.ItemIndex   := CmbSurname.ItemIndex;
TmpCustomerID               := StrToInt(CmbCustomerId.Text) ;
end;

procedure TFrmReservation2.CmbTaxiDeliverFromChange(Sender: TObject);
begin
if (TxtFlightNumber.Text <>'') and (ChkFlightTime.Checked = True) then
DtTaxiTimeDeliver.Time := DtFlightTime.Time;
end;

procedure TFrmReservation2.CmbTaxiDeliverFromKeyPress(Sender: TObject;
  var Key: Char);
begin
key  := BuyukHarfCombo(key,Sender as TComboBox);
end;

procedure TFrmReservation2.CmbTaxiDeliverToKeyPress(Sender: TObject;
  var Key: Char);
begin
key  := BuyukHarfCombo(key,Sender as TComboBox);
end;

procedure TFrmReservation2.CompanyGetir;
var i:integer;
begin
CmbCompany.Clear;
qry1.Close;
qry1.SQL.Clear;
qry1.SQL.Add('Select * from Company');
qry1.open;
CmbCompany.Items.Add('') ;
for i := 0 to qry1.RecordCount -1 do begin
CmbCompany.Items.Add(qry1.FieldByName('CompanyName').AsString) ;
qry1.Next;
end;
end;

procedure TFrmReservation2.CreateParams(var Params: TCreateParams);
begin
 inherited CreateParams(Params);
 Params.ExStyle   := Params.ExStyle or WS_EX_APPWINDOW;
 Params.WndParent := GetDesktopWindow;
end;

procedure TFrmReservation2.CmbTaxiCollectFromKeyPress(Sender: TObject;
  var Key: Char);
begin
key  := BuyukHarfCombo(key,Sender as TComboBox);
end;

procedure TFrmReservation2.CmbTaxiCollectToKeyPress(Sender: TObject; var Key: Char);
begin
key  := BuyukHarfCombo(key,Sender as TComboBox);
end;

procedure TFrmReservation2.CmbAgencyKeyPress(Sender: TObject; var Key: Char);
begin
key  := BuyukHarfCombo(key,Sender as TComboBox);
end;

procedure TFrmReservation2.CmbalinacakyerKeyPress(Sender: TObject; var Key: Char);
begin
key  := BuyukHarfCombo(key,Sender as TComboBox);
end;

procedure TFrmReservation2.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin

PubReservasyonId := 0;
FrmReservation2.Temizle;
FrmReservation2.TmpCustomerID :=0 ;

Action := caFree;
FrmReservation2:= nil;

end;


procedure TFrmReservation2.FormShow(Sender: TObject);
var i:integer;
begin
Self.WindowState := wsMaximized ;

//SetWindowPos(Handle, HWND_TOPMOST, Left, Top, Width, Height, SWP_NOACTIVATE or SWP_NOMOVE or SWP_NOSIZE);

end;

end.
