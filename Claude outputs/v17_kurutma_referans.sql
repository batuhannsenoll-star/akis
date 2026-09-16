-- v17: Telli kurutma (230/180 papel) referans mesafe/süre ayarları
-- Telli kurutma kapasite kıyaslaması (230 papel vs 180 papel), makinenin
-- kalibrasyon değerine göre otomatik hesaplanıyor: 4,5 hızda 180 cm ilerleme
-- 26 saniye sürüyor. Bu iki değeri Ayarlar'dan düzenlenebilir yapıyoruz.

INSERT INTO sistem_ayarlari (anahtar, deger) VALUES
  ('kurutma_referans_mesafe_cm', 180),
  ('kurutma_referans_sure_sn', 26);
