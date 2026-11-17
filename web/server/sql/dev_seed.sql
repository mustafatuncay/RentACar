-- SAMPLE DATA FOR THE TEST ENVIRONMENT (Codespaces) ONLY.
-- Do NOT run on the real database. Dates are relative to the day the database is created.

INSERT INTO agency (AgencyName) VALUES ('Sunny Tours'), ('Cyprus Holidays'), ('Blue Sea Travel');
INSERT INTO company (CompanyName) VALUES ('Partner Rent Ltd');
INSERT INTO sabitdegerler (kriterno, kriter, aciklama) VALUES
  (0, 'Car Deliver', 'KYRENIA OFFICE'), (0, 'Car Deliver', 'HOTEL'), (1, 'Car Collect', 'KYRENIA OFFICE');

INSERT INTO car (Model, RegNo, Grup, Type, SiraNo, Sold, Color, FontColor, MuayeneTarihi, Notes) VALUES
  ('Fiat Panda',     'HZ 101', 'Group 1', 'Manual',    1, 0, '#fef08a', '', DATE_ADD(CURDATE(), INTERVAL 20 DAY), ''),
  ('Hyundai i10',    'HZ 102', 'Group 1', 'Manual',    2, 0, '',        '', DATE_ADD(CURDATE(), INTERVAL 200 DAY), ''),
  ('Toyota Yaris',   'HZ 201', 'Group 2', 'Automatic', 1, 0, '#bfdbfe', '', DATE_ADD(CURDATE(), INTERVAL 90 DAY), ''),
  ('Nissan Note',    'KT 202', 'Group 2', 'Automatic', 2, 0, '',        '', DATE_ADD(CURDATE(), INTERVAL 150 DAY), ''),
  ('Honda Civic',    'KT 301', 'Group 3', 'Automatic', 1, 0, '',        '', DATE_ADD(CURDATE(), INTERVAL 300 DAY), ''),
  ('Toyota Corolla', 'KT 302', 'Group 3', 'Automatic', 2, 1, '',        '', NULL, 'Sold');

INSERT INTO customer (Name, Surname, BayBayan1, PassportId, LicenseNo, BirthDate, PlaceofBirth, Email, TelNo, BlackList, BlackNote) VALUES
  ('John',  'Smith',   'Mr',   'P1001', 'L-1001', '1980-03-12', 'London',     'john@example.com',  '+44 7700 900001', 'N', ''),
  ('Mary',  'Jones',   'Mrs',  'P1002', 'L-1002', DATE_SUB(DATE_ADD(CURDATE(), INTERVAL 2 DAY), INTERVAL 45 YEAR), 'Leeds', 'mary@example.com', '+44 7700 900002', 'N', ''),
  ('Ayse',  'Yilmaz',  'Mrs',  'T2001', 'L-2001', '1990-07-01', 'Lefkosa',    'ayse@example.com',  '+90 533 000 0001', 'N', ''),
  ('Peter', 'Brown',   'Mr',   'P1003', 'L-1003', '1975-11-30', 'Manchester', 'peter@example.com', '+44 7700 900003', 'Y', 'Returned the car damaged'),
  ('Emma',  'Wilson',  'Miss', 'P1004', 'L-1004', '1995-05-20', 'Bristol',    'emma@example.com',  '+44 7700 900004', 'N', '');

INSERT INTO reservation
  (Durum, Kontrol, ReservationDate, Carid, CarModel, CarRegNo, CarGroup, CarType, Customerid, Name, Surname, ContactNumber, PassportId, LicenseNo,
   BirakilacakTarih, BirakilacakSaat, birakilacakYer, DeliverTimeChecked, AlinacakTarih, AlinacakSaat, AlinacakYer, CollectTimeChecked,
   Agency, currency, HighSeasonRate, HighSeasonDays, HighSeasonTotal, LowSeasonRate, LowSeasonDays, LowSeasonTotal,
   TotalDays, GeneralTotal, PaymentMethod1, PaidAmount1, PaidNote1, OutstandingBalance, Commission, TotalComission)
