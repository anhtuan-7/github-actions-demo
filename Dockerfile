# Production
FROM node:20.5.1-alpine as builder
USER node
RUN mkdir -p /home/node/app
WORKDIR /home/node/app
COPY --chown=node:node ./package.json ./
COPY --chown=node:node ./package-lock.json ./  
RUN npm install --loglevel verbose
COPY --chown=node:node ./ ./
RUN npm run build

FROM nginx
COPY --from=builder /home/node/app/build /usr/share/nginx/html

# nginx will automatically start up

