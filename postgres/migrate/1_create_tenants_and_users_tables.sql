CREATE TABLE tenants
(
    id BIGSERIAL PRIMARY KEY,
    name character varying(100) NOT NULL
);
-- rlsを有効化
ALTER TABLE tenants ENABLE ROW LEVEL SECURITY;
-- tenantsテーブルに対して、ログインユーザーごとの取得行を絞り込み
CREATE POLICY tenant_tenants_policy ON tenants USING(concat('tenant$', id) = current_user);

CREATE TABLE users
(
    id BIGSERIAL PRIMARY KEY,
    tenant_id BIGSERIAL references tenants(id),
    name character varying(100) NOT NULL
);
-- rlsを有効化
ALTER TABLE users ENABLE ROW LEVEL SECURITY;
-- usersテーブルに対して、ログインユーザーごとの取得行を絞り込み
CREATE POLICY tenant_users_policy ON users USING(concat('tenant$', tenant_id) = current_user);
