FROM node:12.20.1 as build

RUN mkdir /frontend
WORKDIR /frontend
COPY package*.json /frontend/
COPY ./ /frontend/
RUN npm install -g @angular/cli@9.1.13 @angular-devkit/build-angular && npm install
