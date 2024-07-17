FROM ruby:3.3.0
ENV RAILS_ROOT /app
ENV NODE_VERSION 14.x
RUN apt-get update -qq && apt-get install -y nodejs npm
RUN mkdir -p $RAILS_ROOT
WORKDIR $RAILS_ROOT
COPY Gemfile Gemfile.lock ./
RUN gem install bundler && bundle install --jobs 20 --retry 5
COPY . .
EXPOSE 3000
CMD ["rails", "server", "-b", "0.0.0.0"]
