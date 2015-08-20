## Jahia Dockerfile


This repository contains **Dockerfile** of [Jahia](http://nginx.org/) version 7.1.0 for [Docker](https://www.docker.com/).

It uses a postgresql database which image can be found [here](https://github.com/pjuvigny/docker-postgres-jahia)
/!\ : the database must be up during the image creation ! Docker magically finds the container hostname by its name (you can change it in the install/InstallScript file).


### Installation

1. Install [Docker](https://www.docker.com/).

2. Launch the postgres container (name should be the same as in InstallScript)
	
    docker run -d -p 5432:5432 -v /path/to/data:/var/lib/postgresql-static/data --name postgres pjuvigny/postgres-jahia

3. Modify the install/InstallScript file to your convenience

4. Build the Jahia image

    docker build -t pjuvigny/jahia .


### Usage

Via addhost

    docker run -d --add-host "postgres:<postgres_ip>" -p 8080:8080 pjuvigny/jahia

Or via link

	docker run -d --link postgres:postgres -p 8080:8080 pjuvigny/jahia


After several minutes (first start-up is very long: ~10 min), open `http://<host>/<jahia.war.contextName>` to see the welcome page.
To follow progress:

	docker exec <container_id|container_name> tail -f tomcat/logs/jahia.log

You can commit the container once started to avoid the module compilation in next start-ups

	docker commit <image_id|image_name> pjuvigny/jahia:initialized

