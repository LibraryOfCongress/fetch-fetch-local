#!/usr/bin/env bash

echo $0

if curl --head --silent --fail https://git.example.com/fetch 2> /dev/null; then
    printf "\n\nConnected to the vpn\n\n"
else
    printf "\n\nconnect to the vpn and run this script again\n\n"
    exit
fi

set -ex

# ~/workspace/fetch
WORKSPACE=~/workspace/fetch
mkdir -p $WORKSPACE

cd $WORKSPACE
git clone -b develop ssh://git@git.example.com:7999/fetch/fetch-local.git
git clone -b develop ssh://git@git.example.com:7999/fetch/build.git
git clone -b develop ssh://git@git.example.com:7999/fetch/database.git
git clone -b develop ssh://git@git.example.com:7999/fetch/inventory_service.git
git clone -b develop ssh://git@git.example.com:7999/fetch/vue.git
