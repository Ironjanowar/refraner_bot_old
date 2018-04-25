#! /usr/bin/env bash

export BOT_TOKEN=$(cat bot.token)
export REFRANER_SERVER_HOST="http://localhost"
export REFRANER_SERVER_PORT="4000"

echo "Getting deps"
mix deps.get

echo "Compiling..."
mix compile
if [ $? != 0 ]; then
    echo -e "\n\nCould not compile"
    exit 1
fi

if [ $# -gt 0 ] && [ $1 == "iex" ]; then
    echo "Running with IEX..."
    iex -S mix
else
    echo "Running..."
    mix run --no-halt
fi
