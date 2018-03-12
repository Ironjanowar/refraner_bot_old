defmodule RefranerBot do
  use Application

  import Supervisor.Spec

  require Logger

  def start(_type, _args) do
    token = Telex.Config.get(:refraner_bot, :token)
    path_to_refranes = Telex.Config.get(:refraner_bot, :path_to_refranes)

    children = [
      supervisor(Telex, []),
      supervisor(RefranerBot.Bot, [:polling, token]),
      worker(Refraner, [path_to_refranes])
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
