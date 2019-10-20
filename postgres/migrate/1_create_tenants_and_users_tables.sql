CREATE TABLE tenants (
    id BIGSERIAL PRIMARY KEY,
    name character varying(100) NOT NULL
);

CREATE TABLE users (
    tenant_id BIGSERIAL PRIMARY KEY,
    name character varying(100) NOT NULL
);