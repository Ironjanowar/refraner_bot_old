defmodule RefranerBot.Inline do
  alias ExGram.Model.InlineQueryResultArticle
  alias ExGram.Model.InputTextMessageContent

  def create_article(refran) do
    refran_text = RefranerBot.Utils.pretty_refran(refran)
    buttons = RefranerBot.Utils.generate(refran["id"], [:show, :rate], %{})

    %InlineQueryResultArticle{
      type: "article",
      id: refran["id"],
      title: refran["refran"],
      input_message_content: %InputTextMessageContent{
        message_text: refran_text,
        parse_mode: "Markdown"
      },
      reply_markup: buttons,
      description: refran["tipo"] || ""
    }
  end
end
