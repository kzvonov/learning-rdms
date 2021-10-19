include .env

ARGS = $(filter-out $@,$(MAKECMDGOALS))
%:
 @:

# Remove Docker conteiner
remove:
	docker rm -f ${CONTANINER_NAME} || true

# Run Docker conteiner
run: remove
	docker run \
	--rm \
	--name ${CONTANINER_NAME} \
	-v ${LOCAL_PGDATA_PATH}:/var/lib/postgresql/data \
	-v $(shell pwd):/workspace \
	-p 5432:5432 \
	-e POSTGRES_USER=${POSTGRES_USER} \
	-e POSTGRES_PASSWORD=${POSTGRES_PASSWORD} \
	postgres:13.4-alpine3.14 \
	${ARGS}

# Exec command in Docker conteiner
exec:
	docker exec \
		-it \
		${CONTANINER_NAME} \
		${ARGS}

psql:
	docker exec -it ${CONTANINER_NAME} \
		psql \
			-h 127.0.0.1 \
			-p 5432 \
			-U "${POSTGRES_USER}"

import-sql:
	docker exec -it ${CONTANINER_NAME} \
		psql \
			-h 127.0.0.1 \
			-p 5432 \
			-U ${POSTGRES_USER} \
			-f "/workspace/${ARGS}"
