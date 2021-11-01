FROM node:14 as build

WORKDIR /app
COPY ./client .
RUN npm install \
    && npm run build

FROM nginx:latest
WORKDIR /usr/share/nginx/html
RUN rm -rf ./*
COPY nginx.conf /etc/nginx/nginx.conf
COPY ./client/ssl /etc/nginx
EXPOSE 4200
COPY --from=build /app/dist/client /usr/share/nginx/html
ENTRYPOINT ["nginx", "-g", "daemon off;"]
