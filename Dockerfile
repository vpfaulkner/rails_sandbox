FROM ruby:2.3.1

RUN apt-get update -qq && apt-get install -y build-essential

# for nokogiri
RUN apt-get install -y libxml2-dev libxslt1-dev

# for capybara-webkit
RUN apt-get install -y libqt5webkit5-dev qt5-default xvfb

RUN mkdir -p /app

WORKDIR /app
COPY Gemfile Gemfile.lock ./
RUN gem install bundler && bundle install

COPY . ./

EXPOSE 3000

ENTRYPOINT ["bundle", "exec"]

CMD ["rails", "server", "Puma", "-p", "3000", "-b", "0.0.0.0"]
