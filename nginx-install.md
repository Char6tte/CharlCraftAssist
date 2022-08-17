# Nginx install

### 前提条件

・Ubuntu 22.04.1LTS

#### アップデート
> $ sudo apt update | sudo apt dist-update

#### 必要ライブラリ等インストール
> $ sudo apt install -y gcc 

#### ソースコードをダウンロードしてくる
> $ nginx -v  
> でバージョンを取得する

> https://nginx.org/en/download.html  
> ここからtar.gzのダウンロードリンクを探してくる

> $ wget https://nginx.org/download/nginx-1.22.0.tar.gz  
> で、ソースをダウンロードする。

> $ tar -zxvf nginx-1.22.0.tar.gz  
> で、解答する。

> $ cd nginx-1.22.0/

> $ nginx -V  
> これでconfigureを取得する。

> nginx version: nginx/1.22.0  
> built by gcc 11.2.0 (Ubuntu 11.2.0-19ubuntu1)  
> built with OpenSSL 3.0.2 15 Mar 2022  
> TLS SNI support enabled  
> configure arguments: --prefix=/etc/nginx --sbin-path=/usr/sbin/nginx --modules-path=/usr/lib/nginx/modules --conf-path=/etc/nginx/nginx.conf --error-log-path=/var/log/nginx/error.log --http-log-path=/var/log/nginx/access.log --pid-path=/var/run/nginx.pid --lock-path=/var/run/nginx.lock --http-client-body-temp-path=/var/cache/nginx/client_temp --http-proxy-temp-path=/var/cache/nginx/proxy_temp --http-fastcgi-temp-path=/var/cache/nginx/fastcgi_temp --http-uwsgi-temp-path=/var/cache/nginx/uwsgi_temp --http-scgi-temp-path=/var/cache/nginx/scgi_temp --user=nginx --group=nginx --with-compat --with-file-aio --with-threads --with-http_addition_module --with-http_auth_request_module --with-http_dav_module --with-http_flv_module --with-http_gunzip_module --with-http_gzip_static_module --with-http_mp4_module --with-http_random_index_module --with-http_realip_module --with-http_secure_link_module --with-http_slice_module --with-http_ssl_module --with-http_stub_status_module --with-http_sub_module --with-http_v2_module --with-mail --with-mail_ssl_module --with-stream=dynamic --with-stream_realip_module --with-stream_ssl_module --with-stream_ssl_preread_module --with-cc-opt='-g -O2 -ffile-prefix-map=/data/builder/debuild/nginx-1.22.0/debian/debuild-base/nginx-1.22.0=. -flto=auto -ffat-lto-objects -flto=auto -ffat-lto-objects -fstack-protector-strong -Wformat -Werror=format-security -Wp,-D_FORTIFY_SOURCE=2 -fPIC' --with-ld-opt='-Wl,-Bsymbolic-functions -flto=auto -ffat-lto-objects -flto=auto -Wl,-z,relro -Wl,-z,now -Wl,--as-needed -pie'

> configure argumentsをコピーし  
> $ sudo ./configre ここへ貼り付ける

> $ sudo make  
> を実行する

> $ sudo make install

> $ sudo systemctl restart nginx

> $ sudo vim /etc/nginx/nginx.conf

nginx.conf
~~~
# user www-data;
worker_processes auto;
#pidファイル場所はカスタム
pid /run/nginx.pid;

load_module /etc/nginx/modules/ngx_stream_module.so;

events {
    worker_connections  1024;
}


http {
    include       mime.types;
    default_type  application/octet-stream;
}

stream {
  #include /home/nginx_streams/v100.stream.conf;
}
~~~

v100.stream.conf
~~~
server {
  listen 8123;
  proxy_pass 100.93.40.101:$server_port;
}
~~~