FROM ruby:2.6.3

RUN apt-get update && apt-get install -y net-tools

# Install bundler
RUN gem install bundler:2.0.2

# Set ENV variables
ENV environment=development
ENV REDIS_HOST redis://localhost:6379/1
ENV REDIS_PORT 6379
ENV APP_HOME /app
ENV HOME /root
RUN mkdir $APP_HOME
WORKDIR $APP_HOME

# Install gems
COPY Gemfile* $APP_HOME/
RUN bundle install

# Upload source
COPY . $APP_HOME

# Expose ports
ENV PORT 4567
EXPOSE 4567

# CMD ["ruby", "web.rb"]
