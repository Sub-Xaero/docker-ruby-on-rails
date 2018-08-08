FROM ruby:2.5.1
VOLUME [ "/bundles" ]
VOLUME [ "/app" ]

ENV BUNDLE_PATH /bundles
ENV KEY_PATH /rails-certs/localhost.key
ENV CERT_PATH /rails-certs/localhost.crt

RUN curl -sL https://deb.nodesource.com/setup_10.x | bash - 
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - 
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list 
RUN apt-get update -qq 
RUN apt-get install -qq --no-install-recommends build-essential libpq-dev nodejs yarn 
RUN apt-get autoremove -qq 
RUN apt-get clean -qq

RUN mkdir /rails-certs
RUN openssl req -x509 -sha256 -nodes -newkey rsa:2048 -days 365 -keyout $KEY_PATH -out $CERT_PATH -subj "/C=GB"
RUN gem install shutup
RUN gem install rails
WORKDIR /app
CMD rails s -p 80 -b "ssl://0.0.0.0:80?key=$KEY_PATH&cert=$CERT_PATH"
