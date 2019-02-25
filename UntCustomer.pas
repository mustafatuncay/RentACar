unit UntCustomer;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, BaseGrid, AdvGrid, Menus, DB, ADODB, StdCtrls, Buttons, jpeg, ExtCtrls, Mask,
  MoneyEdit, ComCtrls,DateUtils,ShellApi, FileCtrl, FlCtrlEx;

type
  TFrmCustomer = class(TForm)
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
    TxtName: TEdit;
    Label4: TLabel;
    LblStatus: TLabel;
    TxtSurname: TEdit;
    Label3: TLabel;
    TxtTelNo: TEdit;
    Label5: TLabel;
    TxtAddress: TEdit;
    Label8: TLabel;
    Label9: TLabel;
    TxtEmail: TEdit;
    Label11: TLabel;
    TxtLicenseNo: TEdit;
    Label12: TLabel;
    TxtLocalNumber: TEdit;
    Label13: TLabel;
    TxtLocalAddress: TEdit;
    DtBirthDate: TDateTimePicker;
    ImgCustomerSearch: TImage;
    a: TImage;
    Label1: TLabel;
    Label7: TLabel;
    ChkBirthDate: TCheckBox;
    Image3: TImage;
    TxtPassportId: TEdit;
    Label10: TLabel;
    ChkBlackList: TCheckBox;
    Label14: TLabel;
    TxtCustomerNumber: TEdit;
    TxtBlackNote: TEdit;
    Label15: TLabel;
    TxtPlaceofBirth: TEdit;
    Label16: TLabel;
    TxtCyprusMobile: TEdit;
    TxtName2: TEdit;
    TxtSurName2: TEdit;
    Label17: TLabel;
    Label18: TLabel;
    ChkBirthDate2: TCheckBox;
    DtBirthDate2: TDateTimePicker;
    Label19: TLabel;
    TxtLicenseNo2: TEdit;
    Label20: TLabel;
    TxtPassportId2: TEdit;
    CmbBayBayan1: TComboBox;
    CmbBayBayan2: TComboBox;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    TxtName3: TEdit;
    TxtSurName3: TEdit;
    ChkBirthDate3: TCheckBox;
    DtBirthDate3: TDateTimePicker;
    TxtLicenseNo3: TEdit;
    TxtPassportId3: TEdit;
    CmbBayBayan3: TComboBox;
    FileListBoxEx1: TFileListBoxEx;
    BtnDosyaSec: TButton;
    OpenDialog1: TOpenDialog;
    DtExpire1: TDateTimePicker;
    DtExpire3: TDateTimePicker;
    DtExpire2: TDateTimePicker;
    Label25: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    TxtEmail2: TEdit;
    Label29: TLabel;
    TxtEmail3: TEdit;
    PopupMenu1: TPopupMenu;
    Delete1: TMenuItem;
    procedure ImgNewClick(Sender: TObject);
    procedure ImgDeleteClick(Sender: TObject);
    procedure ImgEditClick(Sender: TObject);
    procedure ImgSaveClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ImgCustomerSearchClick(Sender: TObject);
    procedure ChkBirthDateClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure TxtEmailDblClick(Sender: TObject);
    procedure ChkBirthDate2Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ChkBirthDate3Click(Sender: TObject);
    procedure FileListBoxEx1DblClick(Sender: TObject);
    procedure BtnDosyaSecClick(Sender: TObject);
    procedure TxtEmail2DblClick(Sender: TObject);
    procedure TxtEmail3DblClick(Sender: TObject);
    procedure Delete1Click(Sender: TObject);


  private
    { Private declarations }
  public
    procedure CreateParams(var Params: TCreateParams); override;
    Procedure temizle();
    Procedure KayitGetir(id:String);
    { Public declarations }
  end;

var
 FrmCustomer: TFrmCustomer;

implementation

uses UntGlobal, UntDlgCustomer, UntProjectGlobal;

{$R *.dfm}


procedure TFrmCustomer.ImgNewClick(Sender: TObject);
begin
ProgramKullanmaDurumu:=ProgramKullanmaDurumu+1;

temizle;

end;

