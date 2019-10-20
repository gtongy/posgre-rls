FROM postgres:11

# 初期化用実行用 sql ファイルを、コンテナ内の所定のディレクトリにコピー
COPY ./migrate/*.sql /docker-entrypoint-initdb.d/