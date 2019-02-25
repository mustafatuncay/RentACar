unit UntAgency;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, BaseGrid, AdvGrid, Menus, DB, ADODB, StdCtrls, Buttons, jpeg, ExtCtrls, Mask,
  MoneyEdit, ComCtrls, AdvObj;

type
  TFrmAgency = class(TForm)
    Label2: TLabel;
    Panel5: TPanel;
    Qry1: TADOQuery;
    ImgSave: TImage;
    ImgDelete: TImage;
    LblSave: TLabel;
    LblDelete: TLabel;
    TxtAgency: TEdit;
    Label4: TLabel;
    LblStatus: TLabel;
    Label7: TLabel;
    a: TImage;
    AdvList: TAdvStringGrid;
    Image3: TImage;
    ImgEdit: TImage;
    LblEdit: TLabel;
    procedure ImgDeleteClick(Sender: TObject);
    procedure ImgSaveClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure AdvListDblClick(Sender: TObject);
    procedure ImgEditClick(Sender: TObject);
    procedure TxtAgencyKeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);


  private
    { Private declarations }
  public
   procedure CreateParams(var Params: TCreateParams); override;
   Procedure Listele;
    { Public declarations }
  end;

var
 FrmAgency: TFrmAgency;

implementation

uses UntGlobal, UntDlgCustomer, UntProjectGlobal;

{$R *.dfm}


procedure TFrmAgency.AdvListDblClick(Sender: TObject);
begin

TxtAgency.Tag  := StrToInt(AdvList.Cells[2,AdvList.Row]);
TxtAgency.Text := AdvList.Cells[1,AdvList.Row];

ImgEdit.Enabled    := True    ;
LblEdit.Enabled    := True    ;
LblEdit.Font.Color := clWhite ;

end;

procedure TFrmAgency.CreateParams(var Params: TCreateParams);
begin
 inherited CreateParams(Params);
  Params.ExStyle   := Params.ExStyle or WS_EX_APPWINDOW;
  Params.WndParent := GetDesktopWindow;
end;

procedure TFrmAgency.FormClose(Sender: TObject; var Action: TCloseAction);
begin
Action := caFree;
FrmAgency:= nil;
end;

procedure TFrmAgency.FormShow(Sender: TObject);
begin
  //SetWindowPos(Handle, HWND_TOPMOST, Left, Top, Width, Height, SWP_NOACTIVATE or SWP_NOMOVE or SWP_NOSIZE);
Listele;
end;

procedure TFrmAgency.ImgDeleteClick(Sender: TObject);
begin
ProgramKullanmaDurumu:=ProgramKullanmaDurumu+1;

if MsgOnay('Do you want to delete ? ') Then begin

qry1.Close;
qry1.SQL.Clear;
qry1.SQL.Add('Delete from Agency where id='''+AdvList.Cells[2,AdvList.Row]+''' ');
qry1.ExecSQL;

Listele;
LblStatus.Caption := 'Delete Successfully ...' ;
end;

end;

procedure TFrmAgency.ImgEditClick(Sender: TObject);
var TmpSqL,TmpAgencyName:String;
begin

if TxtAgency.Tag = 0 then begin
MsgUyari('Double click on the grid for update the record !!! ');
exit;
end;

if MsgOnay('This transaction will automatically change Agency in all the Records, Do you want to continue ? ') = False Then begin
exit;
end;

Qry1.Close;
Qry1.SQL.Clear;
Qry1.SQL.Add('Select AgencyName From Agency Where id=:id ') ;
Qry1.Parameters.ParamByName('id').Value := TxtAgency.Tag  ;
Qry1.Prepared;
Qry1.Open;

TmpAgencyName := Qry1.FieldByName('AgencyName').AsString;

TmpSql:='Update Agency Set AgencyName=:AgencyName ' +
'where id=:id ' ;

qry1.Close;
qry1.SQL.Clear;
qry1.SQL.Add(TmpSql);
Qry1.Parameters.ParamByName('AgencyName').Value := trim(TxtAgency.Text)     ;
Qry1.Parameters.ParamByName('id').Value := TxtAgency.Tag    ;
qry1.Prepared;
qry1.ExecSQL;



TmpSql:='Update Transfer Set AgencyName=:AgencyNameX ' +
'where AgencyName=:AgencyNameY ' ;

qry1.Close;
qry1.SQL.Clear;
qry1.SQL.Add(TmpSql);
Qry1.Parameters.ParamByName('AgencyNameX').Value := trim(TxtAgency.Text)     ;
Qry1.Parameters.ParamByName('AgencyNameY').Value := TmpAgencyName    ;
qry1.Prepared;
qry1.ExecSQL;


TmpSql:='Update Reservation Set Agency=:AgencyNameX ' +
'where Agency=:AgencyNameY ' ;

qry1.Close;
qry1.SQL.Clear;
qry1.SQL.Add(TmpSql);
Qry1.Parameters.ParamByName('AgencyNameX').Value := trim(TxtAgency.Text)     ;
Qry1.Parameters.ParamByName('AgencyNameY').Value := TmpAgencyName    ;
qry1.Prepared;
qry1.ExecSQL;

LblStatus.Caption := 'Updated Successfully ...' ;

ImgEdit.Enabled := False ;
LblEdit.Enabled := False ;
LblEdit.Font.Color := clGray;
TxtAgency.Tag := 0;

Listele;
end;

procedure TFrmAgency.ImgSaveClick(Sender: TObject);
var TmpSql:string;
begin
ProgramKullanmaDurumu:=ProgramKullanmaDurumu+1;

if trim(TxtAgency.Text) = '' Then begin
MsgUyari('Please enter Agency  !!! ');
exit;
end;

qry1.Close;
qry1.SQL.Clear;
qry1.SQL.Add('Select id from Agency where AgencyName=:AgencyName ');
Qry1.Parameters.ParamByName('AgencyName').Value    := trim(TxtAgency.Text) ;
qry1.Prepared;
qry1.open;
if qry1.RecordCount <> 0 then Begin
MsgUyari('Agency Available , Can Not Save ...');
exit;
end;


TmpSql:='insert into Agency ' +
'(AgencyName) ' +
'Values (:AgencyName)';

qry1.Close;
qry1.SQL.Clear;
qry1.SQL.Add(TmpSql);
Qry1.Parameters.ParamByName('AgencyName').Value := trim(TxtAgency.Text)     ;
qry1.Prepared;
qry1.ExecSQL;

LblStatus.Caption := 'Save Successfully ...' ;



Listele;



end;


procedure TFrmAgency.Listele;
var i:integer;
begin

AdvList.ClearRows(1,AdvList.RowCount-1);
AdvList.RowCount := 2;

qry1.Close;
qry1.SQL.Clear;
qry1.SQL.Add('Select * from Agency');
qry1.open;

if Qry1.RecordCount=0 then exit;


AdvList.RowCount := Qry1.RecordCount + 1;

for I := 1 to Qry1.RecordCount do begin
AdvList.Cells[1,i] := Qry1.FieldByName('AgencyName').AsString;
AdvList.Cells[2,i] := Qry1.FieldByName('id').AsString;

qry1.Next;
end;


AdvList.AutoNumberCol(0);

end;

procedure TFrmAgency.TxtAgencyKeyPress(Sender: TObject; var Key: Char);
begin
key  := BuyukHarf(key,Sender as Tedit);
end;

end.
