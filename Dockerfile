FROM node:12.18.1 as node
 
WORKDIR /var/www/html/mern-todo
 
COPY  package.json package.json
COPY  package-lock.json package-lock.json
 
RUN npm install
 
COPY  . .

FROM nginx:1.19.0-alpine
RUN apk add --no-cache --repository http://nl.alpinelinux.org/alpine/edge/main libuv \
    &&  apk add --update nodejs npm

WORKDIR /var/www/html/mern-todo
RUN ls -l /var/www/html/mern-todo
COPY --from=0  /var/www/html/mern-todo .

RUN rm /etc/nginx/conf.d/default.conf

COPY nginx/nginx.conf /etc/nginx/conf.d/default.conf
 

CMD nginx ; exec npm start
#CMD ["nginx", "-g", "daemon off;"]
