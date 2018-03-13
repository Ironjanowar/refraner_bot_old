# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
use Mix.Config

config :refraner, Refraner.Repo,
  adapter: Sqlite.Ecto2,
  database: "deps/refraner/refraner.db"

config :refraner, ecto_repos: [Refraner.Repo]

config :refraner_bot, token: {:system, "BOT_TOKEN"}
