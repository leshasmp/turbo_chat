FROM ruby:3.2.2-slim

WORKDIR /rails

RUN apt-get update -qq && apt-get install -yq --no-install-recommends \
    build-essential \
    gnupg2 \
    less \
    git \
    libpq-dev \
    postgresql-client \
    libvips42 \
    curl \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ARG NODE_VERSION=20.9.0
ARG YARN_VERSION=1.22.19
ENV PATH=/usr/local/node/bin:$PATH
RUN curl -sL https://github.com/nodenv/node-build/archive/master.tar.gz | tar xz -C /tmp/ && \
    /tmp/node-build-master/bin/node-build "${NODE_VERSION}" /usr/local/node && \
    npm install -g yarn@$YARN_VERSION && \
    rm -rf /tmp/node-build-master

COPY package.json yarn.lock ./
RUN yarn install --frozen-lockfile

COPY Gemfile Gemfile.lock ./
RUN bundle install

COPY . .
  
RUN gem update --system && gem install bundler

EXPOSE 3090

CMD ["bundle", "exec", "rails", "s", "-b", "0.0.0.0", "-p", "3090"]
