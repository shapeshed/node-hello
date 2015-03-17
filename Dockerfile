FROM  node:0.10-slim

MAINTAINER  George Ornbo "george@shapeshed.com"

ADD https://github.com/shapeshed/node-hello/archive/v0.1.0.tar.gz /srv/

WORKDIR /srv

RUN tar -xzf /srv/v0.1.0.tar.gz --strip 1


EXPOSE 8080

ADD start.sh /srv/start.sh

RUN chmod 0755 /srv/start.sh

CMD ["bash", "/srv/start.sh"]
