FROM nginx

RUN apt-get update && apt-get install -y supervisor

RUN apt-get clean && rm -rf /var/cache/apt/archives/*

ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf

ADD entrypoint.sh /entrypoint.sh

ADD sha1check.sh /usr/local/bin/nginx-reload

RUN mkdir /opt/nginx-k8sapi/ -p

RUN chmod +x /usr/local/bin/nginx-reload

ENTRYPOINT ["/usr/bin/supervisord"]
