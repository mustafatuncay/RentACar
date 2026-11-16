/**
 * Table names of the existing RentACar database.
 *
 * The Delphi program ran on Windows where MySQL ignores table-name case, and its SQL
 * mixes "Car"/"car", "Reservation"/"reservation". On Linux table names are case
 * sensitive. A dump taken from Windows MySQL normally contains lower-case names, so
 * lower case is used here. If your tables have other names, change them only here.
 */
export const T = {
  car: 'car',
  carExpense: 'carexpense',
  carInsurance: 'carinsurance',
  carSeyrusefer: 'carseyrusefer',
  customer: 'customer',
  reservation: 'reservation',
  transfer: 'transfer',
  agency: 'agency',
  company: 'company',
  kur: 'kur',
  sabitDegerler: 'sabitdegerler',
  users: 'users',
  logReservation: 'logreservation',
} as const;
