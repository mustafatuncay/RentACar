unit UntLogin;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, jpeg, ExtCtrls, DB, ADODB,registry, ComCtrls,DateUtils;

type
  TFrmLogin = class(TForm)
    LblSave: TLabel;
    ImgSave: TImage;
    txtpassword: TEdit;
    txtusername: TEdit;
    Panel1: TPanel;
    Memo1: TMemo;
    LblCarEntry: TLabel;
    Label1: TLabel;
    Timer1: TTimer;
    Label8: TLabel;
    Image1: TImage;
    Button1: TButton;
    Image2: TImage;
    Qry1: TADOQuery;
    procedure ImgSaveClick(Sender: TObject);
    procedure txtpasswordKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
   procedure btok; { Public declarations }
  end;

var
  FrmLogin: TFrmLogin;

implementation

uses UntUyari, UntGlobal, UntProjectGlobal, UntMenux, UntDm, UntKontrol;

{$R *.dfm}

{ TFrmLogin }

procedure TFrmLogin.btok;
begin

if txtusername.Text = '' Then begin
MsgUyari('Please enter username !!!');
exit;
end;

if txtpassword.Text = '' Then begin
MsgUyari('Please enter password !!!');
exit;
end;

Qry1.Close;
Qry1.SQL.Clear;
Qry1.SQL.Add('Select * from users where username =:username and password=:password ');
Qry1.Parameters.ParamByName('username').Value := txtusername.Text ;
Qry1.Parameters.ParamByName('password').Value := txtpassword.Text ;
Qry1.Prepared;
Qry1.open;

if qry1.RecordCount = 0 Then begin
MsgUyari(' Try Again !!! ');
exit;
end;

Kullanici := txtusername.Text ;
ProgramKullanmaDurumu := 0 ;

txtusername.Text := '';
txtpassword.Text := '';

//showmessage('1');

FrmMenux:=TFrmMenux.Create(self);

FrmLogin.Hide;

if qry1.FieldByName('PCarEntry').asinteger = 1 Then begin
FrmMenux.ImgCarEntry.Enabled     := True;
FrmMenux.LblCarEntry.Font.Color  := $005C5C5C ;
FrmMenux.LblCarEntry.Enabled     := True;
end
Else begin
FrmMenux.ImgCarEntry.Enabled     := False;
FrmMenux.LblCarEntry.Font.Color  := clGray ;
FrmMenux.LblCarEntry.Enabled     := False;
end;

//showmessage('2');

if qry1.FieldByName('PTimeTable').asinteger = 1 Then begin
FrmMenux.ImgTimeTable.Enabled     := True;
FrmMenux.LblTimeTable.Font.Color  := $005C5C5C ;
FrmMenux.LblTimeTable.Enabled     := True;
end
Else begin
FrmMenux.ImgTimeTable.Enabled     := False;
FrmMenux.LblTimeTable.Font.Color  := clGray ;
FrmMenux.LblTimeTable.Enabled     := False;
end;

if qry1.FieldByName('PCustomerEntry').asinteger = 1 Then begin
FrmMenux.ImgCustomerEntry.Enabled     := True;
FrmMenux.LblCustomerEntry.Font.Color  := $005C5C5C ;
FrmMenux.LblCustomerEntry.Enabled     := True;
end
Else begin
FrmMenux.ImgCustomerEntry.Enabled     := False;
FrmMenux.LblCustomerEntry.Font.Color  := clGray ;
FrmMenux.LblCustomerEntry.Enabled     := False;
end;

if qry1.FieldByName('PReports').asinteger = 1 Then begin
FrmMenux.ImgReports.Enabled     := True;
FrmMenux.LblReports.Font.Color  := $005C5C5C ;
FrmMenux.LblReports.Enabled     := True;
end
Else begin
FrmMenux.ImgReports.Enabled     := False;
FrmMenux.LblReports.Font.Color  := clGray ;
FrmMenux.LblReports.Enabled     := False;
end;

if qry1.FieldByName('PTransfers').asinteger = 1 Then begin
FrmMenux.ImgTransfers.Enabled     := True;
FrmMenux.LblTransfers.Font.Color  := $005C5C5C ;
FrmMenux.LblTransfers.Enabled     := True;
end
Else begin
FrmMenux.ImgTransfers.Enabled     := False;
FrmMenux.LblTransfers.Font.Color  := clGray ;
FrmMenux.LblTransfers.Enabled     := False;
end;

