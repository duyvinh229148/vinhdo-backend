FROM public.ecr.aws/docker/library/node:16.15-slim

WORKDIR /usr/app
ENV TINI_VERSION v0.19.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /tini
RUN chmod +x /tini

# Install dependencies
## Copy production node modules
COPY ./node_modules ./node_modules
## Copy package.json from build folder
COPY package.json package.json
## Copy yarn.lock from current
#COPY ./yarn.lock yarn.lock

COPY ./ ./

EXPOSE 8080

ENTRYPOINT [ "/tini", "--" ]
CMD node main.js
