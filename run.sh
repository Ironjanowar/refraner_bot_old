#! /usr/bin/env bash

export BOT_TOKEN=$(cat bot.token)

echo "Getting deps"
mix deps.get

echo "Compiling..."
mix compile

if [ $1 == "iex" ]; then
    echo "Running with IEX..."
    iex -S mix
else
    echo "Running..."
    mix run --no-halt
fi
