FROM ruby:2.3.1
MAINTAINER Vance Faulkner | vpfaulkner@gmail.com

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

# Setup a volume so that nginx can read in the assets from
# the Rails Docker image without having to copy them to the Docker host.
VOLUME ["$APP_HOME/public"]
