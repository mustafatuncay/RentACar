unit UntUyari;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, jpeg;

type
  TFrmUyari = class(TForm)
    Label1: TLabel;
    Panel1: TPanel;
    lblCaption: TLabel;
    ImgOk: TImage;
    Label2: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure Image1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure ImgOkClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
      ActCaption:string;
  end;

var
  FrmUyari: TFrmUyari;

implementation

uses UntProjectGlobal;

{$R *.dfm}


// ***
procedure TFrmUyari.FormCreate(Sender: TObject);
begin
  lblCaption.Caption:= ActCaption;
end;
// ***
procedure TFrmUyari.Image1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
ReleaseCapture;
Perform(WM_SYSCOMMAND,$F012,0);
end;

procedure TFrmUyari.FormKeyPress(Sender: TObject; var Key: Char);
begin
if key = #13 Then   Self.Close;
end;

procedure TFrmUyari.FormShow(Sender: TObject);
begin
SetWindowPos(Handle, HWND_TOPMOST, Left, Top, Width, Height, SWP_NOACTIVATE or SWP_NOMOVE or SWP_NOSIZE);

end;

procedure TFrmUyari.ImgOkClick(Sender: TObject);
begin
ProgramKullanmaDurumu:=ProgramKullanmaDurumu+1;

Self.Close;
end;

end.
