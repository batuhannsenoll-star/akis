-- ============================================================
-- Mobilya Çizim Arşivi — v7 migration
-- CNC çizim dosyalarını (dxf, nc, tap vb.) arşivlemek için.
-- Gerçek dosyalar Supabase Storage'da ("cizimler" bucket),
-- bu tablo sadece dosya bilgilerini tutar.
-- ============================================================

-- Dosya bilgisi tablosu
create table if not exists mobilya_cizimler (
  id uuid primary key default gen_random_uuid(),
  dosya_adi text not null,
  kategori text,
  aciklama text,
  dosya_yolu text not null,
  dosya_boyutu bigint,
  created_by uuid references profiles(id),
  created_at timestamptz not null default now()
);

alter table mobilya_cizimler enable row level security;

create policy "cizimler_meta_select" on mobilya_cizimler
  for select
  using (current_rol() in ('mobilya_vardiya_amiri','admin','patron'));

create policy "cizimler_meta_insert" on mobilya_cizimler
  for insert
  with check (current_rol() in ('mobilya_vardiya_amiri','admin'));

create policy "cizimler_meta_delete" on mobilya_cizimler
  for delete
  using (current_rol() = 'admin');

create index if not exists idx_mobilya_cizimler_tarih on mobilya_cizimler(created_at desc);

-- ============================================================
-- Storage bucket: cizimler (özel/private — herkese açık değil)
-- ============================================================

insert into storage.buckets (id, name, public)
values ('cizimler', 'cizimler', false)
on conflict (id) do nothing;

-- Görüntüleme/indirme: Mobilya çalışanı, Admin, Patron
create policy "cizimler_storage_select" on storage.objects
  for select
  using (bucket_id = 'cizimler' and current_rol() in ('mobilya_vardiya_amiri','admin','patron'));

-- Yükleme: Mobilya çalışanı + Admin
create policy "cizimler_storage_insert" on storage.objects
  for insert
  with check (bucket_id = 'cizimler' and current_rol() in ('mobilya_vardiya_amiri','admin'));

-- Silme: sadece Admin
create policy "cizimler_storage_delete" on storage.objects
  for delete
  using (bucket_id = 'cizimler' and current_rol() = 'admin');
