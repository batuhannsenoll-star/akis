-- ============================================================
-- Çizim Arşivi — Düzenleme (rename/firma değiştirme) yetkisi — v10 migration
-- Önceki migration'da (v7) sadece select/insert/delete yetkisi
-- tanımlanmıştı, update yetkisi eksikti. Çizim isimlerini ve
-- firma etiketlerini sonradan düzenleyebilmek için ekleniyor.
-- ============================================================

create policy "cizimler_meta_update" on mobilya_cizimler
  for update
  using (current_rol() in ('mobilya_vardiya_amiri','admin'));
