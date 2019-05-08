defmodule RefranerBot do
  use Application

  require Logger

  def start(_type, _args) do
    token = ExGram.Config.get(:ex_gram, :token)

    children = [
      ExGram,
      {RefranerBot.Bot, [method: :polling, token: token]}
    ]

    opts = [strategy: :one_for_one, name: RefranerBot]

    case Supervisor.start_link(children, opts) do
      {:ok, _} = ok ->
        Logger.info("Starting RefranerBot")
        ok

      error ->
        Logger.error("Error starting RefranerBot")
        error
    end
  end
end