VALUES
  ('Saved', 'N', CURDATE(), 1, 'Fiat Panda', 'HZ 101', 'Group 1', 'Manual', 1, 'John', 'Smith', '+44 7700 900001', 'P1001', 'L-1001',
   DATE_SUB(CURDATE(), INTERVAL 3 DAY), '10:00:00', 'ERCAN AIRPORT', 'Y', DATE_ADD(CURDATE(), INTERVAL 4 DAY), '14:00:00', 'ERCAN AIRPORT', 'Y',
   'Sunny Tours', 'STERLIN', 0, 0, 0, 25, 8, 200, 8, 200, 'Cash', 80, 'Deposit', 120, 10, 20),
  ('Saved', 'N', CURDATE(), 3, 'Toyota Yaris', 'HZ 201', 'Group 2', 'Automatic', 3, 'Ayse', 'Yilmaz', '+90 533 000 0001', 'T2001', 'L-2001',
   CURDATE(), '12:00:00', 'LARNACA AIRPORT', 'Y', DATE_ADD(CURDATE(), INTERVAL 6 DAY), '09:00:00', 'KYRENIA OFFICE', 'N',
   '', 'EURO', 0, 0, 0, 30, 6, 180, 6, 180, 'Credit Card', 180, '', 0, 0, 0),
  ('Saved', 'N', CURDATE(), 2, 'Hyundai i10', 'HZ 102', 'Group 1', 'Manual', 5, 'Emma', 'Wilson', '+44 7700 900004', 'P1004', 'L-1004',
   DATE_ADD(CURDATE(), INTERVAL 5 DAY), '11:00:00', 'HOTEL', 'Y', DATE_ADD(CURDATE(), INTERVAL 12 DAY), '11:00:00', 'HOTEL', 'Y',
   'Cyprus Holidays', 'STERLIN', 0, 0, 0, 22, 7, 154, 7, 154, '', 0, '', 154, 10, 15.4),
  ('Saved', 'N', CURDATE(), 1, 'Fiat Panda', 'HZ 101', 'Group 1', 'Manual', 2, 'Mary', 'Jones', '+44 7700 900002', 'P1002', 'L-1002',
   DATE_ADD(CURDATE(), INTERVAL 8 DAY), '09:00:00', 'ERCAN AIRPORT', 'Y', DATE_ADD(CURDATE(), INTERVAL 15 DAY), '16:00:00', 'ERCAN AIRPORT', 'Y',
   '', 'STERLIN', 0, 0, 0, 25, 8, 200, 8, 200, '', 0, '', 200, 0, 0);

INSERT INTO transfer
  (Customerid, Name, Surname, ContactNumber, CheckedArrival, ArrivalDate, ArrivalTime, ArrivalTimeChecked, ArrivalFlightNo, ArrivalCollectFrom, ArrivalDestination,
   ArrivalPax, ArrivalPrice, ArrivalPaid, CheckedDeparture, DepartureDate, DepartureTime, DepartureTimeChecked, DepartureCollectFrom, DepartureDestination,
   DeparturePax, DeparturePrice, DeparturePaid, Driver, AgencyName, Currency, RegNo)
VALUES
  (3, 'Ayse', 'Yilmaz', '+90 533 000 0001', 'Y', CURDATE(), '11:00:00', 'Y', 'TK 968', 'LARNACA AIRPORT', 'KYRENIA OFFICE',
   2, 60, 'N', 'Y', DATE_ADD(CURDATE(), INTERVAL 6 DAY), '07:00:00', 'Y', 'KYRENIA OFFICE', 'LARNACA AIRPORT', 2, 60, 'N', 'Mehmet', '', 'EURO', '2');

INSERT INTO kur (tarih, parabirimi, alis, satis) VALUES
  (CURDATE(), 'STERLIN', 42.10, 42.55), (CURDATE(), 'EURO', 36.20, 36.45), (CURDATE(), 'DOLLAR', 34.10, 34.30);

INSERT INTO carexpense (Carid, CarModel, CarRegNo, ExpenseDate, expense, price, priceSterlin, priceEuro, ServiceKm, NextServiceKm, Notes) VALUES
  (1, 'Fiat Panda', 'HZ 101', DATE_SUB(CURDATE(), INTERVAL 30 DAY), 'Oil change', 1500, 0, 0, 45000, 55000, '');

INSERT INTO users (username, password, duty, PCarEntry, PTimeTable, PCustomerEntry, PReports, PTransfers, PAdmin, PAgency) VALUES
  ('staff', 'staff123', 'Office', 0, 1, 1, 0, 1, 0, 0);
