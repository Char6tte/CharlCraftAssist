# Ubuntu Install

## 初期設定

### パッケージアップデート
> $ sudo apt update && sudo apt dist-upgrade -y

### IPアドレス固定

> sudo mv /etc/netplan/00-installer-config.yaml /etc/netplan/00-installer-config.yaml.disable  
> sudo vim /etc/init.d/netplan/99-config.yaml

99-config.yaml
~~~
network:
  version: 2
  renderer: networkd
  ethernets:
    ens18:
      dhcp4: false
       addresses:
        - 192.168.3.???/16
      nameservers:
        addresses: [8.8.8.8,8.8.4.4]
~~~

ens18:ネットワーク機器名。 ip a などで取得できる。  
192.168.3.???/16 VMに設定したいIPを入力する。うちだと、192.168.3.2~192.168.3.255まで  
addresses: DNSサーバーを設定する。8.8.8.8はGoogleDNS。