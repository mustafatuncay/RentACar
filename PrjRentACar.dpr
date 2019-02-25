program PrjRentACar;

uses
  Forms,
  UntDm in 'genel\UntDm.pas' {Dm: TDataModule},
  UntAdmin in 'UntAdmin.pas' {FrmAdmin},
  UntGlobal in 'genel\UntGlobal.pas',
  UntOnay in 'DlgForms\UntOnay.pas' {FrmOnay},
  UntUyari in 'DlgForms\UntUyari.pas' {FrmUyari},
  UntReservation2 in 'UntReservation2.pas' {FrmReservation2},
  UntTimeTable in 'UntTimeTable.pas' {FrmTimeTable},
  UntDlgCar in 'DlgForms\UntDlgCar.pas' {FrmDlgCar},
  UntDlgTransaction in 'DlgForms\UntDlgTransaction.pas' {FrmDlgTransaction},
  UntDlgReservation in 'DlgForms\UntDlgReservation.pas' {FrmDlgReservation},
  UntProjectGlobal in 'genel\UntProjectGlobal.pas',
  UntMenux in 'UntMenux.pas' {FrmMenux},
  UntCarList in 'UntCarList.pas' {FrmCarList},
  UntTransfers in 'UntTransfers.pas' {FrmTransfers},
  UntCompany in 'UntCompany.pas' {FrmCompany},
  UntDlgCustomer in 'DlgForms\UntDlgCustomer.pas' {FrmDlgCustomer},
  UntLogReports in 'UntLogReports.pas' {FrmLogReport},
  UntLogin in 'UntLogin.pas' {FrmLogin},
  UntKur in 'UntKur.pas' {FrmKur},
  RepTransfer in 'Reports\RepTransfer.pas' {QRepTransfers: TQuickRep},
  UntBirthDayRemainder in 'UntBirthDayRemainder.pas' {FrmBirthDayRemainder},
  UntReports in 'UntReports.pas' {FrmReports},
  RepReservation in 'Reports\RepReservation.pas' {QRepReservation: TQuickRep},
  UntCar in 'UntCar.pas' {FrmCar},
  UntCustomer in 'UntCustomer.pas' {FrmCustomer},
  UntSabitDegerler in 'UntSabitDegerler.pas' {FrmSabitDegerler},
  UntKontrol in 'Kontrol\UntKontrol.pas' {FrmKontrol},
  UntAgency in 'UntAgency.pas' {FrmAgency},
  UntDlgTransfer in 'DlgForms\UntDlgTransfer.pas' {FrmDlgTransfer};

{$R *.res}
begin
  Application.Initialize;
  Application.CreateForm(TDm, Dm);
  Application.CreateForm(TFrmLogin, FrmLogin);
  Application.CreateForm(TFrmBirthDayRemainder, FrmBirthDayRemainder);
  Application.CreateForm(TQRepReservation, QRepReservation);
  Application.CreateForm(TQRepTransfers, QRepTransfers);
  Application.CreateForm(TFrmKontrol, FrmKontrol);
  Application.CreateForm(TFrmDlgTransfer, FrmDlgTransfer);
  Application.Run;
end.
