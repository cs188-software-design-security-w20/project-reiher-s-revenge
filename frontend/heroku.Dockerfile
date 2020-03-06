ARG VERSION=12.2.0

FROM node:${VERSION} as builder

ENV APP_HOME /roshambo-build
RUN mkdir $APP_HOME
WORKDIR $APP_HOME

# Folders
COPY js $APP_HOME/js

# Files
COPY package.json $APP_HOME
COPY package-lock.json $APP_HOME
COPY webpack.config.js $APP_HOME
COPY .babelrc $APP_HOME
COPY prod.env $APP_HOME
COPY scaffold/icon.png $APP_HOME/scaffold
COPY scaffold/index-heroku.html $APP_HOME/scaffold/index.html

RUN npm install
RUN npm run build

RUN mv $APP_HOME/scaffold/bundle/bundle.js $APP_HOME/scaffold/bundle.js

WORKDIR $APP_HOME/scaffold

RUN npm install -g serve
