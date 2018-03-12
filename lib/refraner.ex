defmodule Refraner do
  use GenServer

  # Client API
  def start_link(refranes_path) do
    GenServer.start_link(__MODULE__, refranes_path, name: __MODULE__)
  end

  # Server callbacks
  def init(refranes_path) do
    load_refranes(refranes_path)
  end

  defp load_refranes(path) do
    with {:ok, file} <- File.read(path),
         {:ok, refranes} <- Poison.decode(file) do
      {:ok, refranes}
    else
      err -> err
    end
  end

  # Client
  def get_refran() do
    GenServer.call(__MODULE__, :get_refran)
  end

  def get_refran_by_id(id) do
    GenServer.call(__MODULE__, {:get_refran, id})
  end

  # Handlers
  def handle_call(:get_refran, _from, state) do
    refran = Enum.random(state)

    {:reply, refran, state}
  end

  def handle_call({:get_refran, rid}, _from, state) do
    refran =
      Enum.find(state, fn %{"id" => id} ->
        RefranerBot.Utils.id_to_string(id) == rid
      end)

    {:reply, refran, state}
  end
end
