defmodule Refraner do
  @refraner_server Telex.Config.get(:refraner_bot, :refraner_server_endpoint)

  require Logger

  def get_random_refran() do
    Logger.info("Requested random refran")

    case HTTPoison.get(@refraner_server <> "/api/refran/random") do
      {:ok, %{body: refran, status_code: 200}} ->
        {:ok, Poison.decode!(refran)}

      err ->
        Logger.error("Error trying to get random refran")
        err
    end
  end

  def get_refran_by_id(refran_id) do
    case HTTPoison.get(@refraner_server <> "/api/refran/#{refran_id}") do
      {:ok, %{body: refran, status_code: 200}} ->
        {:ok, Poison.decode!(refran)}

      err ->
        Logger.error("Error trying to get refran ID #{refran_id}")
        err
    end
  end

  def add_vote(tg_user_id, refran_id, vote) do
    req_body = %{tg_user_id: tg_user_id, vote: vote} |> Poison.encode!()

    case HTTPoison.post(@refraner_server <> "/api/refran/#{refran_id}/vote", req_body) do
      # TODO
    end
  end
end
