docker-compose up

# uncomment migrations and fixtures in the yml file
# while the sql container is running run the following commands from a separate shell to populate the db
docker-compose run --rm migrations
docker-compose run --rm fixtures


# create network
docker network create app

# installl ping on a ubuntu container
docker run -it --net app ubuntu
apt-get update
apt-get install iputils-ping
ping web

# run the sql production sql db
docker run --net app --name mysql -e MYSQL_ROOT_PASSWORD=production -e MYSQL_DATABASE=production -e MYSQL_USER=production -e MYSQL_PASSWORD=production --restart=always -d mysql:5.5

# connect to db for test
docker run --rm -it --net app mysql:5.5 /bin/bash
mysql -h mysql -uproduction -pproduction
show databases;
use production;
show tables;
delete from users;

# build the migrations
docker build -t ilovehotdogs/db-migrations .
docker push ilovehotdogs/db-migrations