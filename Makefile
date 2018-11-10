# It is taken from the environment, or "dev" by default
MIX_ENV ?= dev

compile: _build/$(MIX_ENV)

run: export BOT_TOKEN = $(shell cat bot.token)
run: export REFRANER_SERVER_HOST = localhost
run: export REFRANER_SERVER_PORT = 4000
run: _build/$(MIX_ENV)
	iex -S mix

clean:
	rm -rf _build

.PHONY: compile run clean


## Not phony

_build/$(MIX_ENV):
	mix local.hex --force
	mix local.rebar --force
	mix deps.get
	mix compile
