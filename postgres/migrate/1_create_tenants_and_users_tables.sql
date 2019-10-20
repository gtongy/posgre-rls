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

-- seed データの作成
INSERT INTO tenants
VALUES
    (1, 'tenant1'),
    (2, 'tenant2'),
    (3, 'tenant3');
INSERT INTO users
VALUES
    (1, 1, 'tenant1-user1'),
    (2, 1, 'tenant1-user2'),
    (3, 1, 'tenant1-user3'),
    (4, 2, 'tenant2-user1'),
    (5, 2, 'tenant2-user2'),
    (6, 2, 'tenant2-user3');

-- tenantごとのログインユーザーを作成
CREATE USER tenant$1 WITH LOGIN PASSWORD 'tenant$1';
CREATE USER tenant$2 WITH LOGIN PASSWORD 'tenant$2';
CREATE USER tenant$3 WITH LOGIN PASSWORD 'tenant$3';

-- 各ユーザーに全てのテーブルにGRANT ALL
GRANT ALL ON ALL TABLES IN SCHEMA public TO tenant$1;
GRANT ALL ON ALL TABLES IN SCHEMA public TO tenant$2;
GRANT ALL ON ALL TABLES IN SCHEMA public TO tenant$3;
