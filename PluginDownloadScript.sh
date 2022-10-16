github=("DiscordSRV/DiscordSRV" "MilkBowl/Vault" "HimaJyun/Jecon" "PlayPro/CoreProtect" "")

cd /opt/
for url in github
do
filename=${url} | grep "/.*"
curl -s "https://api.github.com/repos/${url}/releases/latest" | grep "browser_download_url.*jar" |cut -d : -f 2,3 | tr -d \" |wget -qi -
done