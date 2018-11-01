FROM ruby:2.4.4-alpine

RUN echo "gem: --no-rdoc --no-ri" >> ~/.gemrc \
    && apk --update add --virtual build-dependencies build-base postgresql-dev \
    && apk --update add libpq bash nodejs libxml2 libxml2-dev libxml2-utils libxslt zlib tzdata git openssh file imagemagick \
    && gem install bundler \
    && mkdir -m 700 -p /root/.ssh \
    && ssh-keyscan github.com >> ~/.ssh/known_hosts

WORKDIR /app

COPY Gemfile Gemfile.lock ./

ENV RAILS_ENV production

RUN bundle install --deployment --jobs 5 && apk del build-dependencies

ADD . ./

RUN npm config set unsafe-perm true && npm install yarn -g && yarn install

EXPOSE 3000

CMD bundle exec rails s -b 0.0.0.0
