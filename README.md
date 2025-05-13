_At this time, LC does not have the resources to offer support for this open source code. While LC will make the code available, the Library does not currently promise to address any issues which are pointed out by the community beyond what is needed for the Library's own usage._

# fetch-local

## About

This is the starting point for working with FETCH locally as a developer. After following the below steps, you should have all necessary repositories cloned in a pattern that is unified with the rest of the team, and you can easily launch the application with docker.

## Getting started

1. Setup an ssh key in gitlab
2. Install homebrew: https://brew.sh/
3. Install a newer version of git: `$ brew install git`
4. Install docker desktop
5. Configure docker desktop to allow 8g of memory, and 200g of disk space.

Now run `./scripts/install.sh`

This will clone each repository under the `~/workspace/fetch`

Now you can change directory into the workspace copy of this repository, and delete the first clone you made. From here on out, you should work out of the new workspace.

```sh
cd ~/workspace/fetch/fetch-local
```

## Run

For the time being, you will need to drop off the VPN when you first run this, as we've not configured Docker to overcome traffic inspection requring x509 certs with some of the Library's new configuration in loctest. Until this happens, the VPN will block Docker from pulling some of the base images from the docker hub registry.

To run the application, run `$ docker compose up` or as detach `$ docker compose up -d or docker-compose up -d`

To rebuild image for the application, run `$ docker compose up --build` or as detach `$ docker compose up -d --build`

All fetch containers will be served under "fetch-local" in the Docker Desktop interface. You can verify with `$ docker ps`

## Management

Each app repository in the fetch application is responsible for providing its own image under a `/images` directory (if needed). Each app repository provides a set of helper scripts under `helper.sh` to manage local developer tasks and rebuilding images. These scripts will assume the directory tree set up by the install script.

### Fetch Local
This repository has a helper script for rebuilding the database service. While you can use it directly, it's better to use the helper scripts either from Inventory Service or the WebApp to do this. The scripts in those repositories will rebuild schema and seed data. `fetch-local` maintains a script for proper context for compose to attach database rebuilds to the docker network. However, this script itself does not rebuild schema or seed data.

* `./helper.sh build-inventory-db` - Rebuilds the database container without wiping data.
* `./helper.sh wipe-inventory-db` - Rebuilds the database container and wipes the data volume.

### Inventory Service

* Inventory Service API: 		http://127.0.0.1:8001/
* Inventory Service API Cache: 	http://127.0.0.1:6379/

### Web App
* Web App:                      http://127.0.0.1:8080/

### PGAdmin

* PG Admin:						http://127.0.0.1:5050/

Local login user: `admin@fetch.example.com`
Local login pass: `admin`

Once in, right click Servers and select Register -> Server

On the general tab, set name to `local`

On the connection tab:
 - Set hostname to `host.docker.internal`
 - Set username to `postgres`
 - Set password to `postgres`

Leave the port as is, and select option to remember password.

### Postgres

The Postgres Engine is served on port 5432. Interact with it either through pgAdmin, or by jumping into PSQL inside the Postgres container.

### Redis Commander

* Redis Commander: 	http://127.0.0.1:8081/

Local login user: `root`
Local login pass: `toor`