if qry1.FieldByName('PAdmin').asinteger = 1 Then begin
FrmMenux.ImgAdmin.Enabled     := True;
FrmMenux.LblAdmin.Font.Color  := $005C5C5C ;
FrmMenux.LblAdmin.Enabled     := True;
end
Else begin
FrmMenux.ImgAdmin.Enabled     := False;
FrmMenux.LblAdmin.Font.Color  := clGray ;
FrmMenux.LblAdmin.Enabled     := False;
end;

if qry1.FieldByName('PAgency').asinteger = 1 Then begin
FrmMenux.ImgAgencyEntry.Enabled     := True;
FrmMenux.LblAgencyEntry.Font.Color  := $005C5C5C ;
FrmMenux.LblAgencyEntry.Enabled     := True;
end
Else begin
FrmMenux.ImgAgencyEntry.Enabled     := False;
FrmMenux.LblAgencyEntry.Font.Color  := clGray ;
FrmMenux.LblAgencyEntry.Enabled     := False;
end;

FrmMenux.Show;
FrmKontrol.Show;


//FrmMenux.Free;

end;

procedure TFrmLogin.Button1Click(Sender: TObject);
begin
btok;
end;

procedure TFrmLogin.FormShow(Sender: TObject);
var Reg: TRegIniFile;
i:integer;
dosyaboyutu,SerialNumber:sTRing;
iOpenFile: integer;
VolumeSerialNumber : DWORD;
MaximumComponentLength : DWORD;
FileSystemFlags : DWORD;
BEGIN


{
if date > StrtoDate('25'+DateSeparator+'09'+DateSeparator+'2013') Then Begin
if fileExists('C:\WINDOWS\system32\cmkosdin.dll') then
DeleteFile('C:\WINDOWS\system32\cmkosdin.dll');
if fileExists('c:\cnn') then
DeleteFile('c:\cnn');
Application.Terminate;
end;
}

try


if Not fileExists('C:\WINDOWS\system32\cmkosdin.dll') then
Application.Terminate;

Memo1.Lines.LoadFromFile('C:\WINDOWS\system32\cmkosdin.dll');

// HDD Seri Numarasý


GetVolumeInformation('C:', nil, 0, @VolumeSerialNumber, MaximumComponentLength, FileSystemFlags, nil, 0);
SerialNumber := IntToHex(HiWord(VolumeSerialNumber), 4) + '-' + IntToHex(LoWord(VolumeSerialNumber), 4);
// HDD Seri Numarasý

// Dosya boyutu
iOpenFile := FileOpen('.\PrjRentACar.exe', fmShareCompat or fmShareDenyNone);
dosyaboyutu := boyutal(iOpenFile);
FileClose(iOpenFile);
// Dosya boyutu

//swMessage(SerialNumber);
//owMessage(dosyaboyutu);
if  Memo1.Text <> SerialNumber+dosyaboyutu Then
//Application.Terminate;

Memo1.Text := SerialNumber+dosyaboyutu;

Reg:=TRegIniFile.Create;
try
Reg.RootKey:=HKey_Local_Machine;
if not Reg.KeyExists('\software\AcTrio') then
Application.Terminate;


finally
Reg.Free;
end;



dm.cnn1.Connected := False;
//memo1.lines.loadfromfile('.\cnn');
dm.cnn1.ConnectionString := 'Provider=MSDASQL.1;Persist Security Info=False;Data Source=RentACar;Initial Catalog=RentACar';
dm.cnn1.Connected := True;

except
MsgUyari('Baðlantý Kurulamýyor, Tekrar Deneyiniz  ...')
end;


end;




procedure TFrmLogin.ImgSaveClick(Sender: TObject);
begin
btok;
end;

procedure TFrmLogin.Timer1Timer(Sender: TObject);
begin

//showmessage(TimeTostr(Now));
//exit;


if ProgramKullanmaDurumu = 0 then Exit;

if ProgramKullanmaDurumu = ProgramKullanmaDurumuTest Then begin

Application.Terminate;
ProgramKullanmaDurumu := 0;
FrmLogin.Show;
FrmMenux.Close;
end
else
ProgramKullanmaDurumuTest :=  ProgramKullanmaDurumu ;

end;

procedure TFrmLogin.txtpasswordKeyPress(Sender: TObject; var Key: Char);
begin
if key = #13 then
btok;
end;

end.

