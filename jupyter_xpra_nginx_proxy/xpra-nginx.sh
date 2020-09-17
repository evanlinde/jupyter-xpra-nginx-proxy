#!/bin/bash
# Start xpra with an nginx reverse proxy in front of it
# nginx listens on the port specified in $1
# xpra listens on the port specified in $2
port=$1
port2=$2
T=$(mktemp -d)

# Binding xpra to a socket and then proxying to the socket doesn't work right
# The html5 client seems to connect and then close (similar to what's described here: https://github.com/jupyterhub/jupyter-server-proxy/issues/35#issuecomment-393449000)

#xpra start-desktop --start=xfce4-session --bind=${T}/xpra.sock --html=on --auth=allow
xpra start-desktop --start=xfce4-session --bind-tcp=0.0.0.0:${port2} --html=on --auth=allow

cat <<- EOF > ${T}/nginx.conf
pid ${T}/nginx.pid;
error_log ${T}/error.log;
worker_processes auto;
events {
}
http {
  server { 
    listen 0.0.0.0:${port};
    access_log ${T}/access.log;
    location / {
      #proxy_pass http://unix:${T}/xpra.sock:/;
      proxy_pass http://127.0.0.1:14500/;
      proxy_set_header Upgrade \$http_upgrade;
    }
    client_body_temp_path ${T}/client_body;
    proxy_temp_path ${T}/proxy;
    fastcgi_temp_path ${T}/fastcgi 1 2;
    uwsgi_temp_path ${T}/uwsgi;
    scgi_temp_path ${T}/scgi;
  }
}
EOF
mkdir -p ${T}/{client_body,proxy,fastcgi,uwsgi,scgi}
nginx -c ${T}/nginx.conf
