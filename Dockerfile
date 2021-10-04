FROM node:latest AS build

WORKDIR /app

COPY package*.json ./
RUN yarn install

COPY . .

RUN yarn build

FROM nginx:stable-alpine
WORKDIR /usr/share/nginx/html

COPY --from=build /app/build /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]