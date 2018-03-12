#! /usr/bin/env bash

export BOT_TOKEN=$(cat bot.token)
export PATH_TO_REFRANES="refranes/refranes.json"

echo "Getting deps"
mix deps.get

echo "Compiling..."
mix compile

echo "Running..."
mix run --no-halt
