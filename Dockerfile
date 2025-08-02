FROM ruby:3.4-alpine
RUN apk add --no-cache git build-base

# Set working directory
WORKDIR /usr/src/app

# Copy Gemfiles and install dependencies
COPY Gemfile Gemfile.lock* *.gemspec ./
RUN gem install bundler && bundle install --jobs 4 --retry 3

# Copy the rest of the Jekyll site
COPY . .

# Build site (optional)
RUN bundle exec jekyll build

# Expose the port for `jekyll serve`
EXPOSE 4000

# Start the Jekyll server
CMD ["bundle", "exec", "jekyll", "serve", "--host", "0.0.0.0"]