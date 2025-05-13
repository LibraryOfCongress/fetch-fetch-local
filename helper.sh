#!/bin/bash

refresh-db() {
  # Wipe db and build with fake data
  (cd ../fetch-local && exec ./helper.sh wipe-inventory-db);
  # Give the db a moment to catch its breath
  sleep 5;
  # Then rebuild from podman compose for schema
  (cd ../fetch-local \
    && exec ./helper.sh build-inventory-api);
}

build-inventory-api () {
    podman compose up -d \
        --force-recreate \
        --build \
        inventory-api;

    sleep 5;

    (cd ../inventory_service && exec ./helper.sh seed-fake-data);
}

build-inventory-db () {
    podman compose up -d \
        --force-recreate \
        --build \
        inventory-database
}

wipe-inventory-db () {
    podman compose down --volumes --remove-orphans inventory-database;

    podman compose up -d \
        --force-recreate \
        --build \
        inventory-database;
}

"$@"
