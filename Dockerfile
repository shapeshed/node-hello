FROM  node:0.10-slim

MAINTAINER  George Ornbo "george@shapeshed.com"

COPY * /srv/

WORKDIR /srv

EXPOSE 8080

RUN chmod 0755 /srv/start.sh

CMD ["bash", "/srv/start.sh"]
