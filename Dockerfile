FROM ruby:2.3.1
MAINTAINER vpfaulkner@gmail.com

# Install essentials
RUN apt-get update -qq && apt-get install -y build-essential

# Install for nokogiri
RUN apt-get install -y libxml2-dev libxslt1-dev

# Install for capybara-webkit
RUN apt-get install -y libqt5webkit5-dev qt5-default xvfb

# Instal for a JS runtime
RUN apt-get install -y nodejs

# Setup home directory
ENV APP_HOME /rails_sandbox
RUN mkdir $APP_HOME
WORKDIR $APP_HOME

# Install Gems
ADD Gemfile* $APP_HOME/
RUN bundle install

# Copy app
ADD . $APP_HOME

# Precompile Rails assets
RUN bundle exec rake assets:precompile

# Run app
EXPOSE 3000
ENTRYPOINT ["bundle", "exec"]
CMD ["rails", "server", "-p", "3000", "-b", "0.0.0.0", "-e", "production"]
