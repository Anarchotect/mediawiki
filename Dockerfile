FROM mediawiki:1.43.0

RUN apt update && apt install -y libpq-dev openssh-server
RUN docker-php-ext-install pgsql

COPY sshd_config /etc/ssh/sshd_config
RUN useradd --create-home tunnel
RUN sed -i 's/tunnel:!/tunnel:*/' /etc/shadow

COPY entrypoint /srv/
WORKDIR /srv/
ENTRYPOINT ["/srv/entrypoint"]