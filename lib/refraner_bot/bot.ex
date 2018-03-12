defmodule RefranerBot.Bot do
  @botname :refraner_bot

  def bot(), do: @botname

  use Telex.Bot, name: @botname
  use Telex.Dsl

  def handle({:command, "start", _msg}, _name, _) do
    answer("Hi!")
  end

  def handle({:command, "refran", _msg}, _name, _) do
    {id, refran_text} = Refraner.get_refran() |> RefranerBot.Utils.pretty_refran()
    buttons = RefranerBot.Utils.generate(id, [:show, :rate])
    answer(refran_text, parse_mode: "Markdown", reply_markup: buttons)
  end

  def handle({:callback_query, %{data: "action:show_refran_info:" <> id}}, _name, _extra) do
    refran = Refraner.get_refran_by_id(id) |> RefranerBot.Utils.pretty_refran_info()
    buttons = RefranerBot.Utils.generate(id, [:hide, :rate])
    edit(:inline, refran, parse_mode: "Markdown", reply_markup: buttons)
  end

  def handle({:callback_query, %{data: "action:hide_refran_info:" <> id}}, _name, _extra) do
    {_id, refran_text} = Refraner.get_refran_by_id(id) |> RefranerBot.Utils.pretty_refran()
    buttons = RefranerBot.Utils.generate(id, [:show, :rate])
    edit(:inline, refran_text, parse_mode: "Markdown", reply_markup: buttons)
  end
end
