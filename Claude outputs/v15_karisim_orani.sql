-- v15: Tutkal karışım oranı ayarları
-- Beklenen tutkal hesabı artık sürülen KARIŞIMIN (ham tutkal + un + su) ağırlığını
-- hesaplıyor, ama gerçek tutkal_takip kayıtları HAM tutkal cinsinden tutuluyor.
-- Bu yüzden beklenen değeri, karışımın içindeki ham tutkal oranına göre
-- ham tutkal karşılığına çevirmemiz gerekiyor. Bu oranı hesaplamak için
-- kullanılan 3 kabaca değeri (varsayılan: 200 kg ham tutkal + 45 kg un + 40 litre su)
-- Ayarlar ekranından düzenlenebilir yeni sistem_ayarlari satırları olarak ekliyoruz.

INSERT INTO sistem_ayarlari (anahtar, deger) VALUES
  ('karisim_ham_tutkal_kg', 200),
  ('karisim_un_kg', 45),
  ('karisim_su_litre', 40);
