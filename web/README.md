# RentACar – PWA sürümü

Bu klasör, Delphi ile yazılmış RentACar masaüstü programının **web / PWA** olarak yeniden yazılmış hâlidir.
Eski Delphi dosyalarına dokunulmadı; yeni sistem tamamen `web/` klasöründedir.

- **Arayüz (`client/`)**: Vue 3 + Vite + PrimeVue, `vite-plugin-pwa` ile telefona/bilgisayara uygulama olarak kurulabilir.
- **Sunucu (`server/`)**: Node.js + Fastify (TypeScript). Mevcut **MySQL veritabanını olduğu gibi** kullanır.
- Eski Delphi programı ile **aynı anda** çalışabilir (aynı tablolar, aynı kolonlar).

Ekran dili, eski programda olduğu gibi İngilizcedir.

## Ekranlar

| Ekran | Eski karşılığı |
|---|---|
| Giriş + yetkiler | `UntLogin`, `users` tablosundaki `P...` alanları |
| Ana sayfa: bugünün teslim/iade listesi, ödenmemiş bakiyeler, doğum günleri, kurlar | `UntMenux`, `UntKontrol`, `UntBirthDayRemainder` |
| Zaman çizelgesi: grup bazında araç × gün tablosu, tıklayarak yeni rezervasyon, araç değiştirme (kopyala/yapıştır), uzatma, araç renkleri, günlük listeler | `UntTimeTable` |
| Rezervasyon formu + yazdırma (PDF) | `UntReservation2`, `RepReservation` |
| Araçlar: kart, masraf/servis, sigorta, seyrüsefer, sıralama | `UntCar`, `UntCarList` |
| Müşteriler: 3 sürücü, kara liste, kiralama geçmişi | `UntCustomer` |
| Transferler (geliş / dönüş) | `UntTransfers` |
| Acenteler, şirketler, sabit yerler | `UntAgency`, `UntCompany`, `UntSabitDegerler` |
| Döviz kurları (elle giriş + KKTC Merkez Bankası'ndan çekme) | `UntKur`, menüdeki döviz butonu |
| Raporlar (CSV ve yazdırma) | `UntReports`, `UntLogReports` |
| Kullanıcılar | `UntAdmin` |

## Eski programa göre düzeltilen hatalar ve değişiklikler

1. **Sezon günü kayması:** Eski kod sezon günlerini 1 gün kaydırarak sayıyordu (ilk günü atlayıp son günden sonraki günü sayıyordu). Düzeltildi.
2. **Tarih kontrolü:** Gece yarısını "24" sayan ve dakikaları yok sayan karşılaştırma yerine tam tarih + saat karşılaştırılıyor.
3. **Çift rezervasyon:** Çakışma kontrolü artık sunucuda, veritabanı işlemi (transaction) içinde ve araç satırı kilitlenerek yapılıyor. Böylece iki kişi aynı anda aynı aracı kiralayamıyor.
4. **SQL injection:** Tüm sorgular parametreli.
5. **Şifreler:** Hash'lenerek saklanabiliyor (aşağıdaki "Veritabanı" bölümüne bakın).
6. **Kara liste:** Uyarı artık transferlerde de çıkıyor (`yapilacaklar.txt`).
7. **Doğum günü hatırlatıcı:** Eski sorgu hatalıydı (hiç çalışmıyordu). Yıl dikkate alınmadan önümüzdeki 3 gün listeleniyor.
8. **Silme kontrolleri:** Rezervasyonu olan müşteri silinemiyor (eskisi kontrolsüz siliyordu). Kaydı olan araç silinemiyor, "Sold" işaretlenmesi öneriliyor.
9. **Tarih değişince günler otomatik hesaplanıyor** (eskiden "Days" butonuna basmak gerekiyordu). Gün sayıları yine elle değiştirilebilir.
10. **Lisans kontrolü** (`cmkosdin.dll`, registry anahtarı) kaldırıldı; yerine kullanıcı girişi ve sunucu tarafı yetki kontrolü var.

Aynen korunan iş kuralları: sezon ayları (Kas–Mar düşük, Nis–Haz orta, Tem–Eki yüksek), iade saati 12:59'dan sonraysa +1 gün, toplam/bakiye/komisyon formülleri, iptal edilen rezervasyonun silinmeyip `Durum='Deleted'` yapılması, müşteri/araç/acente adı değişince rezervasyon ve transferlerdeki kopyalarının da güncellenmesi, transferin rezervasyona `Transfer.RegNo = rezervasyon id` ile bağlanması.

## Offline kullanım

Uygulama telefona/bilgisayara kurulabilir. İnternet yokken **son açılan listeler görüntülenebilir**, ancak kayıt yapılamaz.
Bu bilinçli bir tercih: internetsiz kayıt, iki kişinin aynı aracı kiralamasına yol açabilir.

## Linux sunucuya kurulum

Gereken: Node.js 20 veya 22 LTS, nginx, MySQL (mevcut veritabanı).

```bash
# 1) Kodu sunucuya alın (örnek: /opt/rentacar)
sudo mkdir -p /opt/rentacar && sudo chown $USER /opt/rentacar
git clone <depo-adresi> /opt/rentacar
cd /opt/rentacar/web

# 2) Veritabanı: uygulama kullanıcısı ve (önerilen) şifre hash kolonu
#    önce 002_app_user.sql içindeki şifreyi değiştirin
mysql -u root -p < server/sql/002_app_user.sql
mysql -u root -p RentACar < server/sql/001_add_password_hash.sql

# 3) Derleme
bash deploy/install.sh
nano server/.env      # DB_PASSWORD ve JWT_SECRET'i doldurun

# 4) Servis
sudo useradd --system --no-create-home rentacar
sudo cp deploy/rentacar.service /etc/systemd/system/
sudo systemctl daemon-reload && sudo systemctl enable --now rentacar
curl http://127.0.0.1:3000/api/health      # {"ok":true}

# 5) nginx + HTTPS
sudo cp deploy/nginx-rentacar.conf /etc/nginx/sites-available/rentacar
sudo nano /etc/nginx/sites-available/rentacar      # alan adınızı yazın
sudo ln -s /etc/nginx/sites-available/rentacar /etc/nginx/sites-enabled/
sudo certbot --nginx -d alanadiniz.com
sudo nginx -t && sudo systemctl reload nginx
```

Güncelleme: `git pull && bash deploy/install.sh && sudo systemctl restart rentacar`.
Kullanıcılar uygulamada "A new version is available" uyarısı görür.

### Veritabanı hakkında önemli notlar

- **Tablo adları büyük/küçük harf:** Eski program Windows'ta çalıştığı için SQL'lerde `Car`/`car` karışık yazılmış. Linux'ta MySQL tablo adlarında büyük/küçük harfe duyarlıdır. Yeni kod küçük harfli adları kullanır (`car`, `reservation` …). Windows MySQL'den alınan dump genelde küçük harflidir. Tablolarınızın adı farklıysa sadece `server/src/tables.ts` dosyasını düzenleyin. Eski Delphi programı da aynı Linux veritabanına bağlanacaksa MySQL'de `lower_case_table_names=1` ayarı önerilir (bu ayar veritabanı ilk kurulurken yapılmalıdır).
- **Şifreler:** `001_add_password_hash.sql` çalıştırılırsa, kullanıcı web'den ilk girişte şifresi otomatik hash'lenir. Eski `password` kolonuna dokunulmaz, böylece Delphi programı çalışmaya devam eder. Delphi kullanımı bitince `.env` içinde `LEGACY_PLAINTEXT_PASSWORDS=false` yapın.
- **Root kullanmayın:** `002_app_user.sql` sadece RentACar veritabanına SELECT/INSERT/UPDATE/DELETE yetkisi olan bir kullanıcı açar.
- **README.md'deki eski MySQL root şifresi** git geçmişinde duruyor. O şifreyi mutlaka değiştirin.
- Çakışma kontrolündeki kilit InnoDB tablolarında çalışır. Tablolar MyISAM ise kontrol yine yapılır ama aynı saniyedeki iki kayıt arasında kilit olmaz; InnoDB'ye geçmeniz önerilir.

## Geliştirme

```bash
cd web/server && cp .env.example .env   # DB bilgilerini ve JWT_SECRET'i girin
npm install && npm run dev              # API: http://127.0.0.1:3000
cd ../client && npm install && npm run dev   # Arayüz: http://localhost:5173
```

- `server/sql/dev_schema_inferred.sql`: Delphi kodundan çıkarılmış **tahmini** şema, sadece boş bir test veritabanı kurmak için. Gerçek veritabanında çalıştırmayın.
- Testler: `cd server && npm test` (fiyat/gün kuralları ve API, veritabanı olmadan sahte veriyle).

## Bilinen eksikler / sonraki adımlar

- Müşteri dosya ekleri (eski programda her PC'de `c:\dosyalar\<id>`) henüz taşınmadı.
- Yazdırma çıktısı genel bir rezervasyon formudur; `Sozlesme.doc` sözleşme şablonu birebir uyarlanmadı.
- `LogReservation` tablosu eski programda da yazılmıyordu (kod kapalıydı); log raporu sadece mevcut kayıtları gösterir.
- Gerçek veritabanı yapısı (dump) görülmeden yazıldı; ilk kurulumda bir test veritabanında denenmesi önerilir.
