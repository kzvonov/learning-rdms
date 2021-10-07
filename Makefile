include .env
export

ARGS = $(filter-out $@,$(MAKECMDGOALS))
%:
 @:

container-remove:
	@docker rm -f ${CONTANINER_NAME} || true

container-run: container-remove
	@docker run \
	--rm \
	--name ${CONTANINER_NAME} \
	-v ${LOCAL_PGDATA_PATH}:/var/lib/postgresql/data \
	-p 5432:5432 \
	-e POSTGRES_USER=${POSTGRES_USER} \
	-e POSTGRES_PASSWORD=${POSTGRES_PASSWORD} \
	postgres:13.4-alpine3.14 \
	${ARGS}

container-exec:
	@docker exec \
	-it \
	${CONTANINER_NAME} \
	${ARGS}

start:
	make container-run postgres

psql:
	make container-exec "psql \
		-h 127.0.0.1 \
		-p 5432 \
		-U ${POSTGRES_USER} \
		-W ${POSTGRES_PASSWORD}"
