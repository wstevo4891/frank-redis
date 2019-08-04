FROM ruby:2.6.3

RUN apt-get update && apt-get install -y net-tools

# Install bundler
RUN gem install bundler:2.0.2

# Install gems
ENV APP_HOME /app
ENV HOME /root
RUN mkdir $APP_HOME
WORKDIR $APP_HOME
COPY Gemfile* $APP_HOME/
RUN bundle install

# Upload source
COPY . $APP_HOME

# Start server
ENV PORT 4567
EXPOSE 4567

CMD ["ruby", "web.rb"]
