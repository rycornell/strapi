FROM node:10

RUN mkdir /app
WORKDIR /app

ENV PATH /app/node_modules/.bin:$PATH

# COPY package.json package-lock.json /app/
#RUN npm install

# Or if you're using Yarn
ADD package.json yarn.lock /app/
RUN yarn && yarn build

COPY . /app/