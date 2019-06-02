.PHONY: run
run:
	docker-compose up -d --build

.PHONY: down
down:
	docker-compose down
