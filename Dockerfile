RUN groupadd -r 999 &&\
    useradd -r -g 999 -d /app -s /sbin/nologin -c "Docker image user" 999

WORKDIR /app
ADD . /app

USER 999

FROM nginx
COPY nginx.conf /et/nginx/nginx.conf
COPY . /usr/share/nginx/html

RUN chmod -R 777 /var/cache/nginx /var/run /var/log/nginx
EXPOSE 80
CMD ["nginx", "-g", "daemon off"]
