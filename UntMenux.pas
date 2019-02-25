unit UntMenux;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,registry, StdCtrls, jpeg, ExtCtrls, ToolWin, ActnMan, ActnCtrls, xmldom, XMLIntf, msxmldom, XMLDoc,
  IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient, IdHTTP, Grids,
  AdvObj, BaseGrid, AdvGrid,StrUtils, DB, ADODB,DateUtils, AdvUtil;

type
  TFrmMenux = class(TForm)
    Image3: TImage;
    ImgCarEntry: TImage;
    LblCarEntry: TLabel;
    ImgCustomerEntry: TImage;
    LblCustomerEntry: TLabel;
    ImgReports: TImage;
    ImgAdmin: TImage;
    ImgTransfers: TImage;
    ImgTimeTable: TImage;
    LblTimeTable: TLabel;
    LblReports: TLabel;
    LblTransfers: TLabel;
    LblAdmin: TLabel;
    LblAgencyEntry: TLabel;
    ImgAgencyEntry: TImage;
    Label8: TLabel;
    ImgKur: TImage;
    LblKur: TLabel;
    Image1: TImage;
    MemDoviz: TMemo;
    AdvDoviz: TAdvStringGrid;
    IdHTTP1: TIdHTTP;
    XMLDocument1: TXMLDocument;
    BtnDoviz: TButton;
    Qry1: TADOQuery;
    CmbKur: TComboBox;
    Qry2: TADOQuery;
    Label1: TLabel;
    Image4: TImage;
    Image5: TImage;
    Label2: TLabel;
    Image2: TImage;
    procedure Image3Click(Sender: TObject);
    procedure ImgCarEntryClick(Sender: TObject);
    procedure ImgTimeTableClick(Sender: TObject);
    procedure ImgTransfersClick(Sender: TObject);
    procedure ImgCustomerEntryClick(Sender: TObject);
    procedure ImgReportsClick(Sender: TObject);
    procedure ImgAdminClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure ImgAgencyEntryClick(Sender: TObject);
    procedure ImgKurClick(Sender: TObject);
    procedure BtnDovizClick(Sender: TObject);
    procedure Image4Click(Sender: TObject);
    procedure Label2Click(Sender: TObject);
  private
    { Private declarations }
  public
    procedure CreateParams(var Params: TCreateParams); override;
    function DownloadFile(SourceFile, DestFile: string): Boolean;
    { Public declarations }
  end;

var
  FrmMenux: TFrmMenux;

implementation

uses UntDm, UntProjectGlobal, UntGlobal, UntCar, UntTimeTable, UntCustomer,
  UntReports, UntAdmin, UntTransfers, UntReservation2, UntAgency, UntCarList,
  UntKur, UntSabitDegerler, UntCompany,  URLMon, ShellApi;

{$R *.dfm}



procedure TFrmMenux.BtnDovizClick(Sender: TObject);
var
z,ze,s,se,alis,alise,satis,satise,aranan,aranan2,TmpSql:string;
yer,yere,i:Integer;
TmpKur,TmpKur2,SatisDolar,SatisEuro,SatisSterlin:Currency;
begin

TRY
{
XMLDocument1.Active:=false;
XMLDocument1.FileName:='http://www.kktcmerkezbankasi.org/kur/gunluk.xml';
XMLDocument1.Active:=true;
}

//XMLDocument1.SaveToFile(GetCurrentDir+'\x.xml');


//Memo1.Lines.LoadFromFile('AdvDoviz.LoadFromXML(GetCurrentDir+'\gunluk.xml');');
//AdvDoviz.LoadFromXML(GetCurrentDir+'\gunluk.xml');





  if DownloadFile('http://www.kktcmerkezbankasi.org/kur/gunluk.xml', GetCurrentDir+'\gunluk.xml') then
  begin
  AdvDoviz.LoadFromXML(GetCurrentDir+'\gunluk.xml');
  end;






AdvDoviz.AutoSize:=True;

MemDoviz.Clear;
MemDoviz.Lines.Add( RightStr('                            ',21)   + LeftStr('Buying         ',9)+LeftStr('Selling        ',10));
MemDoviz.Lines.Add(' ');
MemDoviz.Lines.Add( RightStr('               '+'Dollar'+'  ',20) + LeftStr(AdvDoviz.Cells[5,4]+'       ',10)+LeftStr(AdvDoviz.Cells[6,4]+'        ',10))  ;
MemDoviz.Lines.Add( RightStr('               '+'Euro'+'  ',20)+ LeftStr(AdvDoviz.Cells[26,4]+'      ',10)+LeftStr(AdvDoviz.Cells[27,4]+'       ',10)) ;
MemDoviz.Lines.Add( RightStr('               '+'Sterlin'+'  ',20)+ LeftStr(AdvDoviz.Cells[33,4]+'      ',10)+LeftStr(AdvDoviz.Cells[34,4]+'       ',10)) ;

