.PHONY: test

setup:
	[ -f .env ] || cp .env.example .env
	docker compose down
	docker compose build
	docker compose up -d
	docker exec turbo_chat_web yarn install
	docker exec turbo_chat_web bundle exec rails assets:precompile
	docker exec turbo_chat_web bin/rails db:drop
	docker exec turbo_chat_web bin/setup

start:
	docker compose up -d

stop:
	docker compose stop

restart:
	docker compose restart

down:
	docker compose down

up:
	./bin/dev

test:
	cucumber-test
	rspec-test

cucumber-test:
	bundle exec cucumber features

rspec-test:
	bundle exec rspec -f d

lint: lint-code

lint-code:
	bundle exec rubocop

linter-code-fix:
	bundle exec rubocop -A

db-reset:
	bin/rails db:reset
