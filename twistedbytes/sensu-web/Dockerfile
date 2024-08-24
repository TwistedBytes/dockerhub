FROM node:15-alpine3.12

WORKDIR /opt/sensu/web

RUN apk add git && \
    git clone https://github.com/alrf/sensu-web.git . && \
    yarn install && \
    yarn install --modules-folder /opt/sensu/yarn/node_modules

ENV NODE_ENV=production
# ENV PORT=3000

ENV NODE_PROXY_SECURE=false
ENV PORT=9080
ENV API_URL=https://host.docker.internal:8080

EXPOSE 9080

# CMD yarn node scripts serve --modules-folder /opt/sensu/yarn/node_modules
ENTRYPOINT ["yarn", "node", "scripts", "serve", "--modules-folder", "/opt/sensu/yarn/node_modules"]
