FROM node:10

# Postgressql client install not needed for buildkite:

# Add official postgresql apt deb source
# RUN echo "deb http://apt.postgresql.org/pub/repos/apt/ bionic-pgdg main" > /etc/apt/sources.list.d/pgdg.list \
#     && wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add - \
#     && apt-get update \
#     && apt-get install -y postgresql-client-10

# RUN apk --no-cache --virtual build-dependencies add \
#     curl \
#     python \
#     make \
#     g++ \
#     autoconf \
#     automake

WORKDIR /app

# Build the full app in the container
COPY . ./

# --no-cache: download package index on-the-fly, no need to cleanup afterwards
# --virtual: bundle packages, remove whole bundle at once, when done

# Add the wait-for-it.sh script for waiting on dependent containers
RUN curl https://raw.githubusercontent.com/vishnubob/wait-for-it/master/wait-for-it.sh > /usr/local/bin/wait-for-it.sh \
    && chmod +x /usr/local/bin/wait-for-it.sh

RUN yarn setup
RUN yarn global add -g wait-on

# RUN apk del build-dependencies


# RUN yarn setup
# RUN yarn global add -g wait-on

# Clean up
RUN apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /app/log/*
