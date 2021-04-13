FROM node:10.11.0
ADD simple-node-api/app /app
WORKDIR /app
ENTRYPOINT [ "npm", "start" ]