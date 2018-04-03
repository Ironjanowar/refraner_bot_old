# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
use Mix.Config

config :refraner_bot,
  token: {:system, "BOT_TOKEN"},
  # Refraner Server should include host and port
  refraner_server_host: {:system, "REFRANER_SERVER_HOST"},
  refraner_server_port: {:system, "REFRANER_SERVER_PORT"}
