-- Uygulama için root yerine yetkisi sınırlı bir MySQL kullanıcısı.
-- 'BURAYA_GUCLU_SIFRE' kısmını değiştirin ve aynı şifreyi server/.env içindeki DB_PASSWORD'e yazın.
-- Çalıştırma:  mysql -u root -p < 002_app_user.sql

CREATE USER IF NOT EXISTS 'rentacar_app'@'localhost' IDENTIFIED BY 'BURAYA_GUCLU_SIFRE';
GRANT SELECT, INSERT, UPDATE, DELETE ON RentACar.* TO 'rentacar_app'@'localhost';
FLUSH PRIVILEGES;
