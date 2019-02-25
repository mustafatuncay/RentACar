unit UntAdmin;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, BaseGrid, AdvGrid, Menus, DB, ADODB, StdCtrls, Buttons, jpeg, ExtCtrls, Mask,
  MoneyEdit, ComCtrls, CheckLst, DBGrids;

type
  TFrmAdmin = class(TForm)
    Panel5: TPanel;
    ImgEdit: TImage;
    ImgDelete: TImage;
    ImgNew: TImage;
    LblEdit: TLabel;
    LblDelete: TLabel;
    Label6: TLabel;
    LblStatus: TLabel;
    Panel4: TPanel;
    Label4: TLabel;
    Label11: TLabel;
    Label3: TLabel;
    Label5: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    txtusername: TEdit;
    txtduty: TEdit;
    chklstprivilege: TCheckListBox;
    memdesc: TMemo;
    txtpassword: TEdit;
    txtrepassword: TEdit;
    DBGrid1: TDBGrid;
    Image2: TImage;
    Label22: TLabel;
    Qry1: TADOQuery;
    Ds1: TDataSource;
    Button1: TButton;
    Qry2: TADOQuery;
    Qry3: TADOQuery;
    ImgSave: TImage;
    LblSave: TLabel;
    ImgLogReport: TImage;
    LblLogReport: TLabel;
    Button2: TButton;
    Image3: TImage;
    procedure FormShow(Sender: TObject);
    procedure ImgSaveClick(Sender: TObject);
    procedure ImgEditClick(Sender: TObject);
    procedure ImgDeleteClick(Sender: TObject);
    procedure ImgNewClick(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure ImgLogReportClick(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);


  private
    { Private declarations }
  public
    procedure CreateParams(var Params: TCreateParams); override;
    Procedure temizle();
    { Public declarations }
  end;

var
 FrmAdmin: TFrmAdmin;

implementation

uses UntGlobal, UntDlgCustomer, UntLogReports, UntProjectGlobal;

{$R *.dfm}


procedure TFrmAdmin.Button1Click(Sender: TObject);
var i:integer;
begin

qry1.Close;
qry1.SQL.Clear;
Qry1.SQL.Add('Select Customerid from reservation order by id') ;
qry1.Open;

for i:=0 to Qry1.RecordCount-1 do begin



qry2.Close;
qry2.SQL.Clear;
Qry2.SQL.Add('Select Name2,Surname2,email from Customer where id=:Customerid ') ;
qry2.Parameters.ParamByName('Customerid').Value := qry1.FieldByName('Customerid').AsString ;
qry2.Prepared;
qry2.Open;


  qry3.Close;
  qry3.SQL.Clear;
  Qry3.SQL.Add('Update Reservation set Name2=:Name2, Surname2=:Surname2, email=:email where Customerid=:Customerid  ') ;
  qry3.Parameters.ParamByName('Name2').Value        := qry2.FieldByName('Name2').AsString ;
  qry3.Parameters.ParamByName('Surname2').Value     := qry2.FieldByName('Surname2').AsString ;
  qry3.Parameters.ParamByName('email').Value        := qry2.FieldByName('email').AsString ;
  qry3.Parameters.ParamByName('Customerid').Value   := qry1.FieldByName('Customerid').AsString ;
  qry3.Prepared ;
  qry3.ExecSQL;



Qry1.Next;
end;

end;

procedure TFrmAdmin.Button2Click(Sender: TObject);
var i:integer;
begin

qry1.Close;
qry1.SQL.Clear;
Qry1.SQL.Add('Select * from Car order by id') ;
qry1.Open;

for i:=1 to Qry1.RecordCount do begin
  qry3.Close;
  qry3.SQL.Clear;
  Qry3.SQL.Add('Update reservation Set CarModel=:CarModel,CarRegNo=:CarRegNo where Carid=:Carid ') ;
  qry3.Parameters.ParamByName('CarModel').Value := qry1.FieldByName('Model').AsString        ;
  qry3.Parameters.ParamByName('CarRegNo').Value := qry1.FieldByName('RegNo').AsString     ;
  qry3.Parameters.ParamByName('Carid').Value    := qry1.FieldByName('id').AsString ;
  qry3.Prepared ;
  qry3.ExecSQL;

Qry1.Next;
End;


end;

procedure TFrmAdmin.CreateParams(var Params: TCreateParams);
begin
 inherited CreateParams(Params);
  Params.ExStyle   := Params.ExStyle or WS_EX_APPWINDOW;
  Params.WndParent := GetDesktopWindow;
end;

procedure TFrmAdmin.DBGrid1DblClick(Sender: TObject);
begin
temizle;
txtusername.Tag    := Qry1.fieldbyname('id').Value       ;
txtusername.Text   := Qry1.fieldbyname('username').Value ;
txtpassword.Text   := Qry1.fieldbyname('password').Value ;
txtrepassword.Text := Qry1.fieldbyname('password').Value ;
txtduty.Text := Qry1.fieldbyname('duty').Value ;
memdesc.Text := Qry1.fieldbyname('description').Value ;

if Qry1.fieldbyname('PCarEntry').Value = 1 Then
   chklstprivilege.Checked[0] := TRue
Else chklstprivilege.Checked[0] := False;

if Qry1.fieldbyname('PTimeTable').Value  = 1  Then
   chklstprivilege.Checked[1] := True
else chklstprivilege.Checked[1] := False;

if Qry1.fieldbyname('PCustomerEntry').Value = 1  Then
   chklstprivilege.Checked[2] := True
else chklstprivilege.Checked[2] := False;

if Qry1.fieldbyname('PReports').Value = 1  Then
   chklstprivilege.Checked[3] := True
else chklstprivilege.Checked[3] := False;

if Qry1.fieldbyname('PTransfers').Value = 1 Then
   chklstprivilege.Checked[4] := True
else chklstprivilege.Checked[4] := False;

if Qry1.fieldbyname('PAdmin').Value = 1 Then
   chklstprivilege.Checked[5] := True
else chklstprivilege.Checked[5] := False;

if Qry1.fieldbyname('PAgency').Value = 1 Then
   chklstprivilege.Checked[6] := True
else chklstprivilege.Checked[6] := False;


ImgSave.Enabled     := False;
LblSave.Font.Color  := clGray ;
LblSave.Enabled     := False;

ImgDelete.Enabled   := True;
LblDelete.Font.Color:= clWhite ;
LblDelete.Enabled   := True;

ImgEdit.Enabled     := True;
LblEdit.Font.Color  := clWhite ;
LblEdit.Enabled     := True;


LblStatus.Caption := 'You Can Edit / Delete Client ';

end;

procedure TFrmAdmin.FormClose(Sender: TObject; var Action: TCloseAction);
begin
Action := caFree;
FrmAdmin:= nil;
end;

procedure TFrmAdmin.FormShow(Sender: TObject);
begin
//  SetWindowPos(Handle, HWND_TOPMOST, Left, Top, Width, Height, SWP_NOACTIVATE or SWP_NOMOVE or SWP_NOSIZE);
qry1.Close;
qry1.SQL.Clear;
Qry1.SQL.Add('Select * from users') ;
qry1.Open;

end;

procedure TFrmAdmin.ImgLogReportClick(Sender: TObject);
begin
ProgramKullanmaDurumu:=ProgramKullanmaDurumu+1;

FrmLogReport:=TFrmLogReport.Create(self);
FrmLogReport.ShowModal;
FrmLogReport.Free;
end;

procedure TFrmAdmin.ImgDeleteClick(Sender: TObject);
begin
ProgramKullanmaDurumu:=ProgramKullanmaDurumu+1;

qry1.Close;
qry1.SQL.Clear;
qry1.SQL.Add('delete from users where id = '''+inttostr(txtusername.Tag)+''' ');
Qry1.ExecSQL;

qry1.Close;
qry1.SQL.Clear;
Qry1.SQL.Add('Select * from users') ;
qry1.Open;

temizle;

LblStatus.Caption := 'User Deleted' ;

end;

procedure TFrmAdmin.ImgEditClick(Sender: TObject);
var TmpSql:string;
begin
ProgramKullanmaDurumu:=ProgramKullanmaDurumu+1;

if txtusername.Text = '' Then begin
MsgUyari('Please enter username !!!');
exit;
end;

if txtpassword.Text = '' Then begin
MsgUyari('Please enter password !!!');
exit;
end;

if txtpassword.Text <> txtrepassword.Text Then begin
MsgUyari('Passwords are not matching !!!');
exit;
end;

TmpSql := 'update users set  ' +
' username=:username,password=:password,duty=:duty,description=:description,PCarEntry=:PCarEntry,PTimeTable=:PTimeTable,'+
'PCustomerEntry=:PCustomerEntry,PReports=:PReports,PTransfers=:PTransfers,PAdmin=:PAdmin,PAgency=:PAgency '+
' where id = '''+inttostr(txtusername.Tag)+''' ' ;

qry1.Close;
qry1.SQL.Clear;
qry1.SQL.Add(TmpSql);
Qry1.Parameters.ParamByName('username').Value := txtusername.Text ;
Qry1.Parameters.ParamByName('password').Value := txtpassword.Text ;
Qry1.Parameters.ParamByName('duty').Value := txtduty.Text ;
Qry1.Parameters.ParamByName('description').Value := memdesc.Text ;

if chklstprivilege.Checked[0] Then
Qry1.Parameters.ParamByName('PCarEntry').Value    := '1'
Else Qry1.Parameters.ParamByName('PCarEntry').Value := '0';

if chklstprivilege.Checked[1] Then
Qry1.Parameters.ParamByName('PTimeTable').Value  := '1'
else Qry1.Parameters.ParamByName('PTimeTable').Value  := '0';

if chklstprivilege.Checked[2] Then
Qry1.Parameters.ParamByName('PCustomerEntry').Value := '1'
else Qry1.Parameters.ParamByName('PCustomerEntry').Value := '0' ;

if chklstprivilege.Checked[3] Then
Qry1.Parameters.ParamByName('PReports').Value := '1'
else Qry1.Parameters.ParamByName('PReports').Value := '0';

if chklstprivilege.Checked[4] Then
Qry1.Parameters.ParamByName('PTransfers').Value := '1'
else Qry1.Parameters.ParamByName('PTransfers').Value := '0';

if chklstprivilege.Checked[5] Then
Qry1.Parameters.ParamByName('PAdmin').Value := '1'
else Qry1.Parameters.ParamByName('PAdmin').Value := '0';

if chklstprivilege.Checked[6] Then
Qry1.Parameters.ParamByName('PAgency').Value := '1'
else Qry1.Parameters.ParamByName('PAgency').Value := '0';

qry1.Prepared;
qry1.ExecSQL;

LblStatus.Caption := 'User Edited' ;

qry1.Close;
qry1.SQL.Clear;
Qry1.SQL.Add('Select * from users') ;
qry1.Open;

end;


procedure TFrmAdmin.ImgNewClick(Sender: TObject);
begin
ProgramKullanmaDurumu:=ProgramKullanmaDurumu+1;
temizle;
end;

procedure TFrmAdmin.ImgSaveClick(Sender: TObject);
var TmpSql:string;
begin
ProgramKullanmaDurumu:=ProgramKullanmaDurumu+1;

if txtusername.Text = '' Then begin
MsgUyari('Please enter username !!!');
exit;
end;

if txtpassword.Text = '' Then begin
MsgUyari('Please enter password !!!');
exit;
end;

if txtpassword.Text <> txtrepassword.Text Then begin
MsgUyari('Passwords are not matching !!!');
exit;
end;

qry1.Close;
qry1.SQL.Clear;
Qry1.SQL.Add('select * from users where username = '''+txtusername.Text+''' ');
Qry1.Open;
if qry1.RecordCount <> 0 Then Begin
MsgUyari('Usernames can not be same, Please try another username !!! ');
exit;
end;

TmpSql := 'insert into users (username,password,duty,description,PCarEntry,PTimeTable,PCustomerEntry,PReports,PTransfers,PAdmin,PAgency) ' +
'Values (:username,:password,:duty,:description,:PCarEntry,:PTimeTable,:PCustomerEntry,:PReports,:PTransfers,:PAdmin,:PAgency) ';

qry1.Close;
qry1.SQL.Clear;
qry1.SQL.Add(TmpSql);
Qry1.Parameters.ParamByName('username').Value := txtusername.Text ;
Qry1.Parameters.ParamByName('password').Value := txtpassword.Text ;
Qry1.Parameters.ParamByName('duty').Value := txtduty.Text ;
Qry1.Parameters.ParamByName('description').Value := memdesc.Text ;

if chklstprivilege.Checked[0] Then
Qry1.Parameters.ParamByName('PCarEntry').Value    := '1'
Else Qry1.Parameters.ParamByName('PCarEntry').Value := '0';

if chklstprivilege.Checked[1] Then
Qry1.Parameters.ParamByName('PTimeTable').Value  := '1'
else Qry1.Parameters.ParamByName('PTimeTable').Value  := '0';

if chklstprivilege.Checked[2] Then
Qry1.Parameters.ParamByName('PCustomerEntry').Value := '1'
else Qry1.Parameters.ParamByName('PCustomerEntry').Value :='0' ;

if chklstprivilege.Checked[3] Then
Qry1.Parameters.ParamByName('PReports').Value := '1'
else Qry1.Parameters.ParamByName('PReports').Value := '0';

if chklstprivilege.Checked[4] Then
Qry1.Parameters.ParamByName('PTransfers').Value := '1'
else Qry1.Parameters.ParamByName('PTransfers').Value := '0';

if chklstprivilege.Checked[5] Then
Qry1.Parameters.ParamByName('PAdmin').Value := '1'
else Qry1.Parameters.ParamByName('PAdmin').Value := '0';

if chklstprivilege.Checked[6] Then
Qry1.Parameters.ParamByName('PAgency').Value := '1'
else Qry1.Parameters.ParamByName('PAgency').Value := '0';

qry1.Prepared;
qry1.ExecSQL;

LblStatus.Caption := 'User Saved' ;

qry1.Close;
qry1.SQL.Clear;
Qry1.SQL.Add('Select * from users') ;
qry1.Open;
end;

procedure TFrmAdmin.temizle;
begin

txtusername.Clear;
txtpassword.Clear;
txtrepassword.Clear;
txtduty.Clear;
memdesc.clear;

chklstprivilege.Checked[0]:=False;
chklstprivilege.Checked[1]:=False;
chklstprivilege.Checked[2]:=False;
chklstprivilege.Checked[3]:=False;
chklstprivilege.Checked[4]:=False;
chklstprivilege.Checked[5]:=False;
chklstprivilege.Checked[6]:=False;


ImgSave.Enabled     := True;
LblSave.Font.Color  := clWhite ;
LblSave.Enabled     := True;

ImgDelete.Enabled   := False;
LblDelete.Font.Color:= clGray ;
LblDelete.Enabled   := False;

ImgEdit.Enabled     := False;
LblEdit.Font.Color  := clGray ;
LblEdit.Enabled     := False;

LblStatus.Caption := 'You Can Add New Client ';

end;

end.
