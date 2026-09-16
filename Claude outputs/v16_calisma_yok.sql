-- v16: "Çalışma yok" (Sunday / no-work shift) desteği
-- Sorun: bir vardiyada hiç üretim/tutkal kullanımı olmadığında (ör. Pazar günleri),
-- tank ölçüm alanlarına 0 girilince mevcut formül "harcanan = dünden kalan - 0 - 0"
-- hesaplayıp, o günkü TÜM stoğu yanlışlıkla "harcanmış" gösteriyordu.
-- Çözüm: yeni bir "calisma_yok" işaretiyle, böyle vardiyalarda tank hesaplaması
-- tamamen atlanıyor; harcanan=0, kalan=dünden kalan (değişmedi) olarak kaydediliyor.

ALTER TABLE tutkal_takip ADD COLUMN calisma_yok boolean NOT NULL DEFAULT false;

-- 13.09.2026 Pazar günü, vardiya 1 için hatalı girilmiş kaydı düzeltiyoruz:
-- o gün gerçekte hiç tutkal harcanmadı, stok değişmeden kalmalıydı.
UPDATE tutkal_takip
SET calisma_yok = true,
    alt = 0, ust = 0, sog = 0, k_u = 0, k_k = 0, i_b = 0, m_g = 0,
    toplam = dunden_kalan,
    harcanan = 0,
    kalan = dunden_kalan + COALESCE(eklenen,0)
WHERE tarih = '2026-09-13' AND vardiya = 1;