AlisDolar   :=  StrToCurr(AdvDoviz.Cells[5,4])  ;
AlisEuro    :=  StrToCurr(AdvDoviz.Cells[26,4]) ;
AlisSterlin :=  StrToCurr(AdvDoviz.Cells[33,4]) ;
SatisDolar   :=  StrToCurr(AdvDoviz.Cells[6,4])  ;
SatisEuro    :=  StrToCurr(AdvDoviz.Cells[27,4]) ;
SatisSterlin :=  StrToCurr(AdvDoviz.Cells[34,4]) ;


//////////////////////////////////////////////////////////////////////////////

for i:=0 to 2 do begin

CmbKur.ItemIndex := i ;

if CmbKur.Text = 'STERLIN' Then begin TmpKur:= AlisSterlin ; TmpKur2:=SatisSterlin; End;
if CmbKur.Text = 'EURO'    Then begin TmpKur:= AlisEuro ;    TmpKur2:=SatisEuro; End;
if CmbKur.Text = 'DOLLAR'  Then begin TmpKur:= AlisDolar ;   TmpKur2:=SatisDolar; End;

qry2.Close;
qry2.SQL.Clear;
qry2.SQL.Add('Select id from kur where Tarih=:Tarih and parabirimi=:parabirimi ');
Qry2.Parameters.ParamByName('tarih').Value :=
IntToStr(YearOf(Date))+'-'+IntToStr(MonthOf(Date))+'-'+IntToStr(DayOf(Date));
Qry2.Parameters.ParamByName('parabirimi').Value := CmbKur.Text     ;
qry2.Prepared;
qry2.open;

if qry2.RecordCount = 0  Then begin
TmpSql:='insert into Kur (tarih,parabirimi,alis,satis) Values (:tarih,:parabirimi,:alis,:satis)';
qry1.Close;
qry1.SQL.Clear;
qry1.SQL.Add(TmpSql);
Qry1.Parameters.ParamByName('tarih').Value :=
IntToStr(YearOf(Date))+'-'+IntToStr(MonthOf(Date))+'-'+IntToStr(DayOf(Date));
Qry1.Parameters.ParamByName('parabirimi').Value := CmbKur.Text     ;
Qry1.Parameters.ParamByName('alis').Value       := TmpKur  ;
Qry1.Parameters.ParamByName('satis').Value      := TmpKur2 ;
qry1.Prepared;
qry1.ExecSQL;
end
Else begin
TmpSql:='Update Kur Set tarih=:tarih,parabirimi=:parabirimi,alis=:alis,satis=:satis where id=:id ';
qry1.Close;
qry1.SQL.Clear;
qry1.SQL.Add(TmpSql);
Qry1.Parameters.ParamByName('tarih').Value :=
IntToStr(YearOf(Date))+'-'+IntToStr(MonthOf(Date))+'-'+IntToStr(DayOf(Date));
Qry1.Parameters.ParamByName('parabirimi').Value := CmbKur.Text     ;
Qry1.Parameters.ParamByName('alis').Value       := TmpKur  ;
Qry1.Parameters.ParamByName('satis').Value      := TmpKur2 ;
Qry1.Parameters.ParamByName('id').Value         := Qry2.fieldbyname('id').asstring     ;
qry1.Prepared;
qry1.ExecSQL;
end;

end;

//////////////////////////////////////////////////////////////////////////////



EXCEPT
//MsgUyari('Döviz Kurlarýna Eriþilemiyor, Lütfen internet baðlantýnýzý kontrol ediniz ...') ;
MemDoviz.Text := 'Can Not Reach The Currency Information, Please Check Your Internet Connection ...' ;
END;

end;


procedure TFrmMenux.CreateParams(var Params: TCreateParams);
begin
 inherited CreateParams(Params);
  Params.ExStyle   := Params.ExStyle or WS_EX_APPWINDOW;
  Params.WndParent := GetDesktopWindow;
end;

function TFrmMenux.DownloadFile(SourceFile, DestFile: string): Boolean;
begin
 try
    Result := UrlDownloadToFile(nil, PChar(SourceFile), PChar(DestFile), 0, nil) = 0;
  except
    Result := False;
  end;
end;

procedure TFrmMenux.FormClose(Sender: TObject; var Action: TCloseAction);
begin
Application.Terminate;
end;

procedure TFrmMenux.ImgTimeTableClick(Sender: TObject);
begin
ProgramKullanmaDurumu:=ProgramKullanmaDurumu+1;

if  assigned(FrmTimeTable) then begin
if (FrmTimeTable.WindowState = wsMinimized ) Then FrmTimeTable.WindowState := wsNormal  ;
FrmTimeTable.BringToFront;
exit;
end;

FrmTimeTable:=TFrmTimeTable.Create(Self);
FrmTimeTable.Show;

end;

procedure TFrmMenux.ImgCarEntryClick(Sender: TObject);
begin
ProgramKullanmaDurumu:=ProgramKullanmaDurumu+1;

if  assigned(FrmCarList) then begin
if (FrmCarList.WindowState = wsMinimized ) Then FrmCarList.WindowState := wsNormal  ;
FrmCarList.BringToFront;
exit;
end;

