# docker-grafana-graphite makefile

# Environment Varibles
CONTAINER = kamon-grafana-dashboard

include .env
VARS:=$(shell sed -ne 's/ *\#.*$$//; /./ s/=.*$$// p' .env )
$(foreach v,$(VARS),$(eval $(shell echo export $(v)="$($(v))")))

.PHONY: up

prep :
	mkdir -p \
		$(GRAFANA_GRAPHITE_VAR_DIR)/data/whisper \
		$(GRAFANA_GRAPHITE_VAR_DIR)/data/elasticsearch \
		$(GRAFANA_GRAPHITE_VAR_DIR)/data/grafana \
		$(GRAFANA_GRAPHITE_VAR_DIR)/log/graphite \
		$(GRAFANA_GRAPHITE_VAR_DIR)/log/graphite/webapp \
		$(GRAFANA_GRAPHITE_VAR_DIR)/log/elasticsearch

pull :
	docker-compose pull

build :
	docker-compose build

up :
	docker-compose up -d

down :
	docker-compose down

shell :
	docker exec -ti $(CONTAINER) /bin/bash

tail :
	docker logs -f $(CONTAINER)
