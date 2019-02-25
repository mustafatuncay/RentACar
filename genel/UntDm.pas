unit UntDm;

interface

uses
  SysUtils, Classes, DB, ADODB, AdvToolBar, AdvToolBarStylers;

type
  TDm = class(TDataModule)
    cnn1: TADOConnection;
    Qrylist: TADOQuery;
    Qrylist2: TADOQuery;
    QryArama: TADOQuery;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Dm: TDm;

implementation

{$R *.dfm}

end.
