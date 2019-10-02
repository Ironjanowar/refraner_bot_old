# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
use Mix.Config

config :ex_gram,
  token: {:system, "BOT_TOKEN"}

config :tesla, adapter: Tesla.Adapter.Gun

config :refraner_bot,
  # Refraner Server should include host and port
  refraner_server_host: {:system, "REFRANER_SERVER_HOST"},
  refraner_server_port: {:system, "REFRANER_SERVER_PORT"},
  default_language: {:system, "DEFAULT_LANGUAGE"}

config :logger,
  level: :debug,
  truncate: :infinity,
  backends: [{LoggerFileBackend, :debug}, {LoggerFileBackend, :error}]

config :logger, :debug,
  path: "log/debug.log",
  level: :debug,
  format: "$dateT$timeZ [$level] $message\n"

config :logger, :error,
  path: "log/error.log",
  level: :error,
  format: "$dateT$timeZ [$level] $message\n"
