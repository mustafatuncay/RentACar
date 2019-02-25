unit UntSabitDegerler;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Grids, AdvObj, BaseGrid, AdvGrid, DB, ADODB,
  MoneyEdit, ComCtrls;

type
  TFrmSabitDegerler = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    Qry1: TADOQuery;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    Panel2: TPanel;
    Button1: TButton;
    Button4: TButton;
    AdvListe: TAdvStringGrid;
    TxtKriter: TEdit;
    CmbKriter: TComboBox;
    procedure Button1Click(Sender: TObject);
    procedure CmbKriterChange(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    procedure KayitGetir;
    procedure CreateParams(var Params: TCreateParams); override;
    { Public declarations }
  end;

var
  FrmSabitDegerler: TFrmSabitDegerler;

implementation

uses UntGlobal;

{$R *.dfm}

procedure TFrmSabitDegerler.Button1Click(Sender: TObject);
var TmpSql:string;
begin

TmpSql := 'insert into sabitdegerler (kriterno,kriter,aciklama) Values(:kriterno,:kriter,:aciklama) ' ;

Qry1.Close;
Qry1.SQL.Clear;
Qry1.SQL.Add(TmpSql);
Qry1.Parameters.ParamByName('kriterno').Value := CmbKriter.ItemIndex;
Qry1.Parameters.ParamByName('kriter').Value := CmbKriter.Text;
Qry1.Parameters.ParamByName('aciklama').Value := Trim(TxtKriter.Text);
Qry1.Prepared;
Qry1.ExecSQL;

KayitGetir;


end;

procedure TFrmSabitDegerler.Button4Click(Sender: TObject);
var TmpSql:string;
begin

TmpSql := 'Delete from sabitdegerler where id=:id' ;

Qry1.Close;
Qry1.SQL.Clear;
Qry1.SQL.Add(TmpSql);
Qry1.Parameters.ParamByName('id').Value := AdvListe.Cells[2,AdvListe.Row];
Qry1.Prepared;
Qry1.ExecSQL;

KayitGetir;
end;

procedure TFrmSabitDegerler.CmbKriterChange(Sender: TObject);
begin
//KayitGetir;
end;

procedure TFrmSabitDegerler.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  Params.ExStyle   := Params.ExStyle or WS_EX_APPWINDOW;
  Params.WndParent := GetDesktopWindow;

end;

procedure TFrmSabitDegerler.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
Action := caFree;
FrmSabitDegerler:= nil;
end;

procedure TFrmSabitDegerler.KayitGetir;
var TmpSql:string;
i:integer;
begin

AdvListe.ClearRows(1,AdvListe.RowCount-1);
AdvListe.RowCount := 2 ;

TmpSql := 'select * from sabitdegerler where kriterno=:kriterno order by aciklama ' ;

Qry1.Close;
Qry1.SQL.Clear;
Qry1.SQL.Add(TmpSql);
Qry1.Parameters.ParamByName('kriterno').Value := CmbKriter.ItemIndex ;
Qry1.Prepared;
Qry1.Open;

if Qry1.RecordCount=0 then exit;

AdvListe.RowCount := Qry1.RecordCount + 1 ;

for i:=1 to Qry1.RecordCount do begin
AdvListe.Cells[1,i]:= Qry1.FieldByName('aciklama').AsString;
AdvListe.Cells[2,i]:= Qry1.FieldByName('id').AsString;
Qry1.Next;
end;

AdvListe.AutoNumberCol(0);

end;

end.
