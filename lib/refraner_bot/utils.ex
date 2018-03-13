defmodule RefranerBot.Utils do
  def pretty_refran(%{refran: refran, id: id}) do
    # TODO: check if refran is nil
    {id, "📜 _#{refran}_ 📜"}
  end

  def pretty_refran_info(refran) do
    text = Map.get(refran, :refran)
    refran_text = "📜 _#{text}_ 📜\n\n"
    Map.to_list(refran) |> filter_null_params() |> pretty_refran_info(refran_text)
  end

  defp filter_null_params(list) do
    Enum.filter(list, fn {_, v} -> v != nil end)
  end

  def check_info(refran) do
    case refran |> Map.to_list() |> filter_null_params do
      [] -> :no_info
      _ -> :ok_info
    end
  end

  def generate_rating_row(refran_id) do
    refran_id = id_to_string(refran_id)

    [
      [text: "😡", callback_data: "rate_refran:1:" <> refran_id],
      [text: "☹", callback_data: "rate_refran:2:" <> refran_id],
      [text: "🙃", callback_data: "rate_refran:3:" <> refran_id],
      [text: "😄", callback_data: "rate_refran:4:" <> refran_id],
      [text: "😍", callback_data: "rate_refran:5:" <> refran_id]
    ]
  end

  defp pretty_refran_info([{:significado, significado} | rest], string) do
    pretty_refran_info(rest, string <> "*Significado:* #{significado}\n")
  end

  defp pretty_refran_info([{:ideas_clave, ideas_clave} | rest], string) do
    pretty_refran_info(rest, string <> "*Ideas clave:* #{ideas_clave}\n")
  end

  defp pretty_refran_info([{:tipo, tipo} | rest], string) do
    pretty_refran_info(rest, string <> "*Tipo:* #{tipo}\n")
  end

  defp pretty_refran_info([{:marcador_de_uso, marcador_de_uso} | rest], string) do
    pretty_refran_info(rest, string <> "*Marcador de uso:* #{marcador_de_uso}\n")
  end

  defp pretty_refran_info([_ | rest], string) do
    pretty_refran_info(rest, string)
  end

  defp pretty_refran_info([], string) do
    string
  end

  def generate(refran_id, raw_buttons) do
    refran_id = id_to_string(refran_id)

    buttons = Enum.map(raw_buttons, fn raw_button -> get_button(refran_id, raw_button) end)

    Telex.Dsl.create_inline(buttons)
  end

  defp get_button(refran_id, :hide),
    do: [[text: "Hide info", callback_data: "action:hide_refran_info:" <> refran_id]]

  defp get_button(refran_id, :rate), do: generate_rating_row(refran_id)

  defp get_button(refran_id, :show),
    do: [[text: "Show info", callback_data: "action:show_refran_info:" <> refran_id]]

  def id_to_string(id) when is_integer(id), do: Integer.to_string(id)
  def id_to_string(id) when is_binary(id), do: id
end
