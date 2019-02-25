unit UntTimeTable;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  ExtCtrls, StdCtrls, Grids, BaseGrid, AdvGrid, Mask, Buttons,
  Dialogs,asgprev, DB, ADODB, jpeg, Menus, ComCtrls, tmsAdvGridExcel,Printers,
  AdvObj, XPMan, AdvUtil;

type
  TFrmTimeTable = class(TForm)
    Qry1: TADOQuery;
    PopupMenu1: TPopupMenu;
    Reservation1: TMenuItem;
    Copy1: TMenuItem;
    Paste1: TMenuItem;
    PageControl: TPageControl;
    TabGroups: TTabSheet;
    AdvListe: TAdvStringGrid;
    TabJobReport: TTabSheet;
    Panel1: TPanel;
    SpeedButton3: TSpeedButton;
    Label1: TLabel;
    BtnList: TSpeedButton;
    Label2: TLabel;
    CmbColWidth: TComboBox;
    CmbColWidth2: TComboBox;
    Panel9: TPanel;
    SpeedButton4: TSpeedButton;
    Label16: TLabel;
    BtnList8: TSpeedButton;
    SaveDialog1: TSaveDialog;
    AdvListe8: TAdvStringGrid;
    Panel10: TPanel;
    RbGroup1: TRadioButton;
    RbGroup2: TRadioButton;
    RbGroup3: TRadioButton;
    RbGroup4: TRadioButton;
    RbGroup5: TRadioButton;
    RbGroup6: TRadioButton;
    RbEmptyCars: TRadioButton;
    Dt81: TDateTimePicker;
    Dt1: TDateTimePicker;
    Dt2: TDateTimePicker;
    SpeedButton2: TSpeedButton;
    AdvGridExcelIO1: TAdvGridExcelIO;
    TabSheet1: TTabSheet;
    Panel2: TPanel;
    AdvListe2: TAdvStringGrid;
    AdvPreview: TAdvPreviewDialog;
    SpeedButton8: TSpeedButton;
    RbGroup7: TRadioButton;
    CmbCustName: TComboBox;
    CmbCustSurname: TComboBox;
    ChkCust: TCheckBox;
    XPManifest1: TXPManifest;
    qry2: TADOQuery;
    SpeedButton5: TSpeedButton;
    ChkDate: TCheckBox;
    DtTransfer: TDateTimePicker;
    SpeedButton1: TSpeedButton;
    SpeedButton7: TSpeedButton;
    Button1: TButton;
    Renklendirme1: TMenuItem;
    CarFontColor1: TMenuItem;
    cArBackColor1: TMenuItem;
    ColorDialog1: TColorDialog;
    ChkCar: TCheckBox;
    CmbCarKriter: TComboBox;
    TxtCarKriter: TEdit;
    Button2: TButton;
    Image1: TImage;
    Label4: TLabel;
    cmbDriver: TComboBox;
    ChkDriver: TCheckBox;
    cmbPaidTo: TComboBox;
    ChkPaidTo: TCheckBox;
    CmbAgency: TComboBox;
    ChkAgency: TCheckBox;
    DtToDate: TDateTimePicker;
    ChkToDate: TCheckBox;
    DtFromDate: TDateTimePicker;
    ChkFromDate: TCheckBox;
    ChkPrice: TCheckBox;
    Uzatma1: TMenuItem;
    Button3: TButton;
    DataSource1: TDataSource;
    procedure btnKapatClick(Sender: TObject);
    procedure AdvListeCanEditCell(Sender: TObject; ARow, ACol: Integer;
      var CanEdit: Boolean);
    procedure AdvKriterCanEditCell(Sender: TObject; ARow, ACol: Integer;
      var CanEdit: Boolean);
    procedure SpeedButton10Click(Sender: TObject);
    procedure BtnListClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure SpeedButton3Click(Sender: TObject);
    procedure AdvStringGrid3OleDrag(Sender: TObject; ARow, ACol: Integer;
      data: String; var Allow: Boolean);
    procedure FormShow(Sender: TObject);
    procedure Reservation1Click(Sender: TObject);
    procedure AdvListeSelectionChanged(Sender: TObject; ALeft, ATop,
      ARight, ABottom: Integer);
    procedure CmbColWidthCange(Sender: TObject);
    procedure Copy1Click(Sender: TObject);
    procedure Paste1Click(Sender: TObject);
    procedure BtnList8Click(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure AdvListe8CanEditCell(Sender: TObject; ARow, ACol: Integer;
      var CanEdit: Boolean);
    procedure Image1Click(Sender: TObject);
    procedure SpeedButton5Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton7Click(Sender: TObject);
    procedure SpeedButton8Click(Sender: TObject);
    procedure AdvListe8GetAlignment(Sender: TObject; ARow, ACol: Integer;
      var HAlign: TAlignment; var VAlign: TVAlignment);
    procedure PageControlChange(Sender: TObject);
    procedure ChkFromDateClick(Sender: TObject);
    procedure ChkToDateClick(Sender: TObject);
    procedure ChkDateClick(Sender: TObject);
    procedure CmbCustNameChange(Sender: TObject);
    procedure CmbCustSurnameChange(Sender: TObject);
    procedure AdvListeGetAlignment(Sender: TObject; ARow, ACol: Integer;
      var HAlign: TAlignment; var VAlign: TVAlignment);
    procedure Button1Click(Sender: TObject);
    procedure AdvListeGridHint(Sender: TObject; ARow, ACol: Integer;
      var hintstr: string);
    procedure CarFontColor1Click(Sender: TObject);
    procedure cArBackColor1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Uzatma1Click(Sender: TObject);
    procedure AdvListe2GetAlignment(Sender: TObject; ARow, ACol: Integer;
      var HAlign: TAlignment; var VAlign: TVAlignment);
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
  public
    PubRnkRezervasyon,PubRnkKiralama,PubRnkServisler:TColor;
    PubGridLeft,PubGridRight,PubGridTop:integer;
    TmpPubGridLeft,TmpPubGridRight,TmpPubGridTop:integer;
    TmpPubBirakilacakTarih,TmpPubBirakilacakSaat,TmpPubAlinacakTarih,TmpPubAlinacakSaat:TDateTime;
    procedure CreateParams(var Params: TCreateParams); override;
    Procedure Renk();
    Procedure ArrivalBaslik;
   Function DepartureBaslik (rr:integer):String;
    { Public declarations }
  end;

var
  FrmTimeTable: TFrmTimeTable;

implementation

uses Math, DateUtils, UntGlobal, UntDm, UntReservation2, StrUtils, UntTransfers,
  UntProjectGlobal, UntReports;






{$R *.dfm}

procedure TFrmTimeTable.btnKapatClick(Sender: TObject);
begin
close;
end;

procedure TFrmTimeTable.AdvListe2GetAlignment(Sender: TObject; ARow,
  ACol: Integer; var HAlign: TAlignment; var VAlign: TVAlignment);
begin
if ACol = 7 then HAlign := taRightJustify;

end;

procedure TFrmTimeTable.AdvListe8CanEditCell(Sender: TObject; ARow,
  ACol: Integer; var CanEdit: Boolean);
begin
CanEdit :=False;
if Acol in [0,1,2,3,4,5,6,7,8,9,10] then CanEdit := True;

end;

procedure TFrmTimeTable.AdvListe8GetAlignment(Sender: TObject; ARow,
  ACol: Integer; var HAlign: TAlignment; var VAlign: TVAlignment);
begin
//if acol in [3,4,5,6] then HAlign := taRightJustify ;
if acol in [12,13,14,15] then begin HAlign := taCenter ; VAlign := vtacenter ; end;
end;

procedure TFrmTimeTable.AdvListeCanEditCell(Sender: TObject; ARow,
  ACol: Integer; var CanEdit: Boolean);
begin
CanEdit :=False;
end;
procedure TFrmTimeTable.AdvKriterCanEditCell(Sender: TObject;
  ARow, ACol: Integer; var CanEdit: Boolean);
begin
CanEdit := false;
end;




procedure TFrmTimeTable.Renk;
begin

end;

procedure TFrmTimeTable.SpeedButton10Click(Sender: TObject);
begin
self.Close;
end;

procedure TFrmTimeTable.SpeedButton1Click(Sender: TObject);
begin
AdvListe2.PrintSettings.TitleLines.Clear;
AdvListe2.PrintSettings.TitleLines.Add('TRANSFER REPORT ('+DateToStr(DtTransfer.Date)+')' );
AdvListe2.PrintSettings.TitleLines.Add('');

AdvPreview.Grid := AdvListe2 ;
AdvPreview.Execute ;
end;

procedure TFrmTimeTable.SpeedButton2Click(Sender: TObject);
begin
ProgramKullanmaDurumu:=ProgramKullanmaDurumu+1;

if SaveDialog1.Execute then
  if SaveDialog1.FileName<>'' then
     //AdvGridExcelIO1.XLSExport(SaveDialog1.FileName,'Tablo')
    AdvListe8.SaveToXLSSheet(SaveDialog1.FileName+'.xls','Tablo');
end;







procedure TFrmTimeTable.BtnListClick(Sender: TObject);
var TmpSayi,i,z,x,y,e,TmpSayim2,TmpBirakilacak,TmpAlinacak,renk,TmpUzunluk:integer;
TmpSql,TmpGroup,TmpDeliverTime,TmpCollectTime,TmpCarRegNo:String;
TmpDays:integer;
TmpBirakilacakTarih,TmpAlacakTarih:TDateTime;

const
      Aylar: array [0..11] of string=
        ('January','February','March','April','May','June','July','August',
         'September','October','November','December');
      Hafta: array [0..6] of string= ('PT','SL','ÇR','PR','CU','CT','PZ');
begin

if ChkCust.Checked=True then begin
TmpSql :=  'Select BirakilacakTarih,CarRegNo from reservation where Name=:Name and Surname=:Surname and Durum<>''Deleted''  order by BirakilacakTarih desc ';
qry1.Close;
qry1.SQL.Clear;
qry1.SQL.Add(TmpSql);
Qry1.Parameters.ParamByName('Name').Value    := CmbCustName.Text ;
Qry1.Parameters.ParamByName('Surname').Value := CmbCustSurname.Text ;
qry1.Prepared;
qry1.Open;

Dt1.Date :=  Qry1.FieldByName('BirakilacakTarih').AsDateTime - 5;
Dt2.Date :=  Qry1.FieldByName('BirakilacakTarih').AsDateTime + 30;
TmpCarRegNo := Qry1.FieldByName('CarRegNo').AsString ;
end;


TmpSayim2:=0;
renk:=0;
x:=0;
y:=1;

if Dt1.Date > Dt2.Date Then Begin
MsgUyari('First date must be smaller or equal to second date ...');
exit;
End;


 AdvListe.ClearCols(0,AdvListe.ColCount-1);
 AdvListe.AddRow;
 AdvListe.ClearRows(0,AdvListe.RowCount-1);
 AdvListe.RowCount :=4;
 AdvListe.ColCount :=2;
 AdvListe.RowHeights[2] := 18;

//////////////////////////////////////////////////////////////////////
if RbGroup1.Checked = True Then  TmpGroup := 'Group 1';
if RbGroup2.Checked = True Then  TmpGroup := 'Group 2';
if RbGroup3.Checked = True Then  TmpGroup := 'Group 3';
if RbGroup4.Checked = True Then  TmpGroup := 'Group 4';
if RbGroup5.Checked = True Then  TmpGroup := 'Group 5';
if RbGroup6.Checked = True Then  TmpGroup := 'Group 6';
if RbGroup7.Checked = True Then  TmpGroup := 'Group 7';

TmpSql :=  'Select Model,RegNo,id,Type,Color,FontColor from car where Sold <> 1 and Grup=:Grup ' ;

if ChkCar.Checked=True then begin
if CmbCarKriter.Text='Car Reg No' then TmpSql:=TmpSql+ ' and RegNo like :CarKriter ';
if CmbCarKriter.Text='Car Model' then  TmpSql:=TmpSql+ ' and Model like :CarKriter ';
end;

if ChkCust.Checked=True then
TmpSql:=TmpSql+ ' and RegNo = '''+TmpCarRegNo+''' ';


TmpSql:=TmpSql+ ' order by sirano';

qry1.Close;
qry1.SQL.Clear;
qry1.SQL.Add(TmpSql);
Qry1.Parameters.ParamByName('Grup').Value :=TmpGroup;
if ChkCar.Checked=True then
Qry1.Parameters.ParamByName('CarKriter').Value := TxtCarKriter.Text+'%';
qry1.Prepared;
qry1.Open;

TmpSayim2 := TmpSayi*qry1.RecordCount;

AdvListe.RowCount := qry1.RecordCount + 3 ;

for i:=1 to qry1.RecordCount do begin
AdvListe.Cells[0,i+2] :=  Qry1.FieldByName('Model').AsString+ ' ('+LeftStr(Qry1.FieldByName('Type').AsString,1)+') '+
                          Qry1.FieldByName('RegNo').AsString+'                                                              '+
                          Qry1.FieldByName('id').AsString;

AdvListe.Colors[0,i+2] := StringToColor(Qry1.FieldByName('Color').AsString) ;

if Qry1.FieldByName('FontColor').AsString = '' then  AdvListe.FontColors[0,i+2] := clBlack
Else AdvListe.FontColors[0,i+2] := StringToColor(Qry1.FieldByName('FontColor').AsString);

AdvListe.RowHeights[i+2] := 40;
qry1.Next;
end;

//////////////////////////////////////////////////////////////////////
TmpSayi := (DaysBetween(Dt1.Date,Dt2.Date)*2) + 2 ;
AdvListe.ColCount :=  TmpSayi + 1;

for i:=1 to TmpSayi do  begin
    AdvListe.ColWidths[i]:= StrToInt(CmbColWidth2.Text);
    AdvListe.Cells[i,0]:= Aylar[strtoint(currtostr(monthof(Dt1.Date+x)))-1]+'   '+currtostr(YearOf(Dt1.Date+x));
    AdvListe.Cells[i,AdvListe.RowCount]:= DateToStr(Dt1.Date+x);
    if (i mod 2 )=0 Then begin
    if  (monthof(Dt1.Date+x)<>monthof(Dt1.Date+x+1)) or (i=TmpSayi)  Then begin
       AdvListe.MergeCells(y,0,i-y+1,1) ;
       y:=i+1;
    end;
    AdvListe.MergeCells(i-1,1,2,1) ;
    AdvListe.Cells[i,1]:= currtostr(DayOf(Dt1.Date+x));
    AdvListe.MergeCells(i-1,2,2,1) ;
    AdvListe.Cells[i,2]:= Hafta[StrToInt(CurrToStr(DayOfTheWeek(Dt1.Date+x)))-1];

    if AdvListe.Cells[i,1]='1' then
    for e:=1 to AdvListe.RowCount-1 do  AdvListe.Colors[i-1,e] := clSilver ;

    if Dt1.Date+x=Date then
    for e:=1 to AdvListe.RowCount-1 do  AdvListe.Colors[i-1,e] := clBlue ;

    x:=x+1;
    end;
end;
////////////////////////////////////////////////////////////////////////////////////
for i:=3 to AdvListe.RowCount-1 do begin

TmpSayi:=0;
x:=0;
z:=0;
y:=0;
TmpSayim2:=0;
TmpBirakilacak:=0;
TmpAlinacak:=0;
TmpSql:='';
TmpGroup:='';
TmpDeliverTime:='';
TmpCollectTime:='';


TmpSql := 'Select BirakilacakTarih,AlinacakTarih,DeliverTimeChecked,BirakilacakSaat,Name,Surname,birakilacakYer,AlinacakYer,'+
'CollectTimeChecked,alinacakSaat,id,ContactNumber,Notes,LowSeasonDays,MidSeasonDays,HighSeasonDays,ExtensionDays '+
'from reservation where Durum<>''Deleted'' and Carid=:Carid and AlinacakTarih>=:Dt1 and BirakilacakTarih<=:Dt2   ' ;
if ChkCust.Checked = True Then
TmpSql := TmpSql +  ' and Name=:Name and Surname=:Surname' ;
TmpSql := TmpSql+  ' order by BirakilacakTarih,birakilacaksaat' ;

qry1.Close;
qry1.SQL.Clear;
qry1.SQL.Add(TmpSql);
Qry1.Parameters.ParamByName('Carid').Value := StrToInt(RightStr(AdvListe.Cells[0,i],15)) ;
Qry1.Parameters.ParamByName('Dt1').Value := IntToStr(YearOf(Dt1.Date))+'-'+IntToStr(MonthOf(Dt1.Date))+'-'+IntToStr(DayOf(Dt1.Date));
Qry1.Parameters.ParamByName('Dt2').Value := IntToStr(YearOf(Dt2.Date))+'-'+IntToStr(MonthOf(Dt2.Date))+'-'+IntToStr(DayOf(Dt2.Date));
if ChkCust.Checked = True Then Begin
Qry1.Parameters.ParamByName('Name').Value    := CmbCustName.Text ;
Qry1.Parameters.ParamByName('Surname').Value := CmbCustSurname.Text ;
End;
Qry1.Prepared;
qry1.Open;

if Qry1.RecordCount <> 0 Then Begin
for z:=1 to Qry1.RecordCount do begin

TmpBirakilacak:=0;
TmpAlinacak:=0;
TmpDays := Qry1.FieldByName('LowSeasonDays').AsInteger+Qry1.FieldByName('MidSeasonDays').AsInteger+Qry1.FieldByName('HighSeasonDays').AsInteger ;

for x:=1 to AdvListe.ColCount - 1 do begin
if DateToStr(Qry1.FieldByName('BirakilacakTarih').AsDateTime) = AdvListe.Cells[x,AdvListe.RowCount] then TmpBirakilacak:=x;
if DateToStr(Qry1.FieldByName('AlinacakTarih').AsDateTime)    = AdvListe.Cells[x,AdvListe.RowCount] then TmpAlinacak:=x;
end;


{
if StrToTime(Qry1.FieldByName('BirakilacakSaat').Asstring)<StrToTime('14:00') then
  if TmpBirakilacak<>0 Then
    TmpBirakilacak:=TmpBirakilacak-1;
}

{
TmpBirakilacakTarih :=Qry1.FieldByName('BirakilacakTarih').AsDateTime ;
Qry1.Next;
if  NOT Qry1.EOF Then
if (TmpBirakilacakTarih=Qry1.FieldByName('BirakilacakTarih').AsDateTime) and (TmpBirakilacak<>0 )then
TmpBirakilacak:=TmpBirakilacak-1;
Qry1.Prior;
}

if TmpBirakilacak=0 then TmpBirakilacak := 1 ;
if TmpAlinacak=0    then TmpAlinacak := AdvListe.ColCount - 1;

 {   en son bu kapatýldý  18.8.2018
if TmpBirakilacak=TmpAlinacak  then begin

TmpAlacakTarih := Qry1.FieldByName('AlinacakTarih').AsDateTime ;
Qry1.Next;
if (TmpAlacakTarih=Qry1.FieldByName('BirakilacakTarih').AsDateTime) then
TmpBirakilacak:=TmpBirakilacak-1;
Qry1.Prior;

end;
}

renk:=renk+1;
/////////////////// renk
if renk mod 2 = 0  then
AdvListe.Colors[TmpBirakilacak,i]:=clYellow
Else AdvListe.Colors[TmpBirakilacak,i]:=$00EACAB6 ;    //Açýk Mavi

if TmpBirakilacak<>TmpAlinacak Then
AdvListe.MergeCells(TmpBirakilacak,i,TmpAlinacak-TmpBirakilacak,1);

if Qry1.FieldByName('DeliverTimeChecked').AsString='Y' then
TmpDeliverTime:= Qry1.FieldByName('BirakilacakSaat').AsString
Else  TmpDeliverTime:= '??????';

if Qry1.FieldByName('CollectTimeChecked').AsString='Y' then
TmpCollectTime:= Qry1.FieldByName('alinacakSaat').AsString
Else TmpCollectTime:=  '??????';

TmpUzunluk := TmpAlinacak -  TmpBirakilacak  ;

if TmpUzunluk>5 Then AdvListe.FontSizes[TmpBirakilacak,i] := 8
Else AdvListe.FontSizes[TmpBirakilacak,i] := 5 ;

AdvListe.Cells[TmpBirakilacak,i]:=
Qry1.FieldByName('BirakilacakTarih').AsString+' '+LeftStr(TmpDeliverTime,LEngth(TmpDeliverTime)-3) +' ('+

Qry1.FieldByName('Name').AsString+'  '+Qry1.FieldByName('Surname').AsString+' - '+LeftStr(Qry1.FieldByName('birakilacakYer').AsString,4)+
' - '+LeftStr(Qry1.FieldByName('AlinacakYer').AsString,4)+' - '+intToStr(TmpDays)+' Days'+
Qry1.FieldByName('ContactNumber').AsString+'  '+Qry1.FieldByName('Notes').AsString+') '+

Qry1.FieldByName('alinacakTarih').AsString+' '+LeftStr(TmpCollectTime,LEngth(TmpCollectTime)-3)+
'                    '+Qry1.FieldByName('id').AsString;

if Qry1.FieldByName('alinacakTarih').AsDateTime = Date then AdvListe.Colors[TmpBirakilacak,i]:=ClRed ;
if Qry1.FieldByName('BirakilacakTarih').AsDateTime = Date then AdvListe.Colors[TmpBirakilacak,i]:=$0080FF80 ; //Açýk Yeþil
if Qry1.FieldByName('ExtensionDays').AsCurrency <> 0 then AdvListe.Colors[TmpBirakilacak,i]:=clYellow ;

qry1.Next;
end;
end;

end;

end;






procedure TFrmTimeTable.Button1Click(Sender: TObject);
var TmpSayi,i,z,x,y,e,TmpSayim2,TmpBirakilacak,TmpAlinacak,renk,TmpUzunluk:integer;
TmpSql,TmpGroup,TmpDeliverTime,TmpCollectTime:String;
TmpDays:integer;


const
      Aylar: array [0..11] of string=
        ('January','February','March','April','May','June','July','August',
         'September','October','November','December');
      Hafta: array [0..6] of string= ('PT','SL','ÇR','PR','CU','CT','PZ');
begin

TmpSayim2:=0;
renk:=0;
x:=0;
y:=1;

if Dt1.Date > Dt2.Date Then Begin
MsgUyari('First date must be smaller or equal to second date ...');
exit;
End;


 AdvListe.ClearCols(0,AdvListe.ColCount-1);
 AdvListe.AddRow;
 AdvListe.ClearRows(0,AdvListe.RowCount-1);
 AdvListe.RowCount :=4;
 AdvListe.ColCount :=2;
 AdvListe.RowHeights[2] := 18;

//////////////////////////////////////////////////////////////////////
if RbGroup1.Checked = True Then  TmpGroup := 'Group 1';
if RbGroup2.Checked = True Then  TmpGroup := 'Group 2';
if RbGroup3.Checked = True Then  TmpGroup := 'Group 3';
if RbGroup4.Checked = True Then  TmpGroup := 'Group 4';
if RbGroup5.Checked = True Then  TmpGroup := 'Group 5';
if RbGroup6.Checked = True Then  TmpGroup := 'Group 6';
if RbGroup7.Checked = True Then  TmpGroup := 'Group 7';

qry1.Close;
qry1.SQL.Clear;
qry1.SQL.Add('Select * from car where Sold <> 1 and Grup=:Grup order by sirano');
Qry1.Parameters.ParamByName('Grup').Value :=TmpGroup;
qry1.Prepared;
qry1.Open;

TmpSayim2 := TmpSayi*qry1.RecordCount;

AdvListe.RowCount := qry1.RecordCount + 3 ;

for i:=1 to qry1.RecordCount do begin
AdvListe.Cells[0,i+2] :=  Qry1.FieldByName('Model').AsString+ ' ('+LeftStr(Qry1.FieldByName('Type').AsString,1)+') '+
                          Qry1.FieldByName('RegNo').AsString+'                                                              '+
                          Qry1.FieldByName('id').AsString;

AdvListe.Colors[0,i+2] := StringToColor(Qry1.FieldByName('Color').AsString) ;

if Qry1.FieldByName('FontColor').AsString = '' then  AdvListe.FontColors[0,i+2] := clBlack
Else AdvListe.FontColors[0,i+2] := StringToColor(Qry1.FieldByName('FontColor').AsString);

AdvListe.RowHeights[i+2] := 40;
qry1.Next;
end;

//////////////////////////////////////////////////////////////////////
TmpSayi := (DaysBetween(Dt1.Date,Dt2.Date)*2) + 2 ;
AdvListe.ColCount :=  TmpSayi + 1;

for i:=1 to TmpSayi do  begin
    AdvListe.ColWidths[i]:= StrToInt(CmbColWidth2.Text);
    AdvListe.Cells[i,0]:= Aylar[strtoint(currtostr(monthof(Dt1.Date+x)))-1]+'   '+currtostr(YearOf(Dt1.Date+x));
    AdvListe.Cells[i,AdvListe.RowCount]:= DateToStr(Dt1.Date+x);
    if (i mod 2 )=0 Then begin
    if  (monthof(Dt1.Date+x)<>monthof(Dt1.Date+x+1)) or (i=TmpSayi)  Then begin
       AdvListe.MergeCells(y,0,i-y+1,1) ;
       y:=i+1;
    end;
    AdvListe.MergeCells(i-1,1,2,1) ;
    AdvListe.Cells[i,1]:= currtostr(DayOf(Dt1.Date+x));
    AdvListe.MergeCells(i-1,2,2,1) ;
    AdvListe.Cells[i,2]:= Hafta[StrToInt(CurrToStr(DayOfTheWeek(Dt1.Date+x)))-1];

    if AdvListe.Cells[i,1]='1' then
    for e:=1 to AdvListe.RowCount-1 do  AdvListe.Colors[i-1,e] := clSilver ;

    x:=x+1;
    end;
end;
////////////////////////////////////////////////////////////////////////////////////

for i:=3 to AdvListe.RowCount-1 do begin

TmpSayi:=0;
x:=0;
z:=0;
y:=0;
TmpSayim2:=0;
TmpBirakilacak:=0;
TmpAlinacak:=0;
TmpSql:='';
TmpGroup:='';
TmpDeliverTime:='';
TmpCollectTime:='';

TmpSql := 'Select BirakilacakTarih,AlinacakTarih,DeliverTimeChecked,BirakilacakSaat,Name,Surname,birakilacakYer,AlinacakYer,'+
'CollectTimeChecked,alinacakSaat,id,ContactNumber,Notes '+
'from reservation where Durum<>''Deleted'' and Carid=:Carid and AlinacakTarih>=:Dt1 and BirakilacakTarih<=:Dt2  ' ;
if ChkCust.Checked = True Then
TmpSql := TmpSql +  ' and Name=:Name and Surname=:Surname' ;
TmpSql := TmpSql+  ' order by BirakilacakTarih' ;

qry1.Close;
qry1.SQL.Clear;
qry1.SQL.Add(TmpSql);
Qry1.Parameters.ParamByName('Carid').Value := StrToInt(RightStr(AdvListe.Cells[0,i],15)) ;
Qry1.Parameters.ParamByName('Dt1').Value := IntToStr(YearOf(Dt1.Date))+'-'+IntToStr(MonthOf(Dt1.Date))+'-'+IntToStr(DayOf(Dt1.Date));
Qry1.Parameters.ParamByName('Dt2').Value := IntToStr(YearOf(Dt2.Date))+'-'+IntToStr(MonthOf(Dt2.Date))+'-'+IntToStr(DayOf(Dt2.Date));
if ChkCust.Checked = True Then Begin
Qry1.Parameters.ParamByName('Name').Value    := CmbCustName.Text ;
Qry1.Parameters.ParamByName('Surname').Value := CmbCustSurname.Text ;
End;
Qry1.Prepared;
qry1.Open;

if Qry1.RecordCount <> 0 Then Begin

for z:=1 to Qry1.RecordCount do begin

TmpDays := DaysBetween(Qry1.FieldByName('BirakilacakTarih').AsDateTime,Qry1.FieldByName('AlinacakTarih').AsDateTime) ;
for x:=1 to AdvListe.ColCount - 1 do begin
if DateToStr(Qry1.FieldByName('BirakilacakTarih').AsDateTime) = AdvListe.Cells[x,AdvListe.RowCount] then TmpBirakilacak:=x;
if DateToStr(Qry1.FieldByName('AlinacakTarih').AsDateTime)    = AdvListe.Cells[x,AdvListe.RowCount] then TmpAlinacak:=x-1;
end;

if TmpBirakilacak=0 then TmpBirakilacak := 1 ;
if TmpAlinacak=0    then TmpAlinacak := AdvListe.ColCount - 1;

renk:=renk+1;
/////////////////// renk
if renk mod 2 = 0  then
AdvListe.Colors[TmpBirakilacak,i]:=clYellow
Else AdvListe.Colors[TmpBirakilacak,i]:=$00EACAB6 ;


//AdvListe.MergeCells(TmpBirakilacak,i,TmpAlinacak-TmpBirakilacak,1);

AdvListe.MergeCells(TmpBirakilacak,i,2,1);

if Qry1.FieldByName('DeliverTimeChecked').AsString='Y' then
TmpDeliverTime:= Qry1.FieldByName('BirakilacakSaat').AsString
Else  TmpDeliverTime:= '??????';

AdvListe.FontSizes[TmpBirakilacak,i] := 7;
AdvListe.Cells[TmpBirakilacak,i]:=
Qry1.FieldByName('BirakilacakTarih').AsString+' '+LeftStr(TmpDeliverTime,LEngth(TmpDeliverTime)-3) +
'                    '+Qry1.FieldByName('id').AsString;;

if  (0<((TmpAlinacak-1)-(TmpBirakilacak+2))) or (TmpAlinacak = AdvListe.ColCount - 1)  then begin

TmpUzunluk :=(TmpAlinacak-1)-(TmpBirakilacak+2) ;
AdvListe.MergeCells(TmpBirakilacak+2,i,TmpUzunluk,1);


 if TmpUzunluk>5 Then AdvListe.FontSizes[TmpBirakilacak+2,i] := 8
 Else AdvListe.FontSizes[TmpBirakilacak+2,i] := 5 ;

AdvListe.Colors[TmpBirakilacak+2,i]:= $00AAF0F2;
AdvListe.Cells[TmpBirakilacak+2,i]:=
Qry1.FieldByName('Name').AsString+'  '+Qry1.FieldByName('Surname').AsString+' - '+LeftStr(Qry1.FieldByName('birakilacakYer').AsString,4)+
' - '+LeftStr(Qry1.FieldByName('AlinacakYer').AsString,4)+' - '+intToStr(TmpDays)+' Days'+
Qry1.FieldByName('ContactNumber').AsString+'  '+Qry1.FieldByName('Notes').AsString+
'                    '+Qry1.FieldByName('id').AsString;
end;

if Qry1.FieldByName('CollectTimeChecked').AsString='Y' then
TmpCollectTime:= Qry1.FieldByName('alinacakSaat').AsString
Else TmpCollectTime:=  '??????';

if (TmpBirakilacak+2)<(TmpAlinacak-1) then begin
AdvListe.MergeCells(TmpAlinacak-1,i,2,1);
/////////////////// renk
if renk mod 2 = 0  then
AdvListe.Colors[TmpAlinacak-1,i]:=clYellow
Else AdvListe.Colors[TmpAlinacak-1,i]:=$00EACAB6;

AdvListe.FontSizes[TmpAlinacak-1,i] := 7;
AdvListe.Cells[TmpAlinacak-1,i]:=
Qry1.FieldByName('alinacakTarih').AsString+' '+LeftStr(TmpCollectTime,LEngth(TmpCollectTime)-3)+
'                    '+Qry1.FieldByName('id').AsString;
end;

qry1.Next;
end;
end;
end;

end;


procedure TFrmTimeTable.Button2Click(Sender: TObject);
var i,rr:integer;
TmpSql:String;
const
      Gunler: array [0..6] of string=
        ('MONDAY','TUESDAY','WEDNESDAY','THURSDAY','FRIDAY','SATURDAY','SUNDAY');

begin
ProgramKullanmaDurumu := ProgramKullanmaDurumu+1;

AdvListe2.UnHideColumnsAll;

AdvListe2.ClearCols(0,AdvListe2.ColCount-1);
AdvListe2.ClearRows(0,AdvListe2.RowCount-1);
AdvListe2.RowCount :=3;

AdvListe2.ColWidths[0]:=60;
AdvListe2.ColWidths[1]:=40;
AdvListe2.ColWidths[2]:=60;
AdvListe2.ColWidths[3]:=180;
AdvListe2.ColWidths[4]:=180;
AdvListe2.ColWidths[5]:=50;
AdvListe2.ColWidths[6]:=60;
AdvListe2.ColWidths[7]:=70;
AdvListe2.ColWidths[8]:=120;
AdvListe2.ColWidths[9]:=30;
AdvListe2.ColWidths[10]:=45;
AdvListe2.ColWidths[11]:=100;
AdvListe2.ColWidths[12]:=100;
AdvListe2.ColWidths[13]:=100;
AdvListe2.ColWidths[14]:=100;
rr:=2;

AdvListe2.Cells[0,1]:=  'ARRIVAL' ;
AdvListe2.FontSizes[0,1] := 14 ;
AdvListe2.MergeCells(0,1,12,1) ;

AdvListe2.RowColor[2]:=clLtGray;
AdvListe2.Cells[0,2] :='DATE';
AdvListe2.Cells[1,2] :='TIME';
AdvListe2.Cells[2,2] :='DRIVER';
AdvListe2.Cells[3,2] :='COLLECT FROM';
AdvListe2.Cells[4,2] :='DESTINATION';
AdvListe2.Cells[5,2] :='PAX';
AdvListe2.Cells[6,2] :='FLIGHT NO';
AdvListe2.Cells[7,2] :='PRICE';
AdvListe2.Cells[8,2] :='NAME';
AdvListe2.Cells[9,2] :='BABY SEAT';
AdvListe2.FontSizes[9,2] := 6 ;
AdvListe2.Cells[10,2] :='BOOSTER SEAT';
AdvListe2.FontSizes[10,2] := 6 ;
AdvListe2.Cells[11,2] :='NOTE';
AdvListe2.Cells[12,2] :='TEL NO';
AdvListe2.Cells[13,2] :='AGENCY';
AdvListe2.Cells[14,2] :='CAR';

TmpSql := 'Select * from Transfer where CheckedArrival =''Y'' ' ;

if ChkAgency.Checked = True  then
TmpSql:=TmpSql + ' and AgencyName =:AgencyName ';
if ChkFromDate.Checked = True  then
TmpSql:=TmpSql + ' and ArrivalDate >= :FromDate ';
if ChkToDate.Checked = True  then
TmpSql:=TmpSql + ' and ArrivalDate <= :ToDate ';
if ChkDate.Checked = True  then
TmpSql:=TmpSql + ' and ArrivalDate = :ArrivalDate  ' ;
if ChkDriver.Checked = True then
TmpSql:=TmpSql + ' and Driver like :Driver ' ;
TmpSql:=TmpSql + ' order by ArrivalDate, ArrivalTime ' ;
qry1.Close;
qry1.SQL.Clear;
qry1.SQL.Add(TmpSql);

if ChkAgency.Checked = True  then
qry1.Parameters.ParamByName('AgencyName').Value := CmbAgency.Text ;

if (ChkFromDate.Checked = True) then
Qry1.Parameters.ParamByName('FromDate').Value :=
IntToStr(YearOf(DtFromDate.Date))+'-'+IntToStr(MonthOf(DtFromDate.Date))+'-'+IntToStr(DayOf(DtFromDate.Date));
if (ChkToDate.Checked = True) then
Qry1.Parameters.ParamByName('ToDate').Value :=
IntToStr(YearOf(DtToDate.Date))+'-'+IntToStr(MonthOf(DtToDate.Date))+'-'+IntToStr(DayOf(DtToDate.Date));
if ChkDate.Checked = True  then
Qry1.Parameters.ParamByName('ArrivalDate').Value :=
IntToStr(YearOf(DtTransfer.Date))+'-'+IntToStr(MonthOf(DtTransfer.Date))+'-'+IntToStr(DayOf(DtTransfer.Date));

if ChkDriver.Checked = True then
qry1.Parameters.ParamByName('Driver').Value := cmbDriver.Text+'%';
qry1.Prepared;
qry1.Open;

if qry1.RecordCount <> 0 Then Begin
for i:=1 to Qry1.RecordCount do begin

if TimeToStr(TimeOf(Qry1.FieldByName('ArrivalTime').AsdateTime)) <> '00:00:00' then Begin
AdvListe2.AddRow;
rr:=rr+1;

AdvListe2.Cells[0,rr] := Qry1.FieldByName('ArrivalDate').AsString ;
AdvListe2.Cells[1,rr] := FormatDateTime('t',Qry1.FieldByName('ArrivalTime').AsdateTime);
AdvListe2.Cells[2,rr] := Qry1.FieldByName('Driver').AsString ;
AdvListe2.Cells[3,rr] := Qry1.FieldByName('ArrivalCollectFrom').AsString ;
AdvListe2.FontSizes[3,rr]:=7;
AdvListe2.Cells[4,rr] := Qry1.FieldByName('ArrivalDestination').AsString ;
AdvListe2.FontSizes[4,rr]:=7;
AdvListe2.Cells[5,rr] := Qry1.FieldByName('ArrivalPax').AsString;
AdvListe2.FontSizes[5,rr]:=7;
AdvListe2.Cells[6,rr] := Qry1.FieldByName('ArrivalFlightNo').AsString;
AdvListe2.FontSizes[6,rr]:=7;
AdvListe2.Cells[7,rr] := Qry1.FieldByName('ArrivalPrice').AsString +' £ ,Paid:'+Qry1.FieldByName('ArrivalPaid').AsString+ ' ,'+Qry1.FieldByName('ArrivalPaidTo').AsString;
if (Qry1.FieldByName('ArrivalPaid').AsString <> 'Y') Then  AdvListe2.RowColor[rr]:=$008C6BB8 ;
AdvListe2.FontSizes[7,rr]:=7;
AdvListe2.Cells[8,rr]  := Qry1.FieldByName('Name').AsString+'  '+Qry1.FieldByName('Surname').AsString ;
AdvListe2.Cells[9,rr]  := Qry1.FieldByName('ArrivalBabySeat').AsString ;
AdvListe2.Cells[10,rr] := Qry1.FieldByName('ArrivalBoosterSeat').AsString ;
AdvListe2.Cells[11,rr] := Qry1.FieldByName('ArrivalNotes').AsString ;
AdvListe2.Cells[12,rr] := Qry1.FieldByName('LocalNumber').AsString ;
AdvListe2.Cells[13,rr] := Qry1.FieldByName('AgencyName').AsString ;
AdvListe2.Cells[14,rr] := Qry1.FieldByName('CarRegNo').AsString+' - '+Qry1.FieldByName('CarModel').AsString ;
End;
Qry1.Next;
end;
End;

qry1.First;
if qry1.RecordCount <> 0 Then Begin
for i:=1 to Qry1.RecordCount do begin
if TimeToStr(TimeOf(Qry1.FieldByName('ArrivalTime').AsdateTime)) = '00:00:00' then Begin
AdvListe2.AddRow;
rr:=rr+1;

if (Qry1.FieldByName('ArrivalPaid').AsString <> 'Y') Then
AdvListe2.RowColor[rr]:=$008C6BB8 ;

AdvListe2.Cells[0,rr] := Qry1.FieldByName('ArrivalDate').AsString ;
AdvListe2.Cells[1,rr] := FormatDateTime('t',Qry1.FieldByName('ArrivalTime').AsdateTime);
AdvListe2.Cells[2,rr] := Qry1.FieldByName('Driver').AsString ;
AdvListe2.Cells[3,rr] := Qry1.FieldByName('ArrivalCollectFrom').AsString ;
AdvListe2.FontSizes[3,rr]:=7 ;
AdvListe2.Cells[4,rr] := Qry1.FieldByName('ArrivalDestination').AsString ;
AdvListe2.FontSizes[4,rr]:=7 ;
AdvListe2.Cells[5,rr] := Qry1.FieldByName('ArrivalPax').AsString;
AdvListe2.FontSizes[5,rr]:=7 ;
AdvListe2.Cells[6,rr] := Qry1.FieldByName('ArrivalFlightNo').AsString;
AdvListe2.FontSizes[6,rr] := 7 ;
AdvListe2.Cells[7,rr] := Qry1.FieldByName('ArrivalPrice').AsString +' £ ,Paid:'+Qry1.FieldByName('ArrivalPaid').AsString+
' ,'+Qry1.FieldByName('ArrivalPaidTo').AsString;
AdvListe2.Cells[8,rr]  := Qry1.FieldByName('Name').AsString+'  '+Qry1.FieldByName('Surname').AsString ;
AdvListe2.Cells[9,rr]  := Qry1.FieldByName('ArrivalBabySeat').AsString ;
AdvListe2.Cells[10,rr] := Qry1.FieldByName('ArrivalBoosterSeat').AsString ;
AdvListe2.Cells[11,rr] := Qry1.FieldByName('ArrivalNotes').AsString ;
AdvListe2.Cells[12,rr] := Qry1.FieldByName('LocalNumber').AsString ;
AdvListe2.Cells[13,rr] := Qry1.FieldByName('AgencyName').AsString ;
AdvListe2.Cells[14,rr] := Qry1.FieldByName('CarRegNo').AsString+' - '+Qry1.FieldByName('CarModel').AsString ;

End;
Qry1.Next;
end;
End;

AdvListe2.AddRow;
rr:=rr+1 ;

AdvListe2.Cells[0,rr]:= 'DEPARTURE' ;
AdvListe2.FontSizes[0,rr] := 14 ;
AdvListe2.MergeCells(0,rr,12,1) ;
AdvListe2.AddRow;
rr:=rr+1;
AdvListe2.RowColor[rr]:=clLtGray;
AdvListe2.Cells[0,rr] :='DATE';
AdvListe2.Cells[1,rr] :='TIME';
AdvListe2.Cells[2,rr] :='DRIVER';
AdvListe2.Cells[3,rr] :='COLLECT FROM';
AdvListe2.Cells[4,rr] :='DESTINATION';
AdvListe2.Cells[5,rr] :='PAX';
AdvListe2.Cells[6,rr] :='';
AdvListe2.Cells[7,rr] :='PRICE';
AdvListe2.Cells[8,rr] :='NAME';
AdvListe2.Cells[9,rr] :='BABY SEAT';
AdvListe2.FontSizes[9,rr] := 6 ;
AdvListe2.Cells[10,rr] :='BOOSTER SEAT';
AdvListe2.FontSizes[10,rr] := 6 ;
AdvListe2.Cells[11,rr] :='NOTE';
AdvListe2.Cells[12,rr] :='TEL NO';
AdvListe2.Cells[13,rr] :='AGENCY';
AdvListe2.Cells[14,rr] :='CAR';

TmpSql := '';

TmpSql := TmpSql + 'Select * from Transfer where CheckedDeparture = ''Y''  ' ;

if ChkAgency.Checked = True  then
TmpSql:=TmpSql + ' and AgencyName =:AgencyName ';
if ChkFromDate.Checked = True  then
TmpSql:=TmpSql + ' and DepartureDate >= :FromDate ' ;
if ChkToDate.Checked = True  then
TmpSql:=TmpSql + ' and DepartureDate <= :ToDate ' ;
if ChkDate.Checked = True  then
TmpSql:=TmpSql + ' and DepartureDate = :DepartureDate  ' ;
if ChkPaidTo.Checked = True then
TmpSql:=TmpSql + ' and PaidTo like :PaidTo ' ;
if ChkDriver.Checked = True then
TmpSql:=TmpSql + ' and Driver like :Driver ' ;
TmpSql:=TmpSql + 'order by DepartureDate,DepartureTime ' ;
qry1.Close;
qry1.SQL.Clear;
qry1.SQL.Add(TmpSql);

if ChkAgency.Checked = True  then
qry1.Parameters.ParamByName('AgencyName').Value := CmbAgency.Text ;
if ChkPaidTo.Checked = True then
qry1.Parameters.ParamByName('PaidTo').Value := cmbDriver.Text+'%';
if ChkDriver.Checked = True then
qry1.Parameters.ParamByName('Driver').Value := cmbDriver.Text+'%';
if ChkDate.Checked = True  then
Qry1.Parameters.ParamByName('DepartureDate').Value :=
IntToStr(YearOf(DtTransfer.Date))+'-'+IntToStr(MonthOf(DtTransfer.Date))+'-'+IntToStr(DayOf(DtTransfer.Date));
if (ChkFromDate.Checked = True)  then
Qry1.Parameters.ParamByName('FromDate').Value :=
IntToStr(YearOf(DtFromDate.Date))+'-'+IntToStr(MonthOf(DtFromDate.Date))+'-'+IntToStr(DayOf(DtFromDate.Date));
if (ChkToDate.Checked = True)  then
Qry1.Parameters.ParamByName('ToDate').Value :=
IntToStr(YearOf(DtToDate.Date))+'-'+IntToStr(MonthOf(DtToDate.Date))+'-'+IntToStr(DayOf(DtToDate.Date));
qry1.Prepared;
qry1.Open;

if qry1.RecordCount <> 0 Then Begin
for i:=1 to Qry1.RecordCount do begin
if TimeToStr(TimeOf(Qry1.FieldByName('DepartureTime').AsdateTime)) <> '00:00:00' Then Begin
AdvListe2.AddRow;
rr:=rr+1;

if (Qry1.FieldByName('DeparturePaid').AsString <> 'Y') Then
AdvListe2.RowColor[rr]:=$008C6BB8 ;

AdvListe2.Cells[0,rr] := Qry1.FieldByName('DepartureDate').AsString ;
AdvListe2.Cells[1,rr] := FormatDateTime('t',Qry1.FieldByName('DepartureTime').AsdateTime);
AdvListe2.Cells[2,rr] := Qry1.FieldByName('Driver').AsString ;
AdvListe2.Cells[3,rr] := Qry1.FieldByName('DepartureCollectFrom').AsString ;
AdvListe2.FontSizes[3,rr]:=7;
AdvListe2.Cells[4,rr] := Qry1.FieldByName('DepartureDestination').AsString ;
AdvListe2.FontSizes[4,rr]:=7;
AdvListe2.Cells[5,rr] := Qry1.FieldByName('DeparturePax').AsString;
AdvListe2.FontSizes[5,rr]:=7;

AdvListe2.Cells[7,rr] := Qry1.FieldByName('DeparturePrice').AsString +' £ ,Paid:'+Qry1.FieldByName('DeparturePaid').AsString+
' ,'+Qry1.FieldByName('PaidTo').AsString;

AdvListe2.FontSizes[8,rr]:=7;
AdvListe2.Cells[8,rr]  := Qry1.FieldByName('Name').AsString+'  '+Qry1.FieldByName('Surname').AsString ;
AdvListe2.Cells[9,rr]  := Qry1.FieldByName('DepartureBabySeat').AsString ;
AdvListe2.Cells[10,rr] := Qry1.FieldByName('DepartureBoosterSeat').AsString ;
AdvListe2.Cells[11,rr] := Qry1.FieldByName('DepartureNotes').AsString ;
AdvListe2.Cells[12,rr] := Qry1.FieldByName('LocalNumber').AsString ;
AdvListe2.Cells[13,rr] := Qry1.FieldByName('AgencyName').AsString ;
AdvListe2.Cells[14,rr] := Qry1.FieldByName('CarRegNo').AsString+' - '+Qry1.FieldByName('CarModel').AsString ;
end;
Qry1.Next;
end;
end;


AdvListe2.AutoSize:=True;
if ChkPrice.Checked = False then
AdvListe2.HideColumn(6);
end;



procedure TFrmTimeTable.Button3Click(Sender: TObject);
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

procedure TFrmTimeTable.cArBackColor1Click(Sender: TObject);
begin
if ColorDialog1.Execute()= False Then exit;

qry1.Close;
qry1.SQL.Clear;
qry1.SQL.Add('update car set Color=:Color where id=:id ');
Qry1.Parameters.ParamByName('Color').Value  := ColorToString(ColorDialog1.Color);
Qry1.Parameters.ParamByName('id').Value     := inttostr(StrToInt(RightStr(AdvListe.Cells[0,PubGridTop],15))) ;
qry1.Prepared;
qry1.ExecSQL;

BtnList.Click;

end;

procedure TFrmTimeTable.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
if  assigned(FrmReservation2) then FrmReservation2.Close;

Action := caFree;
FrmTimeTable:= nil;
end;

procedure TFrmTimeTable.SpeedButton3Click(Sender: TObject);
begin
if SaveDialog1.Execute then
  if SaveDialog1.FileName<>'' then
    AdvListe.SaveToXLSSheet(SaveDialog1.FileName,'Tablo');
end;

procedure TFrmTimeTable.SpeedButton7Click(Sender: TObject);
begin
if SaveDialog1.Execute then
  if SaveDialog1.FileName<>'' then
     //AdvGridExcelIO1.XLSExport(SaveDialog1.FileName,'Tablo')
    AdvListe2.SaveToXLSSheet(SaveDialog1.FileName+'.xls','Tablo');

end;

procedure TFrmTimeTable.SpeedButton8Click(Sender: TObject);
begin
AdvListe.PrintSettings.TitleLines.Clear;
AdvListe.PrintSettings.TitleLines.Add('TIME TABLE');
AdvListe.PrintSettings.TitleLines.Add('');

AdvPreview.Grid := AdvListe ;
AdvPreview.Execute ;

exit;
Self.PrintScale := poPrintToFit ;
Printers.Printer.Orientation := poLandscape;
Self.Print;


end;

procedure TFrmTimeTable.Uzatma1Click(Sender: TObject);
var i:integer;
begin

if AdvListe.Col=0 then begin
MsgUyari('Please select the Area ...');
exit;
end;

if RightStr(AdvListe.Cells[0,PubGridTop],15)='' Then begin
MsgUyari('Please Select The Area ...');
exit;
end;

if  assigned(FrmReservation2) then begin
if (FrmReservation2.WindowState = wsMinimized ) Then FrmReservation2.WindowState := wsNormal  ;
FrmReservation2.BringToFront;
exit;
end;

FrmReservation2:=TFrmReservation2.Create(Self);

FrmReservation2.SabitDegerler;

if (AdvListe.Cells [PubGridLeft,PubGridTop] <> '') then begin
FrmReservation2.KayitGetir(RightStr(AdvListe.Cells[PubGridRight,PubGridTop],15)) ;

FrmReservation2.ImgSave.Enabled     := True;
FrmReservation2.LblSave.Font.Color  := clWhite;
FrmReservation2.LblSave.Enabled     := True;

FrmReservation2.ImgDelete.Enabled   := False;
FrmReservation2.LblDelete.Font.Color:= clGray;
FrmReservation2.LblDelete.Enabled   := False;

FrmReservation2.ImgEdit.Enabled     := False ;
FrmReservation2.LblEdit.Font.Color  := clGray;
FrmReservation2.LblEdit.Enabled     := False;

FrmReservation2.DtBirakilacakTarih.Date  := FrmReservation2.DtAlinacakTarih.Date ;

PubReservasyonId:=StrToInt(FrmReservation2.TxtReservationIdNo.Text);
end
else Begin
if (AdvListe.Cells [PubGridLeft,PubGridTop] <> '') then begin
MsgUyari(' Double Booking !!! Please choose another reservation area ... ');
exit;
end;

if  (AdvListe.Cells [PubGridRight,PubGridTop] <> '') then begin
MsgUyari(' Double Booking !!! Please choose another reservation area ... ');
exit;
end;

qry2.Close;
qry2.SQL.Clear;
qry2.SQL.Add('Select id,RegNo,Model,Grup,Type from Car where id =:id ');
Qry2.Parameters.ParamByName('id').Value := inttostr(StrToInt(RightStr(AdvListe.Cells[0,PubGridTop],15))) ;
qry2.Prepared;
qry2.Open;
FrmReservation2.Cmbid.ItemIndex         := FrmReservation2.Cmbid.Items.IndexOf(Qry2.FieldByName('id').AsString) ;
FrmReservation2.CmbRegNo.ItemIndex      := FrmReservation2.CmbRegNo.Items.IndexOf(Qry2.FieldByName('RegNo').AsString) ;
FrmReservation2.CmbModel.ItemIndex      := FrmReservation2.CmbModel.Items.IndexOf(Qry2.FieldByName('Model').AsString) ;
FrmReservation2.CmbCarGroup.ItemIndex   := FrmReservation2.CmbCarGroup.Items.IndexOf(Qry2.FieldByName('Grup').AsString) ;
FrmReservation2.CmbCarType.ItemIndex    := FrmReservation2.CmbCarType.Items.IndexOf(Qry2.FieldByName('Type').AsString) ;
FrmReservation2.DtBirakilacakTarih.Date := StrToDate(AdvListe.Cells[PubGridLeft,AdvListe.RowCount]);
FrmReservation2.DtAlinacakTarih.Date    := StrToDate(AdvListe.Cells[PubGridRight,AdvListe.RowCount]);
FrmReservation2.DtTaxiDateDeliver.Date  := StrToDate(AdvListe.Cells[PubGridLeft,AdvListe.RowCount]);
FrmReservation2.DtTaxiDateCollect.Date  := StrToDate(AdvListe.Cells[PubGridRight,AdvListe.RowCount]);
end;

//PubButton:= BtnList ;
FrmReservation2.Show;

if PubT=1 then begin
//
PubT:=0;
end;

End;


procedure TFrmTimeTable.AdvStringGrid3OleDrag(Sender: TObject; ARow,
  ACol: Integer; data: String; var Allow: Boolean);
begin
allow := arow > 0;
end;

procedure TFrmTimeTable.ArrivalBaslik;
begin
AdvListe2.Cells[0,1]:=  'ARRIVAL' ;
AdvListe2.FontSizes[0,1] := 14 ;
AdvListe2.MergeCells(0,1,12,1) ;

AdvListe2.RowColor[2]:=clLtGray;
AdvListe2.Cells[0,2] :='DATE';
AdvListe2.Cells[1,2] :='TIME';
AdvListe2.Cells[2,2] :='DRIVER';
AdvListe2.Cells[3,2] :='COLLECT FROM';
AdvListe2.Cells[4,2] :='DESTINATION';
AdvListe2.Cells[5,2] :='PAX';
AdvListe2.Cells[6,2] :='FLIGHT NO';
AdvListe2.Cells[7,2] :='PRICE';
AdvListe2.Cells[8,2] :='NAME';
AdvListe2.Cells[9,2] :='BABY SEAT';
AdvListe2.Cells[10,2] :='BOOSTER SEAT';
AdvListe2.Cells[11,2] :='NOTE';
AdvListe2.Cells[12,2] :='TEL NO';
AdvListe2.Cells[13,2] :='AGENCY';
AdvListe2.Cells[14,2] :='CAR';
end;

procedure TFrmTimeTable.FormShow(Sender: TObject);
var TmpSql:String;
i:integer;
begin

Self.WindowState := wsMaximized ;

PageControl.TabIndex := 0;

//Dt1.Date := Date - DayOfTheMonth(Date)+1;
//Dt2.Date := EndOfTheMonth(Date);

Dt1.Date := Date ;
Dt2.Date := Date + 60 ;


Dt81.Date := Date;
DtTransfer.Date := Date;
DtFromDate.Date := Date;
DtToDate.Date := Date;

BtnList.Click;

TmpSql:='Select AgencyName as Tmp from Agency order by AgencyName';
Qry1.Close;
Qry1.SQL.Clear;
Qry1.SQL.Add(TmpSql);
Qry1.Open;

for i := 1 to Qry1.RecordCount do begin
CmbAgency.Items.Add(qry1.FieldByName('Tmp').AsString) ;
qry1.Next;
end;

qry1.Close;
qry1.SQL.Clear;
qry1.SQL.Add('Select CustNumber,Name,Surname from Customer order by surname');
qry1.open;

for i := 0 to qry1.RecordCount -1 do begin
//CmbCustNumber.Items.Add(qry1.FieldByName('CustNumber').AsString) ;
CmbCustName.Items.Add(qry1.FieldByName('Name').AsString) ;
CmbCustSurname.Items.Add(qry1.FieldByName('Surname').AsString) ;
qry1.Next;
end;

end;


procedure TFrmTimeTable.Image1Click(Sender: TObject);
var i:integer;
begin
ProgramKullanmaDurumu:=ProgramKullanmaDurumu+1;

FrmTransfers:=TFrmTransfers.Create(self);

FrmTransfers.GroupBox1.Visible := False;

FrmTransfers.DtArrivalTime.Format   := 'HH:mm';
FrmTransfers.DtDepartureTime.Format := 'HH:mm';

FrmTransfers.CmbAgency.Clear;
FrmTransfers.qry1.Close;
FrmTransfers.qry1.SQL.Clear;
FrmTransfers.qry1.SQL.Add('Select * from Agency');
FrmTransfers.qry1.open;

for i := 0 to FrmTransfers.qry1.RecordCount -1 do begin
FrmTransfers.CmbAgency.Items.Add(FrmTransfers.qry1.FieldByName('AgencyName').AsString) ;
FrmTransfers.qry1.Next;
end;
FrmTransfers.DtArrivalDate.Date   := Date;
FrmTransfers.DtDepartureDate.Date := Date;


FrmTransfers.ShowModal;
FrmTransfers.Free;
end;

procedure TFrmTimeTable.Reservation1Click(Sender: TObject);
var i:integer;
begin
PubT:=1;
if AdvListe.Col=0 then begin
MsgUyari('Please select the Area ...');
exit;
end;

if RightStr(AdvListe.Cells[0,PubGridTop],15)='' Then begin
MsgUyari('Please Select The Area ...');
exit;
end;

if  assigned(FrmReservation2) then begin
if (FrmReservation2.WindowState = wsMinimized ) Then FrmReservation2.WindowState := wsNormal  ;
FrmReservation2.BringToFront;
exit;
end;

FrmReservation2:=TFrmReservation2.Create(Self);

FrmReservation2.SabitDegerler;

if (AdvListe.Cells [PubGridLeft,PubGridTop] <> '') then begin
FrmReservation2.KayitGetir(RightStr(AdvListe.Cells[PubGridRight,PubGridTop],15)) ;
PubReservasyonId:=StrToInt(FrmReservation2.TxtReservationIdNo.Text);
end
else Begin
if (AdvListe.Cells [PubGridLeft,PubGridTop] <> '') then begin
MsgUyari(' Double Booking !!! Please choose another reservation area ... ');
exit;
end;

if  (AdvListe.Cells [PubGridRight,PubGridTop] <> '') then begin
MsgUyari(' Double Booking !!! Please choose another reservation area ... ');
exit;
end;


qry2.Close;
qry2.SQL.Clear;
qry2.SQL.Add('Select id,RegNo,Model,Grup,Type from Car where id =:id ');
Qry2.Parameters.ParamByName('id').Value := inttostr(StrToInt(RightStr(AdvListe.Cells[0,PubGridTop],15))) ;
qry2.Prepared;
qry2.Open;
FrmReservation2.Cmbid.ItemIndex         := FrmReservation2.Cmbid.Items.IndexOf(Qry2.FieldByName('id').AsString) ;
FrmReservation2.CmbRegNo.ItemIndex      := FrmReservation2.CmbRegNo.Items.IndexOf(Qry2.FieldByName('RegNo').AsString) ;
FrmReservation2.CmbModel.ItemIndex      := FrmReservation2.CmbModel.Items.IndexOf(Qry2.FieldByName('Model').AsString) ;
FrmReservation2.CmbCarGroup.ItemIndex   := FrmReservation2.CmbCarGroup.Items.IndexOf(Qry2.FieldByName('Grup').AsString) ;
FrmReservation2.CmbCarType.ItemIndex    := FrmReservation2.CmbCarType.Items.IndexOf(Qry2.FieldByName('Type').AsString) ;
FrmReservation2.DtBirakilacakTarih.Date := StrToDate(AdvListe.Cells[PubGridLeft,AdvListe.RowCount]);
FrmReservation2.DtAlinacakTarih.Date    := StrToDate(AdvListe.Cells[PubGridRight,AdvListe.RowCount]);
FrmReservation2.DtTaxiDateDeliver.Date  := StrToDate(AdvListe.Cells[PubGridLeft,AdvListe.RowCount]);
FrmReservation2.DtTaxiDateCollect.Date  := StrToDate(AdvListe.Cells[PubGridRight,AdvListe.RowCount]);

FrmReservation2.BtnGun.Click;
end;

//PubButton:= BtnList ;

FrmReservation2.Show;


End;


procedure TFrmTimeTable.AdvListeSelectionChanged(Sender: TObject; ALeft,
  ATop, ARight, ABottom: Integer);
begin
PubGridLeft  := ALeft ;
PubGridRight := ARight ;
PubGridTop   := ATop  ;
end;

procedure TFrmTimeTable.ChkFromDateClick(Sender: TObject);
begin
if ChkFromDate.Checked = True Then ChkDate.Checked := False;


end;

procedure TFrmTimeTable.CarFontColor1Click(Sender: TObject);
begin

if ColorDialog1.Execute()= False Then exit;

qry1.Close;
qry1.SQL.Clear;
qry1.SQL.Add('update car set FontColor=:FontColor where id=:id ');
Qry1.Parameters.ParamByName('FontColor').Value := ColorToString(ColorDialog1.Color);
Qry1.Parameters.ParamByName('id').Value     := inttostr(StrToInt(RightStr(AdvListe.Cells[0,PubGridTop],15))) ;
qry1.Prepared;
qry1.ExecSQL;

BtnList.Click;


end;

procedure TFrmTimeTable.ChkDateClick(Sender: TObject);
begin
if ChkDate.Checked = True Then ChkFromDate.Checked := False;
if ChkDate.Checked = True Then ChkToDate.Checked := False;

end;

procedure TFrmTimeTable.ChkToDateClick(Sender: TObject);
begin
if ChkToDate.Checked = True Then ChkDate.Checked := False;

end;

procedure TFrmTimeTable.CmbColWidthCange(Sender: TObject);
var i:integer;
begin
CmbColWidth2.ItemIndex := CmbColWidth.ItemIndex;

for i:=1 to AdvListe.ColCount-1  do
AdvListe.ColWidths[i]:=strtoint(CmbColWidth2.Text);


end;

procedure TFrmTimeTable.CmbCustNameChange(Sender: TObject);
begin
CmbCustSurname.ItemIndex := CmbCustName.ItemIndex;

end;

procedure TFrmTimeTable.CmbCustSurnameChange(Sender: TObject);
begin
CmbCustName.ItemIndex := CmbCustSurname.ItemIndex;

end;

procedure TFrmTimeTable.Copy1Click(Sender: TObject);
begin
if (AdvListe.Cells [PubGridLeft,PubGridTop] <> '') then begin

PubReservasyonId := StrToInt(RightStr(AdvListe.Cells[PubGridRight,PubGridTop],15));
TmpPubGridRight  := PubGridRight ;
TmpPubGridLeft   := PubGridLeft  ;
TmpPubGridTop    := PubGridTop   ;

Qry1.Close;
qry1.SQL.Clear;
qry1.SQL.Add('Select * from Reservation where id = :id ');
Qry1.Parameters.ParamByName('id').Value := PubReservasyonId ;
qry1.Prepared;
qry1.Open;

TmpPubBirakilacakTarih := Qry1.FieldByName('BirakilacakTarih').AsDateTime ;
TmpPubBirakilacakSaat  := Qry1.FieldByName('BirakilacakSaat').AsDateTime ;
TmpPubAlinacakTarih    := Qry1.FieldByName('AlinacakTarih').AsDateTime ;
TmpPubAlinacakSaat     := Qry1.FieldByName('AlinacakSaat').AsDateTime ;

end
Else Begin
MsgUyari('Please Select Desired Area ....') ;
End;

end;


procedure TFrmTimeTable.CreateParams(var Params: TCreateParams);
begin
 inherited CreateParams(Params);
  Params.ExStyle   := Params.ExStyle or WS_EX_APPWINDOW;
  Params.WndParent := GetDesktopWindow;
end;


function TFrmTimeTable.DepartureBaslik(rr: integer): String;
begin
AdvListe2.Cells[0,rr]:= 'DEPARTURE' ;
AdvListe2.FontSizes[0,rr] := 14 ;
AdvListe2.MergeCells(0,rr,12,1) ;
AdvListe2.AddRow;
rr:=rr+1;
AdvListe2.RowColor[rr]:=clLtGray;
AdvListe2.Cells[0,rr] :='DATE';
AdvListe2.Cells[1,rr] :='TIME';
AdvListe2.Cells[2,rr] :='DRIVER';
AdvListe2.Cells[3,rr] :='COLLECT FROM';
AdvListe2.Cells[4,rr] :='DESTINATION';
AdvListe2.Cells[5,rr] :='PAX';
AdvListe2.Cells[6,rr] :='';
AdvListe2.Cells[7,rr] :='PRICE';
AdvListe2.Cells[8,rr] :='NAME';
AdvListe2.Cells[9,rr] :='BABY SEAT';
AdvListe2.Cells[10,rr] :='BOOSTER SEAT';
AdvListe2.Cells[11,rr] :='NOTE';
AdvListe2.Cells[12,rr] :='TEL NO';
AdvListe2.Cells[13,rr] :='AGENCY';
AdvListe2.Cells[14,rr] :='CAR';
end;

procedure TFrmTimeTable.PageControlChange(Sender: TObject);
begin
ProgramKullanmaDurumu:=ProgramKullanmaDurumu+1;
end;

procedure TFrmTimeTable.Paste1Click(Sender: TObject);
var TmpSql,TmpPlaka,TmpMarka,TmpCarid,TmpCarGroup,TmpCarType,TmpDateSeperator:string;
    i,z:integer;
    DateBirakilacak,DateBirakilacak1,DateAlinacak,DateAlinacak1,TimeBirakilacak1,TimeAlinacak1,TimeBirakilacak,TimeAlinacak:TDateTime;
    DtBirakilacakSaat,DtAlinacakSaat,DtBirakilacakTarih,DtAlinacakTarih :TDateTime;
const
      Aylar: array [0..11] of string=
        ('January','February','March','April','May','June','July','August',
         'September','October','November','December');

begin
                  //FormatSettings.
TmpDateSeperator:=FormatSettings.DateSeparator;

if PubReservasyonId = 0 Then Exit;

if (AdvListe.Cells [PubGridLeft,PubGridTop] <> '') then begin
MsgUyari(' Double Booking !!! Please choose another reservation area ... ');
exit;
end;

if  (AdvListe.Cells [PubGridRight,PubGridTop] <> '') then begin
MsgUyari(' Double Booking !!! Please choose another reservation area ... ');
exit;
end;

////////////////////////////////////////////////////////////////////////////////////////////////////////////
qry1.Close;
qry1.SQL.Clear;
qry1.SQL.Add('Select * from car where id=:Carid');
Qry1.Parameters.ParamByName('Carid').Value := StrToInt(RightStr(AdvListe.Cells[0,PubGridTop],15));
Qry1.Prepared;
qry1.Open;

if qry1.RecordCount = 0 Then begin
 MsgUyari('Please Select Area ...');
 Exit;
end
Else
 Begin
  TmpPlaka:=qry1.FieldByName('RegNo').AsString ;
  TmpMarka:=qry1.FieldByName('Model').AsString ;
  TmpCarid:=qry1.FieldByName('id').AsString ;
  TmpCarGroup:=qry1.FieldByName('grup').AsString ;
  TmpCarType:=qry1.FieldByName('type').AsString ;
 end;

///////////////////////////////////////////////////////////////////////////////////////////7777

////////////////////////////////////////// KONTROL KISMI //////////////////////////////////////////////////////////////////

TmpSql := 'Select * from Reservation where id=:id  ' ;
Qry1.Close;
qry1.SQL.Clear;
qry1.SQL.Add(TmpSql);
Qry1.Parameters.ParamByName('id').Value := PubReservasyonId ;
qry1.Prepared;
qry1.Open;
DtBirakilacakSaat  := Qry1.FieldByName('BirakilacakSaat').AsDateTime ;
DtAlinacakSaat     := Qry1.FieldByName('AlinacakSaat').AsDateTime ;
DtBirakilacakTarih := Qry1.FieldByName('BirakilacakTarih').AsDateTime ;
DtAlinacakTarih    := Qry1.FieldByName('alinacakTarih').AsDateTime ;

TmpSql := 'Select * from Reservation where id<>:id and Carid=:CariD and Durum<>''Deleted'' ' ;
z:=0;
Qry1.Close;
qry1.SQL.Clear;
qry1.SQL.Add(TmpSql);
Qry1.Parameters.ParamByName('Carid').Value := StrToInt(RightStr(AdvListe.Cells[0,PubGridTop],15));  ;
Qry1.Parameters.ParamByName('id').Value    := PubReservasyonId ;
qry1.Prepared;
qry1.Open;

if qry1.recordcount <> 0 Then Begin
for i:=1 to qry1.RecordCount do begin

/////////////////////////////////////////////////////////////////////////////////////77
if strtoint(currtostr(HourOf(Qry1.FieldByName('BirakilacakSaat').AsDateTime))) = 0 Then
TimeBirakilacak1 := 24
Else
TimeBirakilacak1 := strtoint(currtostr(HourOf(Qry1.FieldByName('BirakilacakSaat').AsDateTime)));

if strtoint(currtostr(HourOf(Qry1.FieldByName('AlinacakSaat').AsDateTime))) = 0 Then
TimeAlinacak1 := 24
Else
TimeAlinacak1 := strtoint(currtostr(HourOf(Qry1.FieldByName('AlinacakSaat').AsDateTime)));

if strtoint(currtostr(HourOf(DtBirakilacakSaat))) = 0 Then
TimeBirakilacak := 24
Else
TimeBirakilacak := strtoint(currtostr(HourOf(DtBirakilacakSaat)));

if strtoint(currtostr(HourOf(DtAlinacakSaat))) = 0 Then
TimeAlinacak := 24
Else
TimeAlinacak := strtoint(currtostr(HourOf(DtAlinacakSaat)));
/////////////////////////////////

DateBirakilacak := HoursBetween(StrToDate('1'+TmpDateSeperator+'1'+TmpDateSeperator+'1900'), DtBirakilacakTarih) + TimeBirakilacak ;

DateBirakilacak1:= HoursBetween(StrToDate('1'+TmpDateSeperator+'1'+TmpDateSeperator+'1900'),Qry1.FieldByName('BirakilacakTarih').AsDateTime)+TimeBirakilacak1 ;

DateAlinacak    := HoursBetween(StrToDate('1'+TmpDateSeperator+'1'+TmpDateSeperator+'1900'),DtAlinacakTarih) + TimeAlinacak ;

DateAlinacak1   := HoursBetween(StrToDate('1'+TmpDateSeperator+'1'+TmpDateSeperator+'1900'),Qry1.FieldByName('alinacakTarih').AsDateTime) + TimeAlinacak1 ;

if ( DateBirakilacak <= DateAlinacak1 ) and ( DateAlinacak >= DateBirakilacak1 ) Then
    z:=1;

if z = 1 then begin
MsgUyari('ERROR'+#13+#13+ 'Desired Date  :'+#13+DateTimeToStr(DtBirakilacakTarih + Timeof(DtBirakilacakSaat) )
         +' - '+  DateTimeToStr(DtAlinacakTarih + Timeof(DtAlinacakSaat)) + #13 +
         'Date Crash With :'+#13+DateTimeToStr(Qry1.FieldByName('BirakilacakTarih').AsDateTime+Timeof(Qry1.FieldByName('BirakilacakSaat').AsDateTime))+' - '+
          DateTimeToStr(Qry1.FieldByName('alinacakTarih').AsDateTime+Timeof(Qry1.FieldByName('AlinacakSaat').AsDateTime)) ) ;
exit;
end;
qry1.Next;
end;
end;

/////////////////////////////////////////////////////////////////////////////////////////77

TmpSql:='update Reservation set ' +

' Carid=:Carid, '+
' CarModel=:CarModel, '+
' CarRegNo=:CarRegNo, ' +
' CarGroup=:CarGroup, '  +
' CarType=:CarType '  +

' where id = :id ';


qry1.Close;
qry1.SQL.Clear;
qry1.SQL.Add(TmpSql);
Qry1.Parameters.ParamByName('Carid').Value            := TmpCarid    ;
Qry1.Parameters.ParamByName('CarModel').Value         := TmpMarka ;
Qry1.Parameters.ParamByName('CarRegNo').Value         := TmpPlaka ;
Qry1.Parameters.ParamByName('CarGroup').Value         := TmpCarGroup ;
Qry1.Parameters.ParamByName('CarType').Value          := TmpCarType  ;

Qry1.Parameters.ParamByName('id').Value               := PubReservasyonId ;

qry1.Prepared;
qry1.ExecSQL;


TmpSql:='update Transfer set ' +

' Carid=:Carid, '+
' CarModel=:CarModel, '+
' CarRegNo=:CarRegNo, ' +
' CarGroup=:CarGroup, '  +
' CarType=:CarType '  +

' where RegNo = :RegNo ';


qry1.Close;
qry1.SQL.Clear;
qry1.SQL.Add(TmpSql);
Qry1.Parameters.ParamByName('Carid').Value            := TmpCarid    ;
Qry1.Parameters.ParamByName('CarModel').Value         := TmpMarka ;
Qry1.Parameters.ParamByName('CarRegNo').Value         := TmpPlaka ;
Qry1.Parameters.ParamByName('CarGroup').Value         := TmpCarGroup ;
Qry1.Parameters.ParamByName('CarType').Value          := TmpCarType  ;

Qry1.Parameters.ParamByName('RegNo').Value               := PubReservasyonId ;

qry1.Prepared;
qry1.ExecSQL;



PubReservasyonId :=0;
BtnList.Click;
end;

procedure TFrmTimeTable.AdvListeGetAlignment(Sender: TObject; ARow,
  ACol: Integer; var HAlign: TAlignment; var VAlign: TVAlignment);
begin
if ARow in [0,1] then begin
HAlign := taCenter ;
VAlign := vtaCenter ;
end;
end;

procedure TFrmTimeTable.AdvListeGridHint(Sender: TObject; ARow, ACol: Integer;
  var hintstr: string);
var TmpDeliverTime,TmpCollectTime,TmpSql:String;
TmpDays:integer;
begin

if RightStr(AdvListe.Cells[PubGridRight,PubGridTop],15)='' then exit;

TmpSql:='Select Name,Surname,ContactNumber,Notes,BirakilacakTarih,AlinacakTarih,DeliverTimeChecked,BirakilacakSaat,'+
' CollectTimeChecked,alinacakSaat,birakilacakYer,AlinacakYer,HighSeasonDays,MidSeasonDays,LowSeasonDays from Reservation where id=:id ' ;
qry1.Close;
qry1.SQL.Clear;
qry1.SQL.Add(TmpSql);
Qry1.Parameters.ParamByName('id').Value := RightStr(AdvListe.Cells[PubGridRight,PubGridTop],15) ;
qry1.Prepared;
qry1.Open;


TmpDays :=
Qry1.FieldByName('HighSeasonDays').AsInteger+Qry1.FieldByName('MidSeasonDays').AsInteger+Qry1.FieldByName('LowSeasonDays').AsInteger ;

if Qry1.FieldByName('DeliverTimeChecked').AsString='Y' then
TmpDeliverTime:= Qry1.FieldByName('BirakilacakSaat').AsString
Else  TmpDeliverTime:= '??????';

if Qry1.FieldByName('CollectTimeChecked').AsString='Y' then
TmpCollectTime:= Qry1.FieldByName('alinacakSaat').AsString
Else TmpCollectTime:=  '??????';


hintstr:=
Qry1.FieldByName('BirakilacakTarih').AsString+' '+LeftStr(TmpDeliverTime,LEngth(TmpDeliverTime)-3) +' ('+

Qry1.FieldByName('Name').AsString+'  '+Qry1.FieldByName('Surname').AsString+' - '+Qry1.FieldByName('birakilacakYer').AsString+
' - '+Qry1.FieldByName('AlinacakYer').AsString+' - '+intToStr(TmpDays)+' Days'+
Qry1.FieldByName('ContactNumber').AsString+'  '+Qry1.FieldByName('Notes').AsString+') '+

Qry1.FieldByName('alinacakTarih').AsString+' '+LeftStr(TmpCollectTime,LEngth(TmpCollectTime)-3);



end;

procedure TFrmTimeTable.BtnList8Click(Sender: TObject);
var i,rr:integer;
TmpCurr:String;
const
      Gunler: array [0..6] of string=
        ('MONDAY','TUESDAY','WEDNESDAY','THURSDAY','FRIDAY','SATURDAY','SUNDAY');
        var g:integer;
begin
ProgramKullanmaDurumu:=ProgramKullanmaDurumu+1;

AdvListe8.ClearCols(0,AdvListe8.ColCount-1);
AdvListe8.ClearRows(0,AdvListe8.RowCount-1);
AdvListe8.RowCount :=4;

rr:=2;

AdvListe8.MergeCells(0,0,8,1) ;
AdvListe8.Cells[8,0]:=  DateToStr(Dt81.Date) + '   '+Gunler[DayOfTheWeek(dT81.DATE)-1] ;
AdvListe8.MergeCells(8,0,9,1) ;

AdvListe8.Cells[0,1]:= 'COLLECT CARS' ;
AdvListe8.RowFontColor[1] := clBlack ;
AdvListe8.FontSizes[0,1] := 14 ;
AdvListe8.MergeCells(0,1,17,1) ;

AdvListe8.RowColor[2]:=clLtGray;
AdvListe8.Cells[0,2] :='';
AdvListe8.ColWidths[0]:=30;
AdvListe8.Cells[1,2] :='TIME';
AdvListe8.ColWidths[1]:=40;
AdvListe8.Cells[2,2] :='REG NO';
AdvListe8.ColWidths[2]:=50;
AdvListe8.Cells[3,2] :='COLLECT FROM';
AdvListe8.ColWidths[3]:=100;
AdvListe8.Cells[4,2] :='NAME - SURNAME';
AdvListe8.ColWidths[4]:=110;
AdvListe8.Cells[5,2] :='NOTES';
AdvListe8.ColWidths[5]:=90;
AdvListe8.Cells[6,2] :='AGENCY';
AdvListe8.ColWidths[6]:=100;
AdvListe8.Cells[7,2] :='TEL';
AdvListe8.ColWidths[7]:=80;
AdvListe8.Cells[8,2]:='BABY';
AdvListe8.ColWidths[8]:=40;
AdvListe8.Cells[9,2]:='BOOST';
AdvListe8.ColWidths[9]:=60;
AdvListe8.Cells[10,2]:='';
AdvListe8.Cells[11,2]:='';
AdvListe8.Cells[12,2]:='';
AdvListe8.ColWidths[12]:=40;
AdvListe8.Cells[13,2]:='';
AdvListe8.ColWidths[13]:=40;
AdvListe8.Cells[14,2]:='';
AdvListe8.ColWidths[14]:=70;

qry1.Close;
qry1.SQL.Clear;
qry1.SQL.Add('Select * from reservation where durum<>''Deleted'' and alinacakTarih=:alinacakTarih order by alinacakTarih,AlinacakSaat');
Qry1.Parameters.ParamByName('alinacakTarih').Value :=
IntToStr(YearOf(Dt81.Date))+'-'+IntToStr(MonthOf(Dt81.Date))+'-'+IntToStr(DayOf(Dt81.Date));
qry1.Prepared;
qry1.Open;

if qry1.RecordCount <> 0 Then Begin
for i:=1 to Qry1.RecordCount do begin
AdvListe8.AddRow;
rr:=rr+1;

if (Qry1.FieldByName('TaxiDeliverFrom').AsString<>'') or (Qry1.FieldByName('TaxiDeliverFrom').AsString<>'') then
AdvListe8.Cells[0,rr] :=  'T';
AdvListe8.FontSizes[0,rr] := 14 ;

AdvListe8.Cells[1,rr] := FormatDateTime('t',Qry1.FieldByName('AlinacakSaat').AsdateTime);
AdvListe8.Cells[2,rr] := Qry1.FieldByName('CarRegNo').AsString;
AdvListe8.Cells[3,rr] := Qry1.FieldByName('AlinacakYer').AsString;
AdvListe8.Cells[4,rr] := Qry1.FieldByName('Name').AsString+'  '+Qry1.FieldByName('Surname').AsString;
AdvListe8.Cells[5,rr] := Qry1.FieldByName('AlinacakNotlar').AsString;
AdvListe8.Cells[6,rr] := Qry1.FieldByName('Agency').AsString;
AdvListe8.Cells[7,rr] := Qry1.FieldByName('ContactNumber').AsString;
AdvListe8.Cells[8,rr] := Qry1.FieldByName('BabySeat').AsString;
AdvListe8.Cells[9,rr] := Qry1.FieldByName('BoosterSeat').AsString;

Qry1.Next;
end;
End;

AdvListe8.AddRow;
rr:=rr+1 ;

AdvListe8.Cells[0,rr]:=  'DELIVER CARS' ;
AdvListe8.RowFontColor[rr] := clBlack ;
AdvListe8.FontSizes[0,rr] := 14 ;
AdvListe8.MergeCells(0,rr,17,1) ;

AdvListe8.AddRow;
rr:=rr+1 ;
g:=rr;
AdvListe8.RowColor[rr]:=clLtGray;
AdvListe8.Cells[0,rr]  :='';
AdvListe8.Cells[1,rr]  :='TIME';
AdvListe8.Cells[2,rr]  :='REG NO';
AdvListe8.Cells[3,rr]  :='DELIVER TO';
AdvListe8.Cells[4,rr]  :='NAME - SURNAME';
AdvListe8.Cells[5,rr]  :='T.DAYS';
AdvListe8.Cells[6,rr]  :='PET';
AdvListe8.Cells[7,rr]  :='TRNS.';
AdvListe8.Cells[8,rr]  :='TOTAL';
AdvListe8.Cells[9,rr]  :='END DATE TIME';
AdvListe8.Cells[10,rr] :='NOTES';
AdvListe8.Cells[11,rr] :='AGENCY';
AdvListe8.Cells[12,rr] :='BABY';
AdvListe8.Cells[13,rr] :='BOOST';
AdvListe8.Cells[14,rr] :='TEL NO';



qry1.Close;
qry1.SQL.Clear;
qry1.SQL.Add('Select * from reservation where durum<>''Deleted'' and BirakilacakTarih = :BirakilacakTarih order by BirakilacakTarih,BirakilacakSaat');
Qry1.Parameters.ParamByName('BirakilacakTarih').Value :=
IntToStr(YearOf(Dt81.Date))+'-'+IntToStr(MonthOf(Dt81.Date))+'-'+IntToStr(DayOf(Dt81.Date));
qry1.Prepared;
qry1.Open;

if qry1.RecordCount <> 0 Then Begin
for i:=1 to Qry1.RecordCount do begin

if TimeToStr(TimeOf(Qry1.FieldByName('BirakilacakSaat').AsdateTime)) <> '00:00:00' Then Begin

TmpCurr := Qry1.FieldByName('Currency').AsString;
if TmpCurr = 'EURO' Then TmpCurr := '€' ;
if TmpCurr = 'STERLIN' Then TmpCurr := '£' ;

AdvListe8.AddRow;
rr:=rr+1;

if (Qry1.FieldByName('TaxiDeliverFrom').AsString<>'') or (Qry1.FieldByName('TaxiDeliverFrom').AsString<>'') then
AdvListe8.Cells[0,rr] :=  'T';
AdvListe8.FontSizes[0,rr] := 14 ;


AdvListe8.Cells[1,rr] := FormatDateTime('t',Qry1.FieldByName('BirakilacakSaat').AsdateTime);
AdvListe8.Cells[2,rr] := Qry1.FieldByName('CarRegNo').AsString;
AdvListe8.Cells[3,rr] := Qry1.FieldByName('BirakilacakYer').AsString;
AdvListe8.Cells[4,rr]  := Qry1.FieldByName('Name').AsString+' '+Qry1.FieldByName('Surname').AsString;
AdvListe8.Cells[5,rr] := Qry1.FieldByName('TotalDays').AsString;
if Qry1.FieldByName('Petrol').AsCurrency <> 0 then
AdvListe8.Cells[6,rr] := FormatCurr(',0.00',Qry1.FieldByName('Petrol').AsCurrency)+' '+TmpCurr;
AdvListe8.Cells[7,rr] :=
FormatCurr(',0.00',Qry1.FieldByName('TaxiPickUp').AsCurrency+Qry1.FieldByName('TaxiDropOff').AsCurrency)+
' '+TmpCurr;

if Qry1.FieldByName('OutstandingBalance').AsCurrency=0 then
AdvListe8.Cells[8,rr] :=
FormatCurr(',0.00',Qry1.FieldByName('GeneralTotal').AsCurrency-Qry1.FieldByName('Discount').AsCurrency)+' '+TmpCurr
Else
AdvListe8.Cells[8,rr] :=
FormatCurr(',0.00',Qry1.FieldByName('OutstandingBalance').AsCurrency)+' '+TmpCurr ;

{FormatCurr(',0.00',
Qry1.FieldByName('Petrol').AsCurrency+Qry1.FieldByName('OutstandingBalance').AsCurrency+Qry1.FieldByName('Petrol').AsCurrency+
Qry1.FieldByName('TaxiPickUp').AsCurrency+Qry1.FieldByName('TaxiDropOff').AsCurrency
)+' '+TmpCurr;
}
AdvListe8.Cells[9,rr] := Qry1.FieldByName('AlinacakTarih').AsString+' - '+FormatDateTime('t',Qry1.FieldByName('AlinacakSaat').AsdateTime) ;
AdvListe8.Cells[10,rr] := Qry1.FieldByName('BirakilacakNotlar').AsString;

AdvListe8.Cells[11,rr] := Qry1.FieldByName('Agency').AsString;

AdvListe8.Cells[12,rr] := Qry1.FieldByName('BabySeat').AsString;
AdvListe8.Cells[13,rr] := Qry1.FieldByName('BoosterSeat').AsString;
AdvListe8.Cells[14,rr] := Qry1.FieldByName('ContactNumber').AsString;

end;
Qry1.Next;
end;
end;


for i:=0 to AdvListe8.RowCount-1 do
AdvListe8.AutoSizeRow(i);

AdvListe8.RowHeights[2]:=40;
AdvListe8.RowHeights[g]:=40;

end;

procedure TFrmTimeTable.SpeedButton4Click(Sender: TObject);
var i:integer;
begin

//for i:=0 to AdvListe8.RowCount-1 do
//AdvListe8.RowHeights[i]:=28;


ProgramKullanmaDurumu:=ProgramKullanmaDurumu+1;

AdvListe8.PrintSettings.TitleLines.Clear;
AdvListe8.PrintSettings.TitleLines.Add('JOB REPORT ('+DateToStr(Dt81.Date)+')');
AdvListe8.PrintSettings.TitleLines.Add('');

AdvPreview.Grid := AdvListe8 ;
AdvPreview.Execute ;


//for i:=0 to AdvListe8.RowCount-1 do
//AdvListe8.AutoSizeRow(i);


end;

procedure TFrmTimeTable.SpeedButton5Click(Sender: TObject);
var i,rr:integer;
TmpSql,TmpCurr:String;
const
      Gunler: array [0..6] of string=
        ('MONDAY','TUESDAY','WEDNESDAY','THURSDAY','FRIDAY','SATURDAY','SUNDAY');

begin
ProgramKullanmaDurumu := ProgramKullanmaDurumu+1;

AdvListe2.ClearRows(0,AdvListe2.RowCount-1);
AdvListe2.RowCount :=3;
rr:=2;

ArrivalBaslik;

TmpSql := 'Select ArrivalTime,ArrivalDate,Driver,ArrivalCollectFrom,ArrivalDestination,ArrivalPax,ArrivalFlightNo,ArrivalPrice,ArrivalPaid,'+
'Name,Surname,ArrivalBabySeat,ArrivalBoosterSeat,ArrivalNotes,LocalNumber,AgencyName,CarRegNo,CarModel,ArrivalPaidTo,Currency '+
' from Transfer where CheckedArrival =''Y'' ' ;

if ChkDate.Checked = True  then
TmpSql:=TmpSql + ' and ArrivalDate = :ArrivalDate  ' ;

TmpSql:=TmpSql + ' order by ArrivalDate, ArrivalTime ' ;
qry1.Close;
qry1.SQL.Clear;
qry1.SQL.Add(TmpSql);
if ChkDate.Checked = True  then
Qry1.Parameters.ParamByName('ArrivalDate').Value :=
IntToStr(YearOf(DtTransfer.Date))+'-'+IntToStr(MonthOf(DtTransfer.Date))+'-'+IntToStr(DayOf(DtTransfer.Date));
qry1.Prepared;
qry1.Open;

TmpCurr := Qry1.FieldByName('Currency').AsString;
if TmpCurr = 'EURO'    Then TmpCurr := '€' ;
if TmpCurr = 'STERLIN' Then TmpCurr := '£' ;
if TmpCurr = 'DOLLAR'  Then TmpCurr := '$' ;

for i:=1 to Qry1.RecordCount do begin

if TimeToStr(TimeOf(Qry1.FieldByName('ArrivalTime').AsdateTime)) <> '00:00:00' then Begin
AdvListe2.AddRow;
rr:=rr+1;

AdvListe2.Cells[0,rr] := Qry1.FieldByName('ArrivalDate').AsString ;
AdvListe2.Cells[1,rr] := FormatDateTime('t',Qry1.FieldByName('ArrivalTime').AsdateTime);
AdvListe2.Cells[2,rr] := Qry1.FieldByName('Driver').AsString ;
AdvListe2.Cells[3,rr] := Qry1.FieldByName('ArrivalCollectFrom').AsString ;

AdvListe2.Cells[4,rr] := Qry1.FieldByName('ArrivalDestination').AsString ;

AdvListe2.Cells[5,rr] := Qry1.FieldByName('ArrivalPax').AsString;

AdvListe2.Cells[6,rr] := Qry1.FieldByName('ArrivalFlightNo').AsString;

AdvListe2.Cells[7,rr] := FormatFloat('#,##0.00',Qry1.FieldByName('ArrivalPrice').AsCurrency) +' '+TmpCurr+' ,Paid:'+Qry1.FieldByName('ArrivalPaid').AsString+ ' ,'+Qry1.FieldByName('ArrivalPaidTo').AsString;

if (Qry1.FieldByName('ArrivalPaid').AsString <> 'Y') Then  AdvListe2.RowColor[rr]:=$008C6BB8 ;

AdvListe2.Cells[8,rr]  := Qry1.FieldByName('Name').AsString+'  '+Qry1.FieldByName('Surname').AsString ;
AdvListe2.Cells[9,rr]  := Qry1.FieldByName('ArrivalBabySeat').AsString ;
AdvListe2.Cells[10,rr] := Qry1.FieldByName('ArrivalBoosterSeat').AsString ;
AdvListe2.Cells[11,rr] := Qry1.FieldByName('ArrivalNotes').AsString ;
AdvListe2.Cells[12,rr] := Qry1.FieldByName('LocalNumber').AsString ;
AdvListe2.Cells[13,rr] := Qry1.FieldByName('AgencyName').AsString ;
AdvListe2.Cells[14,rr] := Qry1.FieldByName('CarRegNo').AsString+' - '+Qry1.FieldByName('CarModel').AsString ;
End;
Qry1.Next;
end;
///////////////////////////////////////////////////////////////////////////////////////////////////////////////

TmpSql := 'Select TaxiTimeDeliver,TaxiDateDeliver,TaxiDeliverFrom,TaxiDeliverTo,PaxsPickUp,'+
'Name,Surname,ContactNumber,Agency,CarRegNo,CarModel,Currency,TaxiPickUp '+
' from Reservation where TaxiDeliverFrom <>'''' and Durum<>''Deleted'' ' ;

if ChkDate.Checked = True  then
TmpSql:=TmpSql + ' and TaxiDateDeliver = :TaxiDateDeliver  ' ;

TmpSql:=TmpSql + ' order by TaxiDateDeliver, TaxiTimeDeliver ' ;
qry1.Close;
qry1.SQL.Clear;
qry1.SQL.Add(TmpSql);
if ChkDate.Checked = True  then
Qry1.Parameters.ParamByName('TaxiDateDeliver').Value :=
IntToStr(YearOf(DtTransfer.Date))+'-'+IntToStr(MonthOf(DtTransfer.Date))+'-'+IntToStr(DayOf(DtTransfer.Date));
qry1.Prepared;
qry1.Open;

TmpCurr := Qry1.FieldByName('Currency').AsString;
if TmpCurr = 'EURO'    Then TmpCurr := '€' ;
if TmpCurr = 'STERLIN' Then TmpCurr := '£' ;
if TmpCurr = 'DOLLAR'  Then TmpCurr := '$' ;

for i:=1 to Qry1.RecordCount do begin

AdvListe2.AddRow;
rr:=rr+1;

AdvListe2.Cells[0,rr] := Qry1.FieldByName('TaxiDateDeliver').AsString ;
AdvListe2.Cells[1,rr] := FormatDateTime('t',Qry1.FieldByName('TaxiTimeDeliver').AsdateTime);
AdvListe2.Cells[2,rr] := '' ;
AdvListe2.Cells[3,rr] := Qry1.FieldByName('TaxiDeliverFrom').AsString ;

AdvListe2.Cells[4,rr] := Qry1.FieldByName('TaxiDeliverTo').AsString ;

AdvListe2.Cells[5,rr] := Qry1.FieldByName('PaxsPickUp').AsString;

AdvListe2.Cells[6,rr] := '';

AdvListe2.Cells[7,rr] := FormatFloat('#,##0.00',Qry1.FieldByName('TaxiPickUp').AsCurrency)+' '+TmpCurr;

AdvListe2.Cells[8,rr]  := Qry1.FieldByName('Name').AsString+'  '+Qry1.FieldByName('Surname').AsString ;
AdvListe2.Cells[9,rr]  := '';
AdvListe2.Cells[10,rr] := '';
AdvListe2.Cells[11,rr] := '';
AdvListe2.Cells[12,rr] := Qry1.FieldByName('ContactNumber').AsString ;
AdvListe2.Cells[13,rr] := Qry1.FieldByName('Agency').AsString ;
AdvListe2.Cells[14,rr] := Qry1.FieldByName('CarRegNo').AsString+' - '+Qry1.FieldByName('CarModel').AsString ;
Qry1.Next;
End;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


AdvListe2.AddRow;
rr:=rr+1 ;
DepartureBaslik(rr);
rr:=rr+1;

TmpSql := '';
TmpSql := TmpSql + 'Select DepartureTime,DeparturePaid,DepartureDate,Driver,DepartureCollectFrom,DepartureDestination,DeparturePax,DeparturePrice,DeparturePaid,'+
'PaidTo,Name,Surname,DepartureBabySeat,DepartureBoosterSeat,DepartureNotes,LocalNumber,AgencyName,CarRegNo,CarModel,Currency '+
' from Transfer where CheckedDeparture = ''Y''  ' ;
if ChkDate.Checked = True  then
TmpSql:=TmpSql + ' and DepartureDate = :DepartureDate  ' ;
TmpSql:=TmpSql + 'order by DepartureDate,DepartureTime ' ;

qry1.Close;
qry1.SQL.Clear;
qry1.SQL.Add(TmpSql);
if ChkDate.Checked = True  then
Qry1.Parameters.ParamByName('DepartureDate').Value :=
IntToStr(YearOf(DtTransfer.Date))+'-'+IntToStr(MonthOf(DtTransfer.Date))+'-'+IntToStr(DayOf(DtTransfer.Date));
qry1.Prepared;
qry1.Open;

TmpCurr := Qry1.FieldByName('Currency').AsString;
if TmpCurr = 'EURO'    Then TmpCurr := '€' ;
if TmpCurr = 'STERLIN' Then TmpCurr := '£' ;
if TmpCurr = 'DOLLAR'  Then TmpCurr := '$' ;

for i:=1 to Qry1.RecordCount do begin
if TimeToStr(TimeOf(Qry1.FieldByName('DepartureTime').AsdateTime)) <> '00:00:00' Then Begin
AdvListe2.AddRow;
rr:=rr+1;

if (Qry1.FieldByName('DeparturePaid').AsString <> 'Y') Then AdvListe2.RowColor[rr]:=$008C6BB8 ;

AdvListe2.Cells[0,rr] := Qry1.FieldByName('DepartureDate').AsString ;
AdvListe2.Cells[1,rr] := FormatDateTime('t',Qry1.FieldByName('DepartureTime').AsdateTime);
AdvListe2.Cells[2,rr] := Qry1.FieldByName('Driver').AsString ;
AdvListe2.Cells[3,rr] := Qry1.FieldByName('DepartureCollectFrom').AsString ;

AdvListe2.Cells[4,rr] := Qry1.FieldByName('DepartureDestination').AsString ;

AdvListe2.Cells[5,rr] := Qry1.FieldByName('DeparturePax').AsString;


AdvListe2.Cells[7,rr] := FormatFloat('#,##0.00',Qry1.FieldByName('DeparturePrice').AsCurrency)+' '+TmpCurr+' ,Paid:'+Qry1.FieldByName('DeparturePaid').AsString+
' ,'+Qry1.FieldByName('PaidTo').AsString;


AdvListe2.Cells[8,rr]  := Qry1.FieldByName('Name').AsString+'  '+Qry1.FieldByName('Surname').AsString ;
AdvListe2.Cells[9,rr]  := Qry1.FieldByName('DepartureBabySeat').AsString ;
AdvListe2.Cells[10,rr] := Qry1.FieldByName('DepartureBoosterSeat').AsString ;
AdvListe2.Cells[11,rr] := Qry1.FieldByName('DepartureNotes').AsString ;
AdvListe2.Cells[12,rr] := Qry1.FieldByName('LocalNumber').AsString ;
AdvListe2.Cells[13,rr] := Qry1.FieldByName('AgencyName').AsString ;
AdvListe2.Cells[14,rr] := Qry1.FieldByName('CarRegNo').AsString+' - '+Qry1.FieldByName('CarModel').AsString ;
end;
Qry1.Next;
end;



///////////////////////////////////////////////////////////////////////////////////////////////////////////////

TmpSql := 'Select TaxiTimeCollect,TaxiDateCollect,TaxiCollectFrom,TaxiCollectTo,PaxsDropOff,'+
'Name,Surname,ContactNumber,Agency,CarRegNo,CarModel,Currency,TaxiDropOff '+
' from Reservation where TaxiCollectFrom <>'''' ' ;

if ChkDate.Checked = True  then
TmpSql:=TmpSql + ' and TaxiDateCollect = :TaxiDateCollect  ' ;

TmpSql:=TmpSql + ' order by TaxiDateCollect, TaxiTimeCollect ' ;
qry1.Close;
qry1.SQL.Clear;
qry1.SQL.Add(TmpSql);
if ChkDate.Checked = True  then
Qry1.Parameters.ParamByName('TaxiDateCollect').Value :=
IntToStr(YearOf(DtTransfer.Date))+'-'+IntToStr(MonthOf(DtTransfer.Date))+'-'+IntToStr(DayOf(DtTransfer.Date));
qry1.Prepared;
qry1.Open;

TmpCurr := Qry1.FieldByName('Currency').AsString;
if TmpCurr = 'EURO'    Then TmpCurr := '€' ;
if TmpCurr = 'STERLIN' Then TmpCurr := '£' ;
if TmpCurr = 'DOLLAR'  Then TmpCurr := '$' ;

for i:=1 to Qry1.RecordCount do begin
AdvListe2.AddRow;
rr:=rr+1;

AdvListe2.Cells[0,rr] := Qry1.FieldByName('TaxiDateCollect').AsString ;
AdvListe2.Cells[1,rr] := FormatDateTime('t',Qry1.FieldByName('TaxiTimeCollect').AsdateTime);
AdvListe2.Cells[2,rr] := '' ;
AdvListe2.Cells[3,rr] := Qry1.FieldByName('TaxiCollectFrom').AsString ;

AdvListe2.Cells[4,rr] := Qry1.FieldByName('TaxiCollectTo').AsString ;

AdvListe2.Cells[5,rr] := Qry1.FieldByName('PaxsDropOff').AsString;

AdvListe2.Cells[6,rr] := '';

AdvListe2.Cells[7,rr] := FormatFloat('#,##0.00',Qry1.FieldByName('TaxiDropOff').AsCurrency)+' '+TmpCurr;

AdvListe2.Cells[8,rr]  := Qry1.FieldByName('Name').AsString+'  '+Qry1.FieldByName('Surname').AsString ;
AdvListe2.Cells[9,rr]  := '';
AdvListe2.Cells[10,rr] := '';
AdvListe2.Cells[11,rr] := '';
AdvListe2.Cells[12,rr] := Qry1.FieldByName('ContactNumber').AsString ;
AdvListe2.Cells[13,rr] := Qry1.FieldByName('Agency').AsString ;
AdvListe2.Cells[14,rr] := Qry1.FieldByName('CarRegNo').AsString+' - '+Qry1.FieldByName('CarModel').AsString ;
Qry1.Next;
End;
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


AdvListe2.AutoSize:=True;
end;



end.
