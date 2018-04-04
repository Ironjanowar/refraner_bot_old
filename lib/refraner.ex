defmodule Refraner do
  use Tesla

  @host Telex.Config.get(:refraner_bot, :refraner_server_host, "http://localhost")
  @port Telex.Config.get(:refraner_bot, :refraner_server_port, "4000")

  plug(Tesla.Middleware.BaseUrl, @host <> ":" <> @port)
  plug(Tesla.Middleware.Headers, [{"Content-Type", "application/json"}])
  plug(Tesla.Middleware.JSON)

  require Logger

  def get_random_refran() do
    case get("/api/refran/random") do
      {:ok, %{body: refran, status: 200}} ->
        {:ok, refran}

      err ->
        Logger.error("Error trying to get random refran")
        err
    end
  end

  def get_refran_by_id(refran_id) do
    case get("/api/refran/#{refran_id}") do
      {:ok, %{body: refran, status: 200}} ->
        {:ok, refran}

      err ->
        Logger.error("Error trying to get refran ID #{refran_id}")
        err
    end
  end

  def add_vote(tg_user_id, refran_id, vote) do
    full_vote = %{tg_user_id: tg_user_id, vote: vote, refran_id: refran_id}
    req_body = %{tg_user_id: tg_user_id, vote: vote}

    case post("/api/refran/#{refran_id}/vote", req_body) do
      {:ok, %{status: 201}} ->
        {:ok, full_vote}

      err ->
        Logger.error("Error trying to vote with #{inspect(full_vote)}")
        err
    end
  end

  def get_user_vote(user_id, refran_id) do
    case get("/api/refran/#{refran_id}/vote/user/#{user_id}") do
      {:ok, %{status: 200, body: vote}} ->
        {:ok, vote}

      {:ok, %{status: 404, body: err}} ->
        Logger.error(err)
        {:error, {:not_found, err}}

      err ->
        Logger.error("Error trying to get vote from user #{user_id} for refran #{refran_id}")
        err
    end
  end
end
