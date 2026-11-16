-- RentACar PWA: isteğe bağlı ama önerilen tek veritabanı değişikliği.
-- users tablosuna hash'lenmiş şifre kolonu ekler. Eski Delphi programı bu kolonu
-- kullanmaz, mevcut 'password' kolonuna dokunulmaz; iki program birlikte çalışır.
--
-- Bu kolon eklendiğinde: bir kullanıcı web'den ilk kez giriş yaptığında şifresi
-- otomatik olarak hash'lenip buraya yazılır.
--
-- Çalıştırma:  mysql -u root -p RentACar < 001_add_password_hash.sql

ALTER TABLE users ADD COLUMN password_hash VARCHAR(100) NULL;
