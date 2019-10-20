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