FrmCarList:=TFrmCarList.Create(Self);
FrmCarList.Show;

end;

procedure TFrmMenux.ImgCustomerEntryClick(Sender: TObject);
begin
ProgramKullanmaDurumu:=ProgramKullanmaDurumu+1;

          {
if  assigned(FrmCustomer) then begin
if (FrmCustomer.WindowState = wsMinimized ) Then FrmCustomer.WindowState := wsNormal  ;
FrmCustomer.BringToFront;
exit;
end;
         }
FrmCustomer:=TFrmCustomer.Create(Self);
FrmCustomer.FileListBoxEx1.visible := False;
FrmCustomer.BtnDosyaSec.visible := False;
FrmCustomer.ShowModal;
FrmCustomer.Free;
end;

procedure TFrmMenux.ImgKurClick(Sender: TObject);
begin
ProgramKullanmaDurumu:=ProgramKullanmaDurumu+1;

if  assigned(FrmKur) then begin
if (FrmKur.WindowState = wsMinimized ) Then FrmKur.WindowState := wsNormal  ;
FrmKur.BringToFront;
exit;
end;

FrmKur:=TFrmKur.Create(Self);
FrmKur.Show;

end;

procedure TFrmMenux.ImgReportsClick(Sender: TObject);
begin
ProgramKullanmaDurumu:=ProgramKullanmaDurumu+1;

if  assigned(FrmReports) then begin
if (FrmReports.WindowState = wsMinimized ) Then FrmReports.WindowState := wsNormal  ;
FrmReports.BringToFront;
exit;
end;

FrmReports:=TFrmReports.Create(Self);
FrmReports.Show;

end;

procedure TFrmMenux.ImgAdminClick(Sender: TObject);
begin
ProgramKullanmaDurumu:=ProgramKullanmaDurumu+1;

if  assigned(FrmAdmin) then begin
if (FrmAdmin.WindowState = wsMinimized ) Then FrmAdmin.WindowState := wsNormal  ;
FrmAdmin.BringToFront;
exit;
end;

FrmAdmin:=TFrmAdmin.Create(Self);
FrmAdmin.Show;

end;

procedure TFrmMenux.ImgAgencyEntryClick(Sender: TObject);
begin
ProgramKullanmaDurumu:=ProgramKullanmaDurumu+1;

if  assigned(FrmAgency) then begin
if (FrmAgency.WindowState = wsMinimized ) Then FrmAgency.WindowState := wsNormal  ;
FrmAgency.BringToFront;
exit;
end;

FrmAgency:=TFrmAgency.Create(Self);
FrmAgency.Show;

end;

procedure TFrmMenux.ImgTransfersClick(Sender: TObject);
var i:integer;
begin
ProgramKullanmaDurumu:=ProgramKullanmaDurumu+1;

if  assigned(FrmTransfers) then begin
if (FrmTransfers.WindowState = wsMinimized ) Then FrmTransfers.WindowState := wsNormal  ;
FrmTransfers.BringToFront;
exit;
end;

FrmTransfers:=TFrmTransfers.Create(self);

FrmTransfers.GroupBox1.Visible := False;

FrmTransfers.DtArrivalTime.Format   := 'HH:mm';
FrmTransfers.DtDepartureTime.Format := 'HH:mm';

FrmTransfers.CmbAgency.Clear;
FrmTransfers.qry1.Close;
FrmTransfers.qry1.SQL.Clear;
FrmTransfers.qry1.SQL.Add('Select * from Agency');
FrmTransfers.qry1.open;
FrmTransfers.CmbAgency.Items.Add('') ;
for i := 0 to FrmTransfers.qry1.RecordCount -1 do begin
FrmTransfers.CmbAgency.Items.Add(FrmTransfers.qry1.FieldByName('AgencyName').AsString) ;
FrmTransfers.qry1.Next;
end;
FrmTransfers.DtArrivalDate.Date   := Date;
FrmTransfers.DtDepartureDate.Date := Date;


FrmTransfers.Show;
end;

procedure TFrmMenux.Label2Click(Sender: TObject);
begin
ProgramKullanmaDurumu:=ProgramKullanmaDurumu+1;

if  assigned(FrmCompany) then begin
if (FrmCompany.WindowState = wsMinimized ) Then FrmCompany.WindowState := wsNormal  ;
FrmCompany.BringToFront;
exit;
end;

FrmCompany:=TFrmCompany.Create(Self);
FrmCompany.Show;

end;

procedure TFrmMenux.FormShow(Sender: TObject);
begin
BtnDoviz.Click;
ProgramKullanmaDurumu:=ProgramKullanmaDurumu+1;

end;

procedure TFrmMenux.Image3Click(Sender: TObject);
begin
close;
end;

procedure TFrmMenux.Image4Click(Sender: TObject);
var dosya:string;
begin

dosya := 'c:\dosyalar\email.exe' ;
ShellExecute(Handle,
            'open',
            PChar(dosya),
             nil,
             nil,
             sw_ShowNormal);
end;

end.
