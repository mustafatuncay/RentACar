unit UntCompany;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, BaseGrid, AdvGrid, Menus, DB, ADODB, StdCtrls, Buttons, jpeg, ExtCtrls, Mask,
  MoneyEdit, ComCtrls, AdvObj;

type
  TFrmCompany = class(TForm)
    Label2: TLabel;
    Panel5: TPanel;
    Qry1: TADOQuery;
    ImgSave: TImage;
    ImgDelete: TImage;
    LblSave: TLabel;
    LblDelete: TLabel;
    TxtCompany: TEdit;
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
    procedure TxtCompanyKeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);


  private
    { Private declarations }
  public
   procedure CreateParams(var Params: TCreateParams); override;
   Procedure Listele;
    { Public declarations }
  end;

var
 FrmCompany: TFrmCompany;

implementation

uses UntGlobal, UntDlgCustomer, UntProjectGlobal;

{$R *.dfm}


procedure TFrmCompany.AdvListDblClick(Sender: TObject);
begin

TxtCompany.Tag  := StrToInt(AdvList.Cells[2,AdvList.Row]);
TxtCompany.Text := AdvList.Cells[1,AdvList.Row];

ImgEdit.Enabled    := True    ;
LblEdit.Enabled    := True    ;
LblEdit.Font.Color := clWhite ;

end;

procedure TFrmCompany.CreateParams(var Params: TCreateParams);
begin
 inherited CreateParams(Params);
  Params.ExStyle   := Params.ExStyle or WS_EX_APPWINDOW;
  Params.WndParent := GetDesktopWindow;
end;

procedure TFrmCompany.FormClose(Sender: TObject; var Action: TCloseAction);
begin
Action := caFree;
FrmCompany:= nil;
end;

procedure TFrmCompany.FormShow(Sender: TObject);
begin
  //SetWindowPos(Handle, HWND_TOPMOST, Left, Top, Width, Height, SWP_NOACTIVATE or SWP_NOMOVE or SWP_NOSIZE);
Listele;
end;

procedure TFrmCompany.ImgDeleteClick(Sender: TObject);
begin
ProgramKullanmaDurumu:=ProgramKullanmaDurumu+1;

if MsgOnay('Do you want to delete ? ') Then begin

qry1.Close;
qry1.SQL.Clear;
qry1.SQL.Add('Delete from Company where id='''+AdvList.Cells[2,AdvList.Row]+''' ');
qry1.ExecSQL;

Listele;
LblStatus.Caption := 'Delete Successfully ...' ;
end;

end;

procedure TFrmCompany.ImgEditClick(Sender: TObject);
var TmpSqL,TmpCompanyName:String;
begin

if TxtCompany.Tag = 0 then begin
MsgUyari('Double click on the grid for update the record !!! ');
exit;
end;

if MsgOnay('This transaction will automatically change Company in all the Records, Do you want to continue ? ') = False Then begin
exit;
end;

Qry1.Close;
Qry1.SQL.Clear;
Qry1.SQL.Add('Select CompanyName From Companay Where id=:id ') ;
Qry1.Parameters.ParamByName('id').Value := TxtCompany.Tag  ;
Qry1.Prepared;
Qry1.Open;

TmpCompanyName := Qry1.FieldByName('CompanyName').AsString;

TmpSql:='Update Company Set CompanyName=:CompanyName ' +
'where id=:id ' ;

qry1.Close;
qry1.SQL.Clear;
qry1.SQL.Add(TmpSql);
Qry1.Parameters.ParamByName('CompanyName').Value := trim(TxtCompany.Text)     ;
Qry1.Parameters.ParamByName('id').Value := TxtCompany.Tag    ;
qry1.Prepared;
qry1.ExecSQL;



TmpSql:='Update Transfer Set CompanyName=:CompanyNameX ' +
'where CompanyName=:CompanyNameY ' ;

qry1.Close;
qry1.SQL.Clear;
qry1.SQL.Add(TmpSql);
Qry1.Parameters.ParamByName('CompanyNameX').Value := trim(TxtCompany.Text)     ;
Qry1.Parameters.ParamByName('CompanyNameY').Value := TmpCompanyName    ;
qry1.Prepared;
qry1.ExecSQL;


TmpSql:='Update Reservation Set Company=:CompanyNameX ' +
'where Company=:CompanyNameY ' ;

qry1.Close;
qry1.SQL.Clear;
qry1.SQL.Add(TmpSql);
Qry1.Parameters.ParamByName('CompanyNameX').Value := trim(TxtCompany.Text)     ;
Qry1.Parameters.ParamByName('CompanyNameY').Value := TmpCompanyName    ;
qry1.Prepared;
qry1.ExecSQL;

LblStatus.Caption := 'Updated Successfully ...' ;

ImgEdit.Enabled := False ;
LblEdit.Enabled := False ;
LblEdit.Font.Color := clGray;
TxtCompany.Tag := 0;

Listele;
end;

procedure TFrmCompany.ImgSaveClick(Sender: TObject);
var TmpSql:string;
begin
ProgramKullanmaDurumu:=ProgramKullanmaDurumu+1;

if trim(TxtCompany.Text) = '' Then begin
MsgUyari('Please enter Company  !!! ');
exit;
end;

qry1.Close;
qry1.SQL.Clear;
qry1.SQL.Add('Select id from Company where CompanyName=:CompanyName ');
Qry1.Parameters.ParamByName('CompanyName').Value    := trim(TxtCompany.Text) ;
qry1.Prepared;
qry1.open;
if qry1.RecordCount <> 0 then Begin
MsgUyari('Company Available , Can Not Save ...');
exit;
end;


TmpSql:='insert into Company ' +
'(CompanyName) ' +
'Values (:CompanyName)';

qry1.Close;
qry1.SQL.Clear;
qry1.SQL.Add(TmpSql);
Qry1.Parameters.ParamByName('CompanyName').Value := trim(TxtCompany.Text)     ;
qry1.Prepared;
qry1.ExecSQL;

LblStatus.Caption := 'Save Successfully ...' ;



Listele;



end;


procedure TFrmCompany.Listele;
var i:integer;
begin

AdvList.ClearRows(1,AdvList.RowCount-1);
AdvList.RowCount := 2;

qry1.Close;
qry1.SQL.Clear;
qry1.SQL.Add('Select * from Company');
qry1.open;

if Qry1.RecordCount=0 then exit;


AdvList.RowCount := Qry1.RecordCount + 1;

for I := 1 to Qry1.RecordCount do begin
AdvList.Cells[1,i] := Qry1.FieldByName('CompanyName').AsString;
AdvList.Cells[2,i] := Qry1.FieldByName('id').AsString;

qry1.Next;
end;


AdvList.AutoNumberCol(0);

end;

procedure TFrmCompany.TxtCompanyKeyPress(Sender: TObject; var Key: Char);
begin
key  := BuyukHarf(key,Sender as Tedit);
end;

end.