procedure TFrmCustomer.BtnDosyaSecClick(Sender: TObject);
var
  fileSource, fileDest, TmpStr: string;
  i:integer;
begin
//FileListBoxEx1.Update;

if directoryexists('c:\dosyalar\'+inttostr(TxtName.Tag))=False Then CreateDir('c:\dosyalar\'+inttostr(TxtName.Tag));

OpenDialog1.execute;


  fileSource := OpenDialog1.filename;
  TmpStr:='';
  for i:=length(fileSource)  downto  1  do  begin
     if fileSource[i]='\' then break;
     TmpStr:=fileSource[i]+TmpStr;
  end;


  fileDest := 'c:\dosyalar\'+inttostr(TxtName.Tag)+'\'+TmpStr;
  CopyFile(PChar(fileSource), PChar(fileDest), False);

  if directoryexists('c:\dosyalar\'+inttostr(TxtName.Tag))=True Then
   FileListBoxEx1.Directory :='c:\dosyalar\'+inttostr(TxtName.Tag)
Else
   FileListBoxEx1.Directory :=  'c:\dosyalar\empty' ;

   FileListBoxEx1.update;

end;

procedure TFrmCustomer.ChkBirthDate2Click(Sender: TObject);
begin
if ChkBirthDate2.Checked = True then
DtBirthDate2.Visible := True
Else
DtBirthDate2.Visible := False;

end;

procedure TFrmCustomer.ChkBirthDate3Click(Sender: TObject);
begin
if ChkBirthDate3.Checked = True then
DtBirthDate3.Visible := True
Else
DtBirthDate3.Visible := False;
end;

procedure TFrmCustomer.ChkBirthDateClick(Sender: TObject);
begin
if ChkBirthDate.Checked = True then
DtBirthDate.Visible := True
Else
DtBirthDate.Visible := False;



end;



procedure TFrmCustomer.CreateParams(var Params: TCreateParams);
begin
 inherited CreateParams(Params);
  Params.ExStyle   := Params.ExStyle or WS_EX_APPWINDOW;
  Params.WndParent := GetDesktopWindow;
end;

procedure TFrmCustomer.Delete1Click(Sender: TObject);
var Dosya:String;
begin
if directoryexists('c:\dosyalar\'+inttostr(TxtName.Tag))=True Then
   dosya  :=  'c:\dosyalar\'+inttostr(TxtName.Tag)+'\'+Filelistboxex1.Items[filelistboxex1.itemIndex]
Else
   dosya  :=  'c:\dosyalar\empty'+inttostr(TxtName.Tag)+'\'+Filelistboxex1.Items[filelistboxex1.itemIndex];



DeleteFile(Dosya);

 FileListBoxEx1.update;
end;

procedure TFrmCustomer.TxtEmail2DblClick(Sender: TObject);
var
  TmpMail: String;
begin
 // pCh := 'mailto:mshkolnik@scalabium.com?subject=your_subject&body=your_body&file="c:\autoexec.bat"';
  TmpMail := 'mailto:'+ TxtEmail2.Text ;
  ShellExecute(0, 'open', PChar(TmpMail), nil, nil, SW_SHOWNORMAL);
end;

procedure TFrmCustomer.TxtEmail3DblClick(Sender: TObject);
var
  TmpMail: String;
begin
 // pCh := 'mailto:mshkolnik@scalabium.com?subject=your_subject&body=your_body&file="c:\autoexec.bat"';
  TmpMail := 'mailto:'+ TxtEmail3.Text ;
  ShellExecute(0, 'open', PChar(TmpMail), nil, nil, SW_SHOWNORMAL);
end;



procedure TFrmCustomer.FileListBoxEx1DblClick(Sender: TObject);
var TmpStr:String;
begin
TmpStr := FileListBoxEx1.FileName ;
ShellExecute(Handle, 'open',PChar(TmpStr), nil, nil, SW_SHOWNORMAL) ;
end;

procedure TFrmCustomer.FormClose(Sender: TObject; var Action: TCloseAction);
begin
//Action := caFree;
//FrmCustomer:= nil;
end;

procedure TFrmCustomer.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if  key = VK_ESCAPE  then close;
end;

procedure TFrmCustomer.FormShow(Sender: TObject);
begin
//  SetWindowPos(Handle, HWND_TOPMOST, Left, Top, Width, Height, SWP_NOACTIVATE or SWP_NOMOVE or SWP_NOSIZE);

if directoryexists('c:\dosyalar\'+inttostr(TxtName.Tag))=True Then
   FileListBoxEx1.Directory :='c:\dosyalar\'+inttostr(TxtName.Tag)
Else
   FileListBoxEx1.Directory :=  'c:\dosyalar\empty' ;

end;

procedure TFrmCustomer.ImgCustomerSearchClick(Sender: TObject);
begin
ProgramKullanmaDurumu:=ProgramKullanmaDurumu+1;

FrmDlgCustomer:=TFrmDlgCustomer.Create(self);
FrmDlgCustomer.ShowModal;

if FrmDlgCustomer.iptal = False then begin
FrmCustomer.KayitGetir(FrmDlgCustomer.Qry1.fieldbyname('id').AsString);
LblStatus.Caption   := 'Edit / Delete existing record or click "New" for new entries... ';
end;

FileListBoxEx1.clear;

if directoryexists('c:\dosyalar\'+inttostr(TxtName.Tag))=True Then
   FileListBoxEx1.Directory :='c:\dosyalar\'+inttostr(TxtName.Tag)
Else
   FileListBoxEx1.Directory :=  'c:\dosyalar\empty' ;

if FrmCustomer.TxtName.Tag=0 then begin
FrmCustomer.FileListBoxEx1.visible := False;
FrmCustomer.BtnDosyaSec.visible := False;
end
Else begin
FrmCustomer.FileListBoxEx1.visible := True;
FrmCustomer.BtnDosyaSec.visible := True;
end;



FrmDlgCustomer.Free;

end;

procedure TFrmCustomer.ImgDeleteClick(Sender: TObject);
begin
ProgramKullanmaDurumu:=ProgramKullanmaDurumu+1;

if MsgOnay('Do you want to delete ? ') Then begin

qry1.Close;
qry1.SQL.Clear;
qry1.SQL.Add('Delete from Customer where id='''+IntToStr(TxtName.Tag)+''' ');
qry1.ExecSQL;

temizle;

end;

end;

procedure TFrmCustomer.ImgEditClick(Sender: TObject);
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

qry1.Close;
qry1.SQL.Clear;
qry1.SQL.Add('Select id from Customer where id<>:id and Name=:Name and Surname=:Surname ');
Qry1.Parameters.ParamByName('Name').Value    := trim(TxtName.Text) ;
Qry1.Parameters.ParamByName('Surname').Value := trim(TxtSurname.Text) ;
Qry1.Parameters.ParamByName('id').Value      := TxtName.Tag ;
qry1.Prepared;
qry1.open;
if qry1.RecordCount <> 0 then Begin
MsgUyari('Customer Available , Can Not Save ...');
exit;
end;

TmpSql:='update Customer set ' +

' PassportId=:PassportId, '+
' Name=:Name, '+
' Surname=:Surname, '+
' Address=:Address, ' +
' Email=:Email, '  +
' BirthDate=:BirthDate, '  +
' LicenseNo=:LicenseNo, '  +
' LocalNumber=:LocalNumber, '  +
' LocalAddress=:LocalAddress, '  +
' TelNo=:TelNo, '  +
' CheckedBirthDate=:CheckedBirthDate, '  +
' CustNumber=:CustNumber, '  +
' BlackList=:BlackList, '  +
' CyprusMobile=:CyprusMobile,'+
' PlaceofBirth=:PlaceofBirth,'+
' BlackNote=:BlackNote,'+
' Name2=:Name2, '+
' Surname2 =:Surname2, '+
' PassportId2=:PassportId2, '+
' LicenseNo2=:LicenseNo2, '  +
' CheckedBirthDate2=:CheckedBirthDate2, '  +
' BirthDate2=:BirthDate2, '  +
' BayBayan1=:BayBayan1, '  +
' BayBayan2=:BayBayan2, '  +

' Name3=:Name3, '+
' Surname3 =:Surname3, '+
' PassportId3=:PassportId3, '+
' LicenseNo3=:LicenseNo3, '  +
' CheckedBirthDate3=:CheckedBirthDate3, '  +
' BirthDate3=:BirthDate3, '  +
' BayBayan3=:BayBayan3, '  +

' Expire1=:Expire1, '  +
' Expire2=:Expire2, '  +
' Expire3=:Expire3, '  +
' Email2=:Email2, '  +
' Email3=:Email3 '  +


' where id = :id ';

qry1.Close;
qry1.SQL.Clear;
qry1.SQL.Add(TmpSql);
Qry1.Parameters.ParamByName('PassportId').Value  := trim(TxtPassportId.Text)     ;
Qry1.Parameters.ParamByName('Name').Value        := trim(TxtName.Text)     ;
Qry1.Parameters.ParamByName('Surname').Value     := trim(TxtSurname.Text)  ;
Qry1.Parameters.ParamByName('Address').Value     := trim(TxtAddress.Text)  ;
Qry1.Parameters.ParamByName('Email').Value       := trim(TxtEmail.Text)    ;

Qry1.Parameters.ParamByName('BirthDate').Value := IntToStr(YearOf(DtBirthDate.Date))+'-'+
                                            IntToStr(MonthOf(DtBirthDate.Date))+'-'+
                                            IntToStr(DayOf(DtBirthDate.Date));

Qry1.Parameters.ParamByName('LicenseNo').Value   := trim(TxtLicenseNo.Text)   ;
Qry1.Parameters.ParamByName('LocalNumber').Value := trim(TxtLocalNumber.Text) ;
Qry1.Parameters.ParamByName('LocalAddress').Value:= trim(TxtLocalAddress.Text);
Qry1.Parameters.ParamByName('TelNo').Value:= trim(TxtTelNo.Text);


if ChkBirthDate.Checked = True then
Qry1.Parameters.ParamByName('CheckedBirthDate').Value := 'Y'
Else Qry1.Parameters.ParamByName('CheckedBirthDate').Value := 'N';

if ChkBlackList.Checked = True then
Qry1.Parameters.ParamByName('BlackList').Value := 'Y'
Else Qry1.Parameters.ParamByName('BlackList').Value := 'N';

Qry1.Parameters.ParamByName('CustNumber').Value:= trim(TxtCustomerNumber.Text);

Qry1.Parameters.ParamByName('CyprusMobile').Value:= trim(TxtCyprusMobile.Text);
Qry1.Parameters.ParamByName('PlaceofBirth').Value:= trim(TxtPlaceofBirth.Text);
Qry1.Parameters.ParamByName('BlackNote').Value:= trim(TxtBlackNote.Text);

Qry1.Parameters.ParamByName('Name2').Value        := trim(TxtName2.Text)     ;
Qry1.Parameters.ParamByName('Surname2').Value     := trim(TxtSurName2.Text)  ;

Qry1.Parameters.ParamByName('PassportId2').Value  := trim(TxtPassportId2.Text)   ;
Qry1.Parameters.ParamByName('LicenseNo2').Value   := trim(TxtLicenseNo2.Text)   ;
if ChkBirthDate2.Checked = True then
Qry1.Parameters.ParamByName('CheckedBirthDate2').Value := 'Y'
Else Qry1.Parameters.ParamByName('CheckedBirthDate2').Value := 'N';
Qry1.Parameters.ParamByName('BirthDate2').Value :=
IntToStr(YearOf(DtBirthDate2.Date))+'-'+IntToStr(MonthOf(DtBirthDate2.Date))+'-'+IntToStr(DayOf(DtBirthDate2.Date));

Qry1.Parameters.ParamByName('BayBayan1').Value   := CmbBayBayan1.Text  ;
Qry1.Parameters.ParamByName('BayBayan2').Value   := CmbBayBayan2.Text  ;
/////////////////////////////
Qry1.Parameters.ParamByName('Name3').Value        := trim(TxtName3.Text)     ;
Qry1.Parameters.ParamByName('Surname3').Value     := trim(TxtSurName3.Text)  ;
Qry1.Parameters.ParamByName('PassportId3').Value  := trim(TxtPassportId3.Text)   ;
Qry1.Parameters.ParamByName('LicenseNo3').Value   := trim(TxtLicenseNo3.Text)   ;
if ChkBirthDate3.Checked = True then
Qry1.Parameters.ParamByName('CheckedBirthDate3').Value := 'Y'
Else Qry1.Parameters.ParamByName('CheckedBirthDate3').Value := 'N';
Qry1.Parameters.ParamByName('BirthDate3').Value :=
IntToStr(YearOf(DtBirthDate2.Date))+'-'+IntToStr(MonthOf(DtBirthDate3.Date))+'-'+IntToStr(DayOf(DtBirthDate3.Date));

Qry1.Parameters.ParamByName('BayBayan3').Value   := CmbBayBayan3.Text  ;

Qry1.Parameters.ParamByName('Expire1').Value :=
IntToStr(YearOf(DtExpire1.Date))+'-'+IntToStr(MonthOf(DtExpire1.Date))+'-'+IntToStr(DayOf(DtExpire1.Date));
Qry1.Parameters.ParamByName('Expire2').Value :=
IntToStr(YearOf(DtExpire2.Date))+'-'+IntToStr(MonthOf(DtExpire2.Date))+'-'+IntToStr(DayOf(DtExpire2.Date));
Qry1.Parameters.ParamByName('Expire3').Value :=
IntToStr(YearOf(DtExpire3.Date))+'-'+IntToStr(MonthOf(DtExpire3.Date))+'-'+IntToStr(DayOf(DtExpire3.Date));

Qry1.Parameters.ParamByName('Email2').Value       := trim(TxtEmail2.Text)    ;
Qry1.Parameters.ParamByName('Email3').Value       := trim(TxtEmail3.Text)    ;

Qry1.Parameters.ParamByName('id').Value          := TxtName.Tag;
qry1.Prepared;
qry1.ExecSQL;



TmpSql:='Update Reservation set Name=:Name, Surname=:Surname where Customerid=:Customerid ' ;
qry1.Close;
qry1.SQL.Clear;
qry1.SQL.Add(TmpSql);
Qry1.Parameters.ParamByName('Name').Value        := trim(TxtName.Text)     ;
Qry1.Parameters.ParamByName('Surname').Value     := trim(TxtSurname.Text)  ;
Qry1.Parameters.ParamByName('Customerid').Value          := TxtName.Tag;
qry1.Prepared;
qry1.ExecSQL;

TmpSql:='Update Transfer set Name=:Name, Surname=:Surname where Customerid=:Customerid ' ;
qry1.Close;
qry1.SQL.Clear;
qry1.SQL.Add(TmpSql);
Qry1.Parameters.ParamByName('Name').Value        := trim(TxtName.Text)     ;
Qry1.Parameters.ParamByName('Surname').Value     := trim(TxtSurname.Text)  ;
Qry1.Parameters.ParamByName('Customerid').Value          := TxtName.Tag;
qry1.Prepared;
qry1.ExecSQL;



MsgUyari('Update successfully ... ');
Self.Close;

end;

procedure TFrmCustomer.ImgSaveClick(Sender: TObject);
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

qry1.Close;
qry1.SQL.Clear;
qry1.SQL.Add('Select id from Customer where Name=:Name and Surname=:Surname ');
Qry1.Parameters.ParamByName('Name').Value    := trim(TxtName.Text) ;
Qry1.Parameters.ParamByName('Surname').Value := trim(TxtSurname.Text) ;
qry1.Prepared;
qry1.open;
if qry1.RecordCount <> 0 then Begin
MsgUyari('Customer Available , Can Not Save ...');
exit;
end;


TmpSql:='insert into Customer ' +
'(PassportId,Name,Surname,Address,Email,BirthDate,LicenseNo,LocalNumber,LocalAddress,TelNo,CheckedBirthDate,BlackList,CustNumber,'+
'CyprusMobile,PlaceofBirth,BlackNote,Name2,Surname2,PassportId2,LicenseNo2,CheckedBirthDate2,BirthDate2,BayBayan1,BayBayan2 ' +
',Name3,Surname3,PassportId3,LicenseNo3,CheckedBirthDate3,BirthDate3,BayBayan3,Expire1,Expire2,Expire3,Email2,Email3) '+
'Values (:PassportId,:Name,:Surname,:Address,:Email,:BirthDate,:LicenseNo,:LocalNumber,:LocalAddress,:TelNo,:CheckedBirthDate,'+
':BlackList,:CustNumber,:CyprusMobile,:PlaceofBirth,:BlackNote,:Name2,:Surname2,:PassportId2,:LicenseNo2,:CheckedBirthDate2,:BirthDate2,:BayBayan1,:BayBayan2'+
',:Name3,:Surname3,:PassportId3,:LicenseNo3,:CheckedBirthDate3,:BirthDate3,:BayBayan3,:Expire1,:Expire2,:Expire3,:Email2,:Email3) ';

qry1.Close;
qry1.SQL.Clear;
qry1.SQL.Add(TmpSql);
Qry1.Parameters.ParamByName('PassportId').Value  := trim(TxtPassportId.Text)     ;
Qry1.Parameters.ParamByName('Name').Value        := trim(TxtName.Text)     ;
Qry1.Parameters.ParamByName('Surname').Value     := trim(TxtSurname.Text)  ;
Qry1.Parameters.ParamByName('Address').Value     := trim(TxtAddress.Text)  ;
Qry1.Parameters.ParamByName('Email').Value       := trim(TxtEmail.Text)    ;
Qry1.Parameters.ParamByName('BirthDate').Value :=
IntToStr(YearOf(DtBirthDate.Date))+'-'+IntToStr(MonthOf(DtBirthDate.Date))+'-'+IntToStr(DayOf(DtBirthDate.Date));

Qry1.Parameters.ParamByName('LicenseNo').Value   := trim(TxtLicenseNo.Text)   ;
Qry1.Parameters.ParamByName('LocalNumber').Value := trim(TxtLocalNumber.Text) ;
Qry1.Parameters.ParamByName('LocalAddress').Value:= trim(TxtLocalAddress.Text);
Qry1.Parameters.ParamByName('TelNo').Value:= trim(TxtTelNo.Text);

if ChkBirthDate.Checked = True then
Qry1.Parameters.ParamByName('CheckedBirthDate').Value := 'Y'
Else Qry1.Parameters.ParamByName('CheckedBirthDate').Value := 'N';

if ChkBlackList.Checked = True then
Qry1.Parameters.ParamByName('BlackList').Value := 'Y'
Else Qry1.Parameters.ParamByName('BlackList').Value := 'N';

Qry1.Parameters.ParamByName('CustNumber').Value:= trim(TxtCustomerNumber.Text);


Qry1.Parameters.ParamByName('CyprusMobile').Value:= trim(TxtCyprusMobile.Text);
Qry1.Parameters.ParamByName('PlaceofBirth').Value:= trim(TxtPlaceofBirth.Text);
Qry1.Parameters.ParamByName('BlackNote').Value:= trim(TxtBlackNote.Text);

Qry1.Parameters.ParamByName('Name2').Value        := trim(TxtName2.Text)     ;
Qry1.Parameters.ParamByName('Surname2').Value     := trim(TxtSurName2.Text)  ;
Qry1.Parameters.ParamByName('PassportId2').Value  := trim(TxtPassportId2.Text)   ;
Qry1.Parameters.ParamByName('LicenseNo2').Value   := trim(TxtLicenseNo2.Text)   ;
if ChkBirthDate2.Checked = True then
Qry1.Parameters.ParamByName('CheckedBirthDate2').Value := 'Y'
Else Qry1.Parameters.ParamByName('CheckedBirthDate2').Value := 'N';
Qry1.Parameters.ParamByName('BirthDate2').Value :=
IntToStr(YearOf(DtBirthDate2.Date))+'-'+IntToStr(MonthOf(DtBirthDate2.Date))+'-'+IntToStr(DayOf(DtBirthDate2.Date));

Qry1.Parameters.ParamByName('BayBayan1').Value   := CmbBayBayan1.Text  ;
Qry1.Parameters.ParamByName('BayBayan2').Value   := CmbBayBayan2.Text  ;

////////////////

Qry1.Parameters.ParamByName('Name3').Value        := trim(TxtName3.Text)     ;
Qry1.Parameters.ParamByName('Surname3').Value     := trim(TxtSurName3.Text)  ;
Qry1.Parameters.ParamByName('PassportId3').Value  := trim(TxtPassportId3.Text)   ;
Qry1.Parameters.ParamByName('LicenseNo3').Value   := trim(TxtLicenseNo3.Text)   ;
if ChkBirthDate3.Checked = True then
Qry1.Parameters.ParamByName('CheckedBirthDate3').Value := 'Y'
Else Qry1.Parameters.ParamByName('CheckedBirthDate3').Value := 'N';
Qry1.Parameters.ParamByName('BirthDate3').Value :=
IntToStr(YearOf(DtBirthDate3.Date))+'-'+IntToStr(MonthOf(DtBirthDate3.Date))+'-'+IntToStr(DayOf(DtBirthDate3.Date));

Qry1.Parameters.ParamByName('BayBayan3').Value   := CmbBayBayan3.Text  ;

Qry1.Parameters.ParamByName('Expire1').Value :=
IntToStr(YearOf(DtExpire1.Date))+'-'+IntToStr(MonthOf(DtExpire1.Date))+'-'+IntToStr(DayOf(DtExpire1.Date));
Qry1.Parameters.ParamByName('Expire2').Value :=
IntToStr(YearOf(DtExpire2.Date))+'-'+IntToStr(MonthOf(DtExpire2.Date))+'-'+IntToStr(DayOf(DtExpire2.Date));
Qry1.Parameters.ParamByName('Expire3').Value :=
IntToStr(YearOf(DtExpire3.Date))+'-'+IntToStr(MonthOf(DtExpire3.Date))+'-'+IntToStr(DayOf(DtExpire3.Date));

Qry1.Parameters.ParamByName('Email2').Value       := trim(TxtEmail2.Text)    ;
Qry1.Parameters.ParamByName('Email3').Value       := trim(TxtEmail3.Text)    ;

qry1.Prepared;
qry1.ExecSQL;

Qry1.Close;
Qry1.SQL.Clear;
Qry1.SQL.Add('Select max(id) as idx  from Customer  ');
Qry1.Open;
TxtName.Tag    := Qry1.fieldbyname('idx').AsInteger          ;

FileListBoxEx1.visible := True;
BtnDosyaSec.visible := True;



MsgUyari('Save Successfully ...') ;

Self.Close;
end;

procedure TFrmCustomer.KayitGetir(id: String);
begin

Qry1.Close;
Qry1.SQL.Clear;
Qry1.SQL.Add('Select * from Customer where id=:id ');
Qry1.Parameters.ParamByName('id').Value := id ;
Qry1.Prepared;
Qry1.Open;

TxtName.Tag         := Qry1.fieldbyname('id').AsInteger          ;
TxtPassportId.Text  := Qry1.fieldbyname('PassportId').AsString   ;
TxtName.Text        := Qry1.fieldbyname('Name').AsString         ;
TxtSurname.Text     := Qry1.fieldbyname('Surname').AsString      ;
TxtAddress.Text     := Qry1.fieldbyname('Address').AsString      ;
TxtEmail.Text       := Qry1.fieldbyname('Email').AsString        ;
TxtTelNo.Text       := Qry1.fieldbyname('TelNo').AsString        ;
DtBirthDate.Date    := Qry1.fieldbyname('BirthDate').AsDateTime  ;
TxtLicenseNo.Text   := Qry1.fieldbyname('LicenseNo').AsString    ;
TxtLocalNumber.Text := Qry1.fieldbyname('LocalNumber').AsString  ;
TxtLocalAddress.Text:= Qry1.fieldbyname('LocalAddress').AsString ;

if Qry1.fieldbyname('CheckedBirthDate').Value = 'Y' Then ChkBirthDate.Checked := True
Else FrmCustomer.ChkBirthDate.Checked := False ;

if Qry1.fieldbyname('BlackList').Value = 'Y' Then ChkBlackList.Checked := True
Else ChkBlackList.Checked := False ;

TxtCustomerNumber.Text := Qry1.fieldbyname('CustNumber').AsString ;
TxtCyprusMobile.Text   := Qry1.fieldbyname('CyprusMobile').AsString ;
TxtPlaceofBirth.Text   := Qry1.fieldbyname('PlaceofBirth').AsString ;
TxtBlackNote.Text      := Qry1.fieldbyname('BlackNote').AsString    ;
TxtName2.Text          := Qry1.fieldbyname('Name2').AsString        ;
TxtName3.Text          := Qry1.fieldbyname('Name3').AsString        ;
TxtSurname2.Text       := Qry1.fieldbyname('Surname2').AsString     ;
TxtSurname3.Text       := Qry1.fieldbyname('Surname3').AsString     ;

TxtPassportId2.Text  := Qry1.fieldbyname('PassportId2').AsString   ;
TxtPassportId3.Text  := Qry1.fieldbyname('PassportId3').AsString   ;

TxtLicenseNo2.Text   := Qry1.fieldbyname('LicenseNo2').AsString    ;
TxtLicenseNo3.Text   := Qry1.fieldbyname('LicenseNo3').AsString    ;

if Qry1.fieldbyname('CheckedBirthDate2').Value = 'Y' Then ChkBirthDate2.Checked := True
Else FrmCustomer.ChkBirthDate2.Checked := False ;

if Qry1.fieldbyname('CheckedBirthDate3').Value = 'Y' Then ChkBirthDate3.Checked := True
Else FrmCustomer.ChkBirthDate3.Checked := False ;

DtBirthDate2.Date    := Qry1.fieldbyname('BirthDate2').AsDateTime  ;
DtBirthDate3.Date    := Qry1.fieldbyname('BirthDate3').AsDateTime  ;

CmbBayBayan1.ItemIndex := CmbBayBayan1.Items.IndexOf(Qry1.fieldbyname('BayBayan1').AsString) ;
CmbBayBayan2.ItemIndex := CmbBayBayan2.Items.IndexOf(Qry1.fieldbyname('BayBayan2').AsString) ;
CmbBayBayan3.ItemIndex := CmbBayBayan3.Items.IndexOf(Qry1.fieldbyname('BayBayan3').AsString) ;

DtExpire1.Date  := Qry1.fieldbyname('Expire1').AsDateTime  ;
DtExpire2.Date  := Qry1.fieldbyname('Expire2').AsDateTime  ;
DtExpire3.Date  := Qry1.fieldbyname('Expire3').AsDateTime  ;

TxtEmail2.Text       := Qry1.fieldbyname('Email2').AsString        ;
TxtEmail3.Text       := Qry1.fieldbyname('Email3').AsString        ;

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

procedure TFrmCustomer.temizle;
begin

ChkBirthDate.Checked := False;
ChkBirthDate2.Checked := False;
ChkBirthDate3.Checked := False;

TxtPassportId.Clear;
TxtPassportId2.Clear;
TxtName.Clear;
TxtName2.Clear;
TxtName3.Clear;
TxtTelNo.Clear;
TxtSurname.Clear;
TxtSurname2.Clear;
TxtSurname3.Clear;
TxtAddress.Clear;
TxtEmail.Clear;
TxtLicenseNo.Clear;
TxtLicenseNo2.Clear;
TxtLicenseNo3.Clear;
TxtLocalNumber.Clear;
TxtLocalAddress.Clear;
TxtCustomerNumber.Clear;
TxtCyprusMobile.Clear;
TxtBlackNote.Clear;
TxtPlaceofBirth.Clear;

DtBirthDate.Date := Date;
DtBirthDate2.Date := Date;
DtBirthDate3.Date := Date;


TxtName.Tag := 0 ;

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

procedure TFrmCustomer.TxtEmailDblClick(Sender: TObject);
var
  TmpMail: String;
begin
 // pCh := 'mailto:mshkolnik@scalabium.com?subject=your_subject&body=your_body&file="c:\autoexec.bat"';
  TmpMail := 'mailto:'+ TxtEmail.Text ;
  ShellExecute(0, 'open', PChar(TmpMail), nil, nil, SW_SHOWNORMAL);
end;

end.
