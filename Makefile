MIX_ENV?=dev

deps:
	mix deps.get
	mix deps.compile
compile: deps
	mix compile

token:
export BOT_TOKEN = $(shell cat bot.token)
export DEFAULT_LANGUAGE = ES

start: token
	_build/dev/rel/refraner_bot/bin/refraner_bot daemon

iex: token
	iex -S mix

clean:
	rm -rf _build

purge: clean
	rm -rf deps
	rm mix.lock

stop:
	_build/dev/rel/refraner_bot/bin/refraner_bot stop

attach:
	_build/dev/rel/refraner_bot/bin/refraner_bot remote

release: deps compile
	mix release

debug: token
	_build/dev/rel/refraner_bot/bin/refraner_bot console

error_logs:
	tail -n 20 -f log/error.log

debug_logs:
	tail -n 20 -f log/debug.log

.PHONY: deps compile release start clean purge token iex stop attach debug
