-- 在 Supabase 的 SQL Editor 貼上並執行

create table public.signups (
  id           bigint generated always as identity primary key,
  created_at   timestamptz not null default now(),
  nickname     text not null,
  school_dept  text not null,
  grade        text not null,
  goal         text not null,
  mode         text not null,
  slots        text[] not null default '{}',
  contact      text not null,
  matched      boolean not null default false
);

-- 開啟 RLS：沒有明確允許的操作一律拒絕
alter table public.signups enable row level security;

-- 網站訪客（anon）只能「新增」報名資料
create policy "anyone can sign up"
  on public.signups for insert
  to anon
  with check (true);

-- 刻意不建立 select / update / delete 的 policy：
-- 訪客讀不到任何人的資料，你自己在 Supabase Table Editor 才看得到。
