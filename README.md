# Turbo chat

## System requirements

* Docker
* Docker Compose

## Setup

### 1. Clone the repository
```sh
git clone <repository-url>
cd turbo-chat
```

### 2. Setup the application
```sh
make setup
```

This command will:

Create Docker containers
Run on
Set up databases
Run migrations
Seed the database
Create a default user (example@example.com with password)
Create 3 custom users

### 3. Open project
You can access it at http://localhost:3090.


## Commands

## Control containers
```
make start # create and start
make stop # stop
make restart # restart
make down # stop and delete
```

## Reset database
```
docker compose exec web make db-reset
```

## Running rspec tests
```
docker compose run --rm web make rspec-test
docker compose run --rm web make cucumber-test
```

## Running lint code
```
docker compose run --rm web make lint
```

## Debug in container
```
docker attach your_web_container
```