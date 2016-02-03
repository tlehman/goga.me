FROM ruby:latest

ENV HOME /home/rails/goga.me

# Install PostgreSQL dependencies
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs

WORKDIR $HOME

# Install gems
ADD Gemfile* $HOME/
RUN bundle install

EXPOSE 5006

# Add the app code
ADD . $HOME
CMD ["rails", "server", "--binding", "0.0.0.0"]

