# syntax=docker/dockerfile:1
FROM ruby:3.1
RUN apt-get update -qq && apt-get install -y nodejs npm postgresql-client
WORKDIR /mtdb
COPY Gemfile /mtdb/Gemfile
COPY Gemfile.lock /mtdb/Gemfile.lock
COPY package.json /mtdb/package.json
COPY package-lock.json /mtdb/package-lock.json
RUN bundle install
RUN npm install

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Configure the main process to run when running the image
CMD ["rails", "server", "-b", "0.0.0.0"]
