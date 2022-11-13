#!/bin/bash

api=https://papermc.io/api/v2
name="paper"
version="1.19.2"
DIR="/opt/paper/"
ScreenName="paper"
XMX="20"
XMS="1"


sudo apt update && sudo apt upgrade -y && sudo apt install -y jq language-pack-ja-base language-pack-ja

cd ${DIR} || exit
# Get the build number of the most recent build
latest_build="$(curl -sSX GET "$api"/projects/"$name"/versions/"$version"/ -H 'accept: application/json' | jq ".builds | reverse | .[0]")"
# Construct download URL
download_url="$api"/projects/"$name"/versions/"$version"/builds/"$latest_build"/downloads/"$name"-"$version"-"$latest_build".jar
# Download file
wget "$download_url" --content-disposition -O paper.jar -P "${DIR}"

#PC内言語の確認
# shellcheck disable=SC2086
#if [ $LANG = "en_US.UTF-8" ]; then
#  sudo locale-gen ja_JP.UTF-8
#  echo export LANG=ja_JP.UTF-8 >> ~/.profile
#  source -s ~/.profile
#fi

#ファイルが存在するか確認
if [ -e "${DIR}eula.txt" ]; then
  echo "eula.txt exists."
  else
    wget "https://" --content-disposition -O eula.txt -P ${DIR}
fi

#スクリーンが存在するのか、チェック。ある場合：javaプロセスが存在するか、確認し、一度落とす。
#ない場合：スクリーンを作成し、起動する。
if screen -list | grep -q "paper" ; then
  # もしスクリーンのリストの中にpaperという名前が存在していたら正判定
    # run bash script
    if pgrep -f "java" > /dev/null ; then
      echo "Java実行中です"
      # java process running
      screen -p 0 -S $ScreenName -X eval 'stuff "say 1分後にサーバーが停止します。停止後再起動予定です。"\015'
      sleep 30
      screen -p 0 -S $ScreenName -X eval 'stuff "say 30秒後にサーバーが停止します。停止後再起動予定です。"\015'
      sleep 20
      screen -p 0 -S $ScreenName -X eval 'stuff "say 10秒後にサーバーが停止します。停止後再起動予定です。"\015'
      sleep 10
      screen -p 0 -S $ScreenName -X eval 'stuff "stop"\015'
      sleep 40
          while [ -n "$(screen -list | grep -o "${SERVICE}")" ]
            do
              screen -p 0 -S $ScreenName -X eval 'stuff ""\015'
              sleep 5
          done
          echo "Stopped $ScreenName server"
      echo "Stopped minecraft_server"
    else
      # java process not running
      echo "java Process not running"
    fi
  echo "[list on paper]Starting new $ScreenName..."
  cd ${DIR} || exit
  screen -UAmdS $ScreenName java -Xmx${XMX}G -Xms${XMS}G -jar ${ScreenName}.jar nogui
  echo "done"
else
    echo "[paper not found]Starting $ScreenName..."
    cd ${DIR} || exit
    screen -UAmdS $ScreenName java -Xmx${XMX}G -Xms${XMS}G -jar ${ScreenName}.jar nogui
    echo "done"
fi