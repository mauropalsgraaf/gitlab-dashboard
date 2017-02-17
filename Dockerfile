FROM marcelocg/phoenix:latest
MAINTAINER mauropalsgraaf@hotmail.com
EXPOSE 4000

ENV MIX_ENV=prod
ENV PORT=4000

COPY . /app

WORKDIR /app

RUN mix local.hex --force

CMD mix compile && mix phoenix.server
