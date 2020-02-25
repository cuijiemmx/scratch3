FROM node:13-alpine3.11

WORKDIR /root

COPY . .

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.ustc.edu.cn/g' /etc/apk/repositories \
  && apk add --update --no-cache git \
  && npm config set registry https://registry.npm.taobao.org/ \
  && npm i \
  && npm run build

FROM nginx:1.17-alpine

COPY --from=0 /root/build/ /usr/share/nginx/html