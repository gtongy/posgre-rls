-- tenantごとのログインユーザーを作成
CREATE USER tenant$1 WITH LOGIN PASSWORD 'tenant$1';
CREATE USER tenant$2 WITH LOGIN PASSWORD 'tenant$2';
CREATE USER tenant$3 WITH LOGIN PASSWORD 'tenant$3';

-- 各ユーザーに全てのテーブルにGRANT ALL
GRANT ALL ON ALL TABLES IN SCHEMA public TO tenant$1;
GRANT ALL ON ALL TABLES IN SCHEMA public TO tenant$2;
GRANT ALL ON ALL TABLES IN SCHEMA public TO tenant$3;
