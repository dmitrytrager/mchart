# syntax = docker/dockerfile:1

# Make sure RUBY_VERSION matches the Ruby version in .ruby-version and Gemfile
ARG RUBY_VERSION

# Create new stage from ruby-slim image with selected Ruby version.
FROM --platform=linux/x86_64 ruby:$RUBY_VERSION-slim as base

ENV RAILS_ROOT /rails
ENV APP_USER rails

# Set production environment
ENV BUNDLE_DEPLOYMENT="1" \
  BUNDLE_PATH="/usr/local/bundle" \
  BUNDLE_WITHOUT="development test" \
  HOME="$RAILS_ROOT"

# Run and own only the runtime files as a non-root user for security
RUN groupadd -g 10001 $APP_USER
RUN useradd -m -u 10001 -g 10001 --home $HOME --shell /bin/bash $APP_USER
# RUN mkdir $RAILS_ROOT
RUN chown $APP_USER:$APP_USER $RAILS_ROOT

# Rails app lives here
WORKDIR $RAILS_ROOT

# Update gems and bundler
RUN gem update --system --no-document && gem install -N bundler

# Throw-away build stage to reduce size of final image
FROM base as build

# Install dependencies that are needed only during build stage
RUN apt-get update -qq && apt-get install -y build-essential curl libpq-dev git

# Install application gems
COPY --link Gemfile Gemfile.lock ./
RUN bundle install && rm -rf ~/.bundle/ "${BUNDLE_PATH}"/ruby/*/cache "${BUNDLE_PATH}"/ruby/*/bundler/gems/*/.git

# Copy application code
COPY --link . .

ARG RAILS_ENV

# If you are already on Rails 7.1+, then you will be able to use new SECRET_KEY_BASE_DUMMY=1 variable,
# however below is a workaround for Rails 7.0 and below.
RUN --mount=type=secret,id=RAILS_MASTER_KEY RAILS_MASTER_KEY=$(cat /run/secrets/RAILS_MASTER_KEY) \
  SECRET_KEY_BASE=1 DATABASE_URL=postgresql://dummy@localhost/dummy RAILS_ENV=$RAILS_ENV ./bin/rails assets:precompile

# Start again from base image to throw away anything that is not needed
# from build stage.
FROM base as release

# Install packages needed for deployment
RUN apt-get update -qq && \
  apt-get install --no-install-recommends -y libvips postgresql-client imagemagick tzdata libjemalloc2 && \
  rm -rf /var/lib/apt/lists /var/cache/apt/archives

# Copy built artifacts: gems, application
COPY --from=build --chown=1001:1001 $BUNDLE_PATH $BUNDLE_PATH
COPY --from=build --chown=1001:1001 $RAILS_ROOT $RAILS_ROOT
RUN chown -R 1001:1001 db log storage tmp
USER $APP_USER

# Deployment options
ENV LD_PRELOAD="/usr/lib/x86_64-linux-gnu/libjemalloc.so.2" \
  MALLOC_CONF="dirty_decay_ms:1000,narenas:2,background_thread:true" \
  RAILS_LOG_TO_STDOUT="1" \
  RAILS_SERVE_STATIC_FILES="true" \
  RUBY_YJIT_ENABLE="1"

# Entrypoint prepares the database
ENTRYPOINT ["/rails/bin/docker-entrypoint.sh"]

# Start the server by default, this can be overwritten at runtime
EXPOSE 3000
