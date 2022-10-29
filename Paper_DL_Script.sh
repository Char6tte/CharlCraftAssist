#!/bin/bash

api=https://papermc.io/api/v2
name=paper
#インストールしたいバージョンを書く
version=1.19.2
#サーバーファイルの場所
DIR=/opt/paper/

sudo apt update && sudo apt upgrade -y

sudo apt install -y jq language-pack-ja-base language-pack-ja

# Get the build number of the most recent build
latest_build="$(curl -sSX GET "$api"/projects/"$name"/versions/"$version"/ -H 'accept: application/json' | jq ".builds | reverse | .[0]")"

# Construct download URL
download_url="$api"/projects/"$name"/versions/"$version"/builds/"$latest_build"/downloads/"$name"-"$version"-"$latest_build".jar

# Download file
wget "$download_url" --content-disposition -O paper.jar -P ${DIR}

#PC内言語の確認
# shellcheck disable=SC2086
if [ $LANG = "en_US.UTF-8" ]; then
  sudo locale-gen ja_JP.UTF-8
  echo export LANG=ja_JP.UTF-8 >> ~/.profile
  source -s ~/.profile
fi

