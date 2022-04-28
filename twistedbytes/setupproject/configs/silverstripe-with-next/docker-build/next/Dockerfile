FROM node:16

ARG APP_USER_ID=0
ARG APP_GROUP_ID=0

RUN mkdir /.npm
RUN mkdir /.config
RUN touch /.babel.json

RUN chown -R ${APP_USER_ID}:${APP_GROUP_ID} /.npm
RUN chown -R ${APP_USER_ID}:${APP_GROUP_ID} /.config
RUN chown ${APP_USER_ID}:${APP_GROUP_ID} /.babel.json

RUN apt-get update && apt-get install python -y 
