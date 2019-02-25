unit RepReservation;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, QuickRpt, QRCtrls, qrpctrls;

type
  TQRepReservation = class(TQuickRep)
    QRBand1: TQRBand;
    QRBand2: TQRBand;
    QRLabel1: TQRLabel;
    QrlTarih: TQRLabel;
    QRShape1: TQRShape;
    QRLabel7: TQRLabel;
    QRLabel36: TQRLabel;
    QRLabel37: TQRLabel;
    QRLabel38: TQRLabel;
    QRLabel39: TQRLabel;
    QRLabel40: TQRLabel;
    QRLabel41: TQRLabel;
    QRLabel43: TQRLabel;
    QRLabel42: TQRLabel;
    QRLabel44: TQRLabel;
    QRLabel45: TQRLabel;
    QRLabel46: TQRLabel;
    QRShape8: TQRShape;
    QRLabel50: TQRLabel;
    QRLabel49: TQRLabel;
    QRLabel48: TQRLabel;
    QRLabel47: TQRLabel;
    QRShape9: TQRShape;
    QRLabel51: TQRLabel;
    QrlPickupDateDeliver: TQRLabel;
    QRLabel53: TQRLabel;
    QRLabel54: TQRLabel;
    QrlPickUpTimeDeliver: TQRLabel;
    QrlPickUpPaxs: TQRLabel;
    QRShape10: TQRShape;
    QRLabel56: TQRLabel;
    QrlDropOffDateDeliver: TQRLabel;
    QRLabel58: TQRLabel;
    QRLabel59: TQRLabel;
    QrlDropOffTimeDeliver: TQRLabel;
    QrlDropOffPaxs: TQRLabel;
    QRLabel62: TQRLabel;
    QRShape11: TQRShape;
    QRLabel63: TQRLabel;
    QRLabel64: TQRLabel;
    Reg: TQRLabel;
    QRShape12: TQRShape;
    QRLabel65: TQRLabel;
    QRLabel67: TQRLabel;
    QRLabel68: TQRLabel;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel66: TQRLabel;
    QRLabel5: TQRLabel;
    QRLabel6: TQRLabel;
    QRLabel8: TQRLabel;
    QRLabel9: TQRLabel;
    QRShape2: TQRShape;
    QRLabel10: TQRLabel;
    QRLabel11: TQRLabel;
    QRLabel12: TQRLabel;
    QRLabel13: TQRLabel;
    QRLabel14: TQRLabel;
    QRLabel15: TQRLabel;
    QRLabel16: TQRLabel;
    QRLabel17: TQRLabel;
    QRLabel18: TQRLabel;
    QRLabel19: TQRLabel;
    QRLabel20: TQRLabel;
    QRLabel21: TQRLabel;
    QRLabel22: TQRLabel;
    QRLabel23: TQRLabel;
    QRLabel24: TQRLabel;
    QRLabel25: TQRLabel;
    QRShape3: TQRShape;
    QRLabel26: TQRLabel;
    QRLabel27: TQRLabel;
    QRLabel28: TQRLabel;
    QRLabel29: TQRLabel;
    QRLabel30: TQRLabel;
    QRLabel31: TQRLabel;
    QRLabel32: TQRLabel;
    QRLabel33: TQRLabel;
    QRLabel34: TQRLabel;
    QRLabel69: TQRLabel;
    QRLabel70: TQRLabel;
    QRShape4: TQRShape;
    QRShape5: TQRShape;
    QRLabel71: TQRLabel;
    QRLabel72: TQRLabel;
    QRLabel73: TQRLabel;
    QRLabel74: TQRLabel;
    QRShape6: TQRShape;
    QRLabel75: TQRLabel;
    QrlReservarionNo: TQRLabel;
    QrlFlightNumber: TQRLabel;
    QrlFlightTime: TQRLabel;
    QrlRoomNo: TQRLabel;
    QrlCurrency: TQRLabel;
    QrlContactNumber: TQRLabel;
    QrlNotes: TQRLabel;
    QrlVoutcherNo: TQRLabel;
    QrlDeliverTo: TQRLabel;
    QrlDeliverDateandTime: TQRLabel;
    QrlDeliverNotes: TQRLabel;
    QrlCollectDateandTime: TQRLabel;
    QrlCollectFrom: TQRLabel;
    QrlCollectNotes: TQRLabel;
    QrlDropOffFlightTime: TQRLabel;
    QrlPickUpFrom: TQRLabel;
    QrlPickUpTo: TQRLabel;
    QrlDropOfFrom: TQRLabel;
    QrlDropOfTo: TQRLabel;
    QrlCarModel: TQRLabel;
    QrlCarRegNo: TQRLabel;
    QrlSurname: TQRLabel;
    QrlCustomerContactNumber: TQRLabel;
    QrlPassportNo: TQRLabel;
    QrlDrivingLicense: TQRLabel;
    QrlPlaceOfBirth: TQRLabel;
    QrlName: TQRLabel;
    QrlAgency: TQRLabel;
    QrlLessInsurance: TQRLabel;
    QrlCommission: TQRLabel;
    QrlTotalCommission: TQRLabel;
    QrlCases: TQRLabel;
    QrlInfantSeat: TQRLabel;
    QrlBabySeat: TQRLabel;
    QrlBoosterSeat: TQRLabel;
    QrlLowSeasonRate: TQRLabel;
    QrlMidSeasonRate: TQRLabel;
    QrlExtensionRate: TQRLabel;
    QrlHighSeasonRate: TQRLabel;
    QrlInsuranceRate: TQRLabel;
    QrlLowSeasonDays: TQRLabel;
    QrlMidSeasonDays: TQRLabel;
    QrlExtensionDays: TQRLabel;
    QrlHighSeasonDays: TQRLabel;
    QrlTotalDays: TQRLabel;
    QrlLowseasonTotal: TQRLabel;
    QrlMidSeasonTotal: TQRLabel;
    QrlExtensionTotal: TQRLabel;
    QrlHighSeasonTotal: TQRLabel;
    QrlTotalInsurance: TQRLabel;
    QrlPetrol: TQRLabel;
    QrlExtra: TQRLabel;
    QrlTaxiDropOff: TQRLabel;
    QrlTaxiPickUp: TQRLabel;
    QrlTotalAmount: TQRLabel;
    QrlPaidAmount3: TQRLabel;
    QrlOutsBalance: TQRLabel;
    QrlPaidAmount4: TQRLabel;
    QrlPaidAmount2: TQRLabel;
    QrlPaidAmount1: TQRLabel;
    QrlDiscount: TQRLabel;
    QrlPaidNote1: TQRLabel;
    QrlPaidNote2: TQRLabel;
    QrlPaidNote3: TQRLabel;
    QrlPaidNote4: TQRLabel;
    QrlPaymentMethod2: TQRLabel;
    QrlPaymentMethod4: TQRLabel;
    QrlPaymentMethod3: TQRLabel;
    QrlPaymentMethod1: TQRLabel;
    QRLabel35: TQRLabel;
    QRLabel52: TQRLabel;
    QRLCompany: TQRLabel;
    QRLCompanyIncome: TQRLabel;
  private

  public

  end;

var
  QRepReservation: TQRepReservation;

implementation

uses UntReservation2;



{$R *.DFM}

end.
