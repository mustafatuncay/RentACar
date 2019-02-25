unit UntBirthDayRemainder;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, jpeg, ExtCtrls, Grids, BaseGrid, AdvGrid, DB, ADODB,DateUtils,
  AdvSmoothPanel, AdvSmoothExpanderPanel, AdvObj, AdvUtil;

type
  TFrmBirthDayRemainder = class(TForm)
    Image1: TImage;
    Label7: TLabel;
    AdvList: TAdvStringGrid;
    Label1: TLabel;
    Timer1: TTimer;
    Qry1: TADOQuery;
    Image3: TImage;
    procedure Timer1Timer(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Image1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmBirthDayRemainder: TFrmBirthDayRemainder;

implementation

{$R *.dfm}

procedure TFrmBirthDayRemainder.FormShow(Sender: TObject);
begin
SetWindowPos(Handle, HWND_TOPMOST, Left, Top, Width, Height, SWP_NOACTIVATE or SWP_NOMOVE or SWP_NOSIZE);
end;

procedure TFrmBirthDayRemainder.Image1MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
 ReleaseCapture;
 self.perform(WM_SYSCOMMAND, $F012, 0);
end;

procedure TFrmBirthDayRemainder.Timer1Timer(Sender: TObject);
var i:integer;
TmpDateSeperator : String;
begin

TmpDateSeperator := FormatSettings.DateSeparator ;

AdvList.ClearRows(1,AdvList.RowCount-1);
AdvList.RowCount := 2 ;

Qry1.Close;                               //Month(BirthDate)=:Ay and BirthDate > :BirthDate
Qry1.SQL.Clear;
Qry1.SQL.Add(' Select * from Customer where BirthDate between BirthDate1 and BirthDate2 order by BirthDate ');
Qry1.Parameters.ParamByName('Ay').Value := MonthOf(date) ;
Qry1.Parameters.ParamByName('BirthDate1').Value := (Date);    // StrtoDate('01'+TmpDateSeperator+'01'+TmpDateSeperator+'1900') ;
Qry1.Parameters.ParamByName('BirthDate2').Value := (Date+3);
Qry1.Prepared;
Qry1.Open;

if Qry1.RecordCount = 0 then exit;

AdvList.RowCount := Qry1.RecordCount + 1 ;


for i:=1 to Qry1.RecordCount do begin

AdvList.Cells[1,i] := Qry1.FieldByName('BirthDate').AsString ;
AdvList.Cells[2,i] := Qry1.FieldByName('Name').AsString ;
AdvList.Cells[3,i] := Qry1.FieldByName('Surname').AsString ;

Qry1.Next;

end;


AdvList.AutoNumberCol(0);

FrmBirthDayRemainder.Height := 0;
FrmBirthDayRemainder.Show;

for i := 1 to 431 do begin

FrmBirthDayRemainder.Height := i ;

end;

end;

end.
