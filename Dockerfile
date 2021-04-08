FROM elixir:latest AS builder

WORKDIR /opt/app

RUN mix do local.hex --force, local.rebar --force

# Cache elixir deps
ADD mix.exs mix.lock ./
RUN mix do deps.get, deps.compile

# compile
ADD . .
RUN mix compile
RUN chmod +x entrypoint.sh

FROM elixir:latest as runtime

WORKDIR /opt/app

RUN mix do local.hex --force, local.rebar --force

RUN apt-get update && \
    apt-get install -y postgresql-client

COPY --from=builder /opt/app .

USER nobody

CMD ["/opt/app/entrypoint.sh"]
