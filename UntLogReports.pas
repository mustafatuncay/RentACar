unit UntLogReports;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, BaseGrid, AdvGrid, Menus, DB, ADODB, StdCtrls, Buttons, jpeg, ExtCtrls, Mask,
  MoneyEdit, ComCtrls, DBGrids, asgprint, asgprev, AdvObj,DateUtils;

type
  TFrmLogReport = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    Label2: TLabel;
    Panel5: TPanel;
    Qry1: TADOQuery;
    Ds1: TDataSource;
    AdvPreviewDialog1: TAdvPreviewDialog;
    AdvGridPrintSettingsDialog1: TAdvGridPrintSettingsDialog;
    AdvReservation: TAdvStringGrid;
    AdvGridPrintSettingsDialog2: TAdvGridPrintSettingsDialog;
    AdvPreviewDialog2: TAdvPreviewDialog;
    AdvPreviewDialog3: TAdvPreviewDialog;
    AdvGridPrintSettingsDialog3: TAdvGridPrintSettingsDialog;
    Panel1: TPanel;
    ImgList: TImage;
    LblList: TLabel;
    SpeedButton4: TSpeedButton;
    DtReservLog2: TDateTimePicker;
    DtReservLog1: TDateTimePicker;
    Panel4: TPanel;
    Label7: TLabel;
    AdvGridPrintSettingsDialog4: TAdvGridPrintSettingsDialog;
    AdvPreviewDialog4: TAdvPreviewDialog;
    AdvGridPrintSettingsDialog5: TAdvGridPrintSettingsDialog;
    AdvPreviewDialog5: TAdvPreviewDialog;
    ChkReservLogDate: TCheckBox;
    CmbKriter2: TComboBox;
    cmbKriter1: TComboBox;
    procedure FormShow(Sender: TObject);
    procedure ImgListClick(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
    procedure cmbKriter1Change(Sender: TObject);
    procedure AdvReservationGetAlignment(Sender: TObject; ARow, ACol: Integer;
      var HAlign: TAlignment; var VAlign: TVAlignment);


  private
    { Private declarations }
  public

    { Public declarations }
  end;

var
 FrmLogReport: TFrmLogReport;

implementation

uses UntGlobal, UntDlgCustomer, UntProjectGlobal;

{$R *.dfm}


procedure TFrmLogReport.AdvReservationGetAlignment(Sender: TObject; ARow,
  ACol: Integer; var HAlign: TAlignment; var VAlign: TVAlignment);
begin
//if Acol=5 then HAlign := taRightJustify;
end;

procedure TFrmLogReport.cmbKriter1Change(Sender: TObject);
var i:integer;
TmpSql:String;
begin


CmbKriter2.Clear;


if CmbKriter1.Text = 'Decription'  then begin

CmbKriter2.Items.Add('Save');
CmbKriter2.Items.Add('Edit');
CmbKriter2.Items.Add('Delete');

exit;
end;

if CmbKriter1.Text = 'Reservation No'  then Exit;

if CmbKriter1.Text = 'Users'  then
TmpSql:= 'Select username as Tmp from users order by username ' ;

if CmbKriter1.Text = 'Car Model'  then
TmpSql:='Select Distinct Model as Tmp from Car order by Model';

if CmbKriter1.Text = 'Car Reg No'  then
TmpSql:='Select RegNo as Tmp from Car order by RegNo';

Qry1.Close;
Qry1.SQL.Clear;
Qry1.SQL.Add(TmpSql);
Qry1.Open;

for i := 1 to Qry1.RecordCount do begin
CmbKriter2.Items.Add(qry1.FieldByName('Tmp').AsString) ;
qry1.Next;
end;


end;

procedure TFrmLogReport.FormShow(Sender: TObject);

begin
//  SetWindowPos(Handle, HWND_TOPMOST, Left, Top, Width, Height, SWP_NOACTIVATE or SWP_NOMOVE or SWP_NOSIZE);


DtReservLog1.Date := Date ;
DtReservLog2.Date := Date ;

end;



procedure TFrmLogReport.ImgListClick(Sender: TObject);
var TmpSql:String;
i:integer;
begin
ProgramKullanmaDurumu:=ProgramKullanmaDurumu+1;

AdvReservation.ClearRows(1,AdvReservation.RowCount-1);
AdvReservation.RowCount := 2;

AdvReservation.Cells[1,0] := 'Username';
AdvReservation.Cells[2,0] := 'Date Time';
AdvReservation.Cells[3,0] := 'Description' ;
AdvReservation.Cells[4,0] := 'Reservation No' ;
AdvReservation.Cells[5,0] := 'Car id';
AdvReservation.Cells[6,0] := 'Car Model';
AdvReservation.Cells[7,0] := 'Car Reg No' ;
AdvReservation.Cells[8,0] := 'Car Group';
AdvReservation.Cells[9,0] := 'Car Type';
AdvReservation.Cells[10,0]:= 'Customer id' ;
AdvReservation.Cells[11,0]:= 'Name' ;
AdvReservation.Cells[12,0]:= 'Surname';
AdvReservation.Cells[13,0]:= 'Local Number';
AdvReservation.Cells[14,0]:= 'Email';
AdvReservation.Cells[15,0]:= 'Collect From';
AdvReservation.Cells[16,0]:= 'Collect Date';
AdvReservation.Cells[17,0]:= 'Collect Time';
AdvReservation.Cells[18,0]:= 'Deliver To' ;
AdvReservation.Cells[19,0]:= 'Deliver Date';
AdvReservation.Cells[20,0]:= 'Deliver Time';
AdvReservation.Cells[21,0]:= 'Collect Notes';
AdvReservation.Cells[22,0]:= 'Deliver Notes';
AdvReservation.Cells[23,0]:= 'Petrol';
AdvReservation.Cells[24,0]:= 'BabySeat';
AdvReservation.Cells[25,0]:= 'BoosterSeat';
AdvReservation.Cells[26,0]:= 'Agency';
AdvReservation.Cells[27,0]:= 'Commission';
AdvReservation.Cells[28,0]:= 'DailyRate';
AdvReservation.Cells[29,0]:= 'Total';
AdvReservation.Cells[30,0]:= 'ReservationNo';
AdvReservation.Cells[31,0]:= 'Deposit';
AdvReservation.Cells[32,0]:= 'Collec Time Checked';
AdvReservation.Cells[33,0]:= 'Deliver Time Checked';
AdvReservation.Cells[34,0]:= 'Flight Number';
AdvReservation.Cells[35,0]:= 'Paid';
AdvReservation.Cells[36,0]:= 'Total Days';
AdvReservation.Cells[37,0]:= 'Paid amount exc. deposit';
AdvReservation.Cells[38,0]:= 'Outstanding Balance';

TmpSql := 'Select * from LogReservation where id<>0 ' ;

if CmbKriter1.Text = 'Decription'  then
TmpSql := TmpSql + ' and Description Like :Description ';

if CmbKriter1.Text = 'Reservation No'  then
TmpSql := TmpSql + ' and ReservationId = :ReservationId ';

if CmbKriter1.Text = 'Users'  then
TmpSql := TmpSql + ' and UserName Like :UserName ';

if CmbKriter1.Text = 'Car Model'  then
TmpSql := TmpSql + ' and CarModel Like :CarModel ';

if CmbKriter1.Text = 'Car Reg No'  then
TmpSql := TmpSql + ' and CarRegNo Like :CarRegNo ';

if ChkReservLogDate.Checked = True then
TmpSql:=TmpSql + ' and TDate between :Date1 and :Date2 ';

TmpSql:=TmpSql + ' Order By TDate desc ';

Qry1.Close;
qry1.SQL.Clear;
qry1.SQL.Add(TmpSql);

if ChkReservLogDate.Checked = True then begin
Qry1.Parameters.ParamByName('Date1').Value := IntToStr(YearOf(DtReservLog1.Date))+'-'+
                                            IntToStr(MonthOf(DtReservLog1.Date))+'-'+
                                            IntToStr(DayOf(DtReservLog1.Date));

Qry1.Parameters.ParamByName('Date2').Value := IntToStr(YearOf(DtReservLog2.Date))+'-'+
                                            IntToStr(MonthOf(DtReservLog2.Date))+'-'+
                                            IntToStr(DayOf(DtReservLog2.Date));
end;

if CmbKriter1.Text = 'Users'  then
Qry1.Parameters.ParamByName('UserName').Value := CmbKriter2.Text +'%' ;
if CmbKriter1.Text = 'Decription'  then
Qry1.Parameters.ParamByName('Description').Value := CmbKriter2.Text +'%' ;

if CmbKriter1.Text = 'Reservation No'  then begin

if CmbKriter2.Text='' then
Qry1.Parameters.ParamByName('ReservationId').Value := 0
Else
Qry1.Parameters.ParamByName('ReservationId').Value := CmbKriter2.Text;
end;

if CmbKriter1.Text = 'Car Model'  then
Qry1.Parameters.ParamByName('CarModel').Value := CmbKriter2.Text +'%' ;
if CmbKriter1.Text = 'Car Reg No'  then
Qry1.Parameters.ParamByName('CarRegNo').Value := CmbKriter2.Text +'%' ;


qry1.Prepared;
qry1.Open;

if qry1.RecordCount = 0 Then Exit;

AdvReservation.RowCount := qry1.RecordCount + 1 ;

for i:=1 to qry1.RecordCount do Begin

AdvReservation.Cells[1,i] := Qry1.FieldByName('UserName').AsString ;
AdvReservation.Cells[2,i] := Qry1.FieldByName('TDate').AsString ;
AdvReservation.Cells[3,i] := Qry1.FieldByName('Description').AsString ;
AdvReservation.Cells[4,i] := Qry1.FieldByName('ReservationId').AsString ;
AdvReservation.Cells[5,i] := Qry1.FieldByName('Carid').AsString ;
AdvReservation.Cells[6,i] := Qry1.FieldByName('CarModel').AsString ;
AdvReservation.Cells[7,i] := Qry1.FieldByName('CarRegNo').AsString ;
AdvReservation.Cells[8,i] := Qry1.FieldByName('CarGroup').AsString ;
AdvReservation.Cells[9,i] := Qry1.FieldByName('CarType').AsString ;
AdvReservation.Cells[10,i] := Qry1.FieldByName('Customerid').AsString ;
AdvReservation.Cells[11,i] := Qry1.FieldByName('Name').AsString ;
AdvReservation.Cells[12,i] := Qry1.FieldByName('Surname').AsString ;
AdvReservation.Cells[13,i] := Qry1.FieldByName('LocalNumber').AsString ;
AdvReservation.Cells[14,i] := Qry1.FieldByName('Email').AsString ;
AdvReservation.Cells[15,i] := Qry1.FieldByName('AlinacakYer').AsString ;
AdvReservation.Cells[16,i] := Qry1.FieldByName('alinacakTarih').AsString ;
AdvReservation.Cells[17,i] := Qry1.FieldByName('AlinacakSaat').AsString ;
AdvReservation.Cells[18,i] := Qry1.FieldByName('birakilacakYer').AsString ;
AdvReservation.Cells[19,i] := Qry1.FieldByName('BirakilacakTarih').AsString ;
AdvReservation.Cells[20,i] := Qry1.FieldByName('BirakilacakSaat').AsString ;
AdvReservation.Cells[21,i] := Qry1.FieldByName('AlinacakNotlar').AsString ;
AdvReservation.Cells[22,i] := Qry1.FieldByName('BirakilacakNotlar').AsString ;
AdvReservation.Cells[23,i] := Qry1.FieldByName('Petrol').AsString ;
AdvReservation.Cells[24,i] := Qry1.FieldByName('BabySeat').AsString ;
AdvReservation.Cells[25,i] := Qry1.FieldByName('BoosterSeat').AsString ;
AdvReservation.Cells[26,i] := Qry1.FieldByName('Agency').AsString ;
AdvReservation.Cells[27,i] := Qry1.FieldByName('Commission').AsString ;
AdvReservation.Cells[28,i] := Qry1.FieldByName('DailyRate').AsString ;
AdvReservation.Cells[29,i] := Qry1.FieldByName('Total').AsString ;
AdvReservation.Cells[30,i] := Qry1.FieldByName('ReservationNo').AsString ;
AdvReservation.Cells[31,i] := Qry1.FieldByName('Deposit').AsString ;
AdvReservation.Cells[32,i] := Qry1.FieldByName('CollectTimeChecked').AsString ;
AdvReservation.Cells[33,i] := Qry1.FieldByName('DeliverTimeChecked').AsString ;
AdvReservation.Cells[34,i] := Qry1.FieldByName('FlightNumber').AsString ;
AdvReservation.Cells[35,i] := Qry1.FieldByName('Paid').AsString ;
AdvReservation.Cells[36,i] := Qry1.FieldByName('TotalDays').AsString ;
AdvReservation.Cells[37,i] := Qry1.FieldByName('PaymentAmount').AsString ;
AdvReservation.Cells[38,i] := Qry1.FieldByName('OutstandingBalance').AsString ;

Qry1.Next;
End;

AdvReservation.AutoNumberCol(0);

End;



procedure TFrmLogReport.SpeedButton4Click(Sender: TObject);
begin
ProgramKullanmaDurumu:=ProgramKullanmaDurumu+1;

AdvPreviewDialog1.Execute;
end;

end.
