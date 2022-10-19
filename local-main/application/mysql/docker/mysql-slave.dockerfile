FROM mysql:5.7
LABEL OG=felord.cn
COPY utf8mb4.cnf /etc/mysql/conf.d/utf8mb4.cnf
COPY ./sql  /tmp/sql
RUN mv /tmp/sql/*.sql /docker-entrypoint-initdb.d
RUN rm -rf /tmp/sql

