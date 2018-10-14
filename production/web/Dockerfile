FROM nginx

RUN apt-get update -qq && apt-get -y install apache2-utils

ENV RAILS_ROOT /var/www/top_ten
WORKDIR $RAILS_ROOT

RUN mkdir log
COPY public public/
COPY production/secrets/ production/secrets/

COPY production/web/nginx.conf /tmp/docker.nginx
RUN rm -f /etc/nginx/conf.d/*
RUN envsubst '$RAILS_ROOT' < /tmp/docker.nginx > /etc/nginx/conf.d/default.conf

EXPOSE 80

# Use the "exec" form of CMD so Nginx shuts down gracefully on SIGTERM (i.e. `docker stop`)
CMD [ "nginx", "-g", "daemon off;" ]
