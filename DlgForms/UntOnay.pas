unit UntOnay;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, jpeg;

type
  TFrmOnay = class(TForm)
    Label1: TLabel;
    Panel1: TPanel;
    lblCaption: TLabel;
    ImgYes: TImage;
    Label2: TLabel;
    Label3: TLabel;
    ImgNo: TImage;
    procedure BtnIptalClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Image1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure ImgYesClick(Sender: TObject);
    procedure ImgNoClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
      ActOnay:Boolean;
      ActCaption:string;
  end;

var
  FrmOnay: TFrmOnay;

implementation

uses UntProjectGlobal;

{$R *.dfm}

procedure TFrmOnay.BtnIptalClick(Sender: TObject);
begin
end;
// ***
procedure TFrmOnay.FormCreate(Sender: TObject);
begin
    lblCaption.Caption:= ActCaption;
end;
// ***
procedure TFrmOnay.Image1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
ReleaseCapture;
Perform(WM_SYSCOMMAND,$F012,0);
end;

procedure TFrmOnay.FormKeyPress(Sender: TObject; var Key: Char);
begin
if key = #13 Then   Self.Close;
end;

procedure TFrmOnay.FormShow(Sender: TObject);
begin
  SetWindowPos(Handle, HWND_TOPMOST, Left, Top, Width, Height, SWP_NOACTIVATE or SWP_NOMOVE or SWP_NOSIZE);

end;

procedure TFrmOnay.ImgYesClick(Sender: TObject);
begin
ProgramKullanmaDurumu:=ProgramKullanmaDurumu+1;

  ActOnay:=True;
  Self.Close;
end;

procedure TFrmOnay.ImgNoClick(Sender: TObject);
begin
ProgramKullanmaDurumu:=ProgramKullanmaDurumu+1;

  ActOnay:=False;
  Self.Close;
end;

end.
