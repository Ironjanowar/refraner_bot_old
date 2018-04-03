defmodule RefranerBot.Bot do
  @botname :refraner_bot

  def bot(), do: @botname

  use Telex.Bot, name: @botname
  use Telex.Dsl

  require Logger

  def handle({:command, "start", _msg}, _name, _) do
    answer("Hi!")
  end

  def handle({:command, "refran", %{from: %{id: user_id, first_name: first_name}}}, _name, _) do
    {:ok, %{"id" => refran_id} = full_refran} = Refraner.get_random_refran()
    refran_text = RefranerBot.Utils.pretty_refran(full_refran)

    Logger.info("Sending refran #{refran_id} to #{first_name} [#{user_id}]")

    buttons = RefranerBot.Utils.generate(refran_id, [:show, :rate])

    answer(refran_text, parse_mode: "Markdown", reply_markup: buttons)
  end

  def handle({:callback_query, %{data: "action:show_refran_info:" <> id}}, _name, _extra) do
    {:ok, full_refran} = Refraner.get_refran_by_id(id)
    refran = RefranerBot.Utils.pretty_refran_info(full_refran)
    buttons = RefranerBot.Utils.generate(id, [:hide, :rate])
    edit(:inline, refran, parse_mode: "Markdown", reply_markup: buttons)
  end

  def handle({:callback_query, %{data: "action:hide_refran_info:" <> id}}, _name, _extra) do
    {:ok, full_refran} = Refraner.get_refran_by_id(id)
    refran_text = RefranerBot.Utils.pretty_refran(full_refran)
    buttons = RefranerBot.Utils.generate(id, [:show, :rate])

    edit(:inline, refran_text, parse_mode: "Markdown", reply_markup: buttons)
  end

  def handle(
        {:callback_query, %{data: "rate_refran:" <> data, from: %{id: user_id}}},
        _name,
        _extra
      ) do
    [rate, id] = String.split(data, ":")

    Logger.info("User #{user_id} rated refran #{id} with #{rate}")

    Refraner.add_vote(user_id, id, rate)
  end
end
