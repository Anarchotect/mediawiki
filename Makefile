ARCH := amd64

all:
	docker build $(if $(NEW),--no-cache,) -t anarchotect/mediawiki-pgsql .

push:
	docker push anarchotect/mediawiki-pgsql --platform linux/$(ARCH)

up:
	docker-compose -f mediawiki.yml up --force-recreate -d

down:
	docker-compose -f mediawiki.yml down --remove-orphans

enter:
	sudo docker exec -it mediawiki /bin/bash

reset:
	$(MAKE) down
	$(MAKE) all
	sudo rm -rf /srv/mediawiki
	$(MAKE) up