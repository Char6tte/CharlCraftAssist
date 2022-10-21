#!/bin/bash

api=https://papermc.io/api/v2
name=paper
#インストールしたいバージョンを書く
version=1.19.2
#サーバーファイルの場所
DIR=/opt/paper/

sudo apt update && sudo apt upgrade -y

sudo apt install -y

# Get the build number of the most recent build
latest_build="$(curl -sSX GET "$api"/projects/"$name"/versions/"$version"/ -H 'accept: application/json' | jq ".builds | reverse | .[0]")"

# Construct download URL
download_url="$api"/projects/"$name"/versions/"$version"/builds/"$latest_build"/downloads/"$name"-"$version"-"$latest_build".jar

# Download file
wget "$download_url" --content-disposition -O paper.jar -P ${DIR}