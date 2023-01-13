FROM public.ecr.aws/docker/library/node:16.15-slim

WORKDIR /usr/app
ENV TINI_VERSION v0.19.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /tini
RUN chmod +x /tini
RUN npm i -g pm2

# Install dependencies
COPY package.json package.json
#COPY yarn.lock yarn.lock
#COPY patches patches
RUN yarn

ARG APP_ARG
ENV APP ${APP_ARG}

# Copy all the files over
COPY dist dist

# Specify which app to use
ENV PORT 8080

# RUN yarn nx run ${APP}:build

# Run the app in dev mode
ENTRYPOINT [ "/tini", "--" ]
CMD pm2-dev --node-args="--inspect=0.0.0.0:9229" dist/main.js
