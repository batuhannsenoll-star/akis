-- ============================================================
-- Mobilya Pres Hattı — zenginleştirilmiş veri yapısı — v11 migration
-- Eski "olcu" (serbest metin) alanı yerine kontraplak Üretim Takip'teki
-- gibi ayrı En/Boy/Kalınlık alanları ve otomatik m³ hesabı eklendi.
-- Ayrıca Makine, Cins, Usta, Firma alanları eklendi (Excel'deki
-- "mobilya_pres_veri_stoğu.xlsx" ile aynı yapı).
-- ============================================================

alter table mobilya_pres_uretim
  add column if not exists en numeric,
  add column if not exists boy numeric,
  add column if not exists kalinlik numeric,
  add column if not exists m3 numeric,
  add column if not exists makine text,
  add column if not exists cins text,
  add column if not exists usta text,
  add column if not exists firma text;

alter table mobilya_pres_uretim drop column if exists olcu;
