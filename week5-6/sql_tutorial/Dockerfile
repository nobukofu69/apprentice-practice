# ベースイメージとしてUbuntuを選択
FROM ubuntu:latest

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y gnupg && \
    apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 3B4FE6ACC0B21F32 && \
    apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 871920D1991BC93C && \
    apt-get update && \
    apt-get install -y postgresql postgresql-contrib

# PostgreSQLのデータディレクトリを初期化
RUN service postgresql start && \
    service postgresql stop

# PostgreSQLの設定ファイルを変更してリモートアクセスを許可する
RUN sed -i "s/#listen_addresses = 'localhost'/listen_addresses = '*'/" /etc/postgresql/*/main/postgresql.conf && \
    echo "host all all 0.0.0.0/0 md5" >> /etc/postgresql/*/main/pg_hba.conf

# PostgreSQLサーバーの起動スクリプトを作成
RUN echo "#!/bin/bash\nservice postgresql start\nbash" > /start_postgres.sh && \
    chmod +x /start_postgres.sh

# コンテナ内でデフォルトで実行されるコマンドを設定
CMD [ "/start_postgres.sh" ]
