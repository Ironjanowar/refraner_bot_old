defmodule RefranerBot.Utils do
  def pretty_refran(%{"refran" => refran, "id" => id}) do
    # TODO: answers with text and icons and the id of refran
    {id, "📜_#{refran}_📜"}
  end

  def pretty_refran_info(refran) do
    Map.to_list(refran) |> pretty_refran_info("")
  end

  defp pretty_refran_info([{"refran", refran} | rest], string) do
    pretty_refran_info(rest, string <> "*Refran:* #{refran}\n")
  end

  defp pretty_refran_info([{"significado", significado} | rest], string) do
    pretty_refran_info(rest, string <> "*Significado:* #{significado}\n")
  end

  defp pretty_refran_info([{"ideas_clave", ideas_clave} | rest], string) do
    pretty_refran_info(rest, string <> "*Ideas clave:* #{ideas_clave}\n")
  end

  defp pretty_refran_info([{"tipo", tipo} | rest], string) do
    pretty_refran_info(rest, string <> "*Tipo:* #{tipo}\n")
  end

  defp pretty_refran_info([{"marcador_de_uso", marcador_de_uso} | rest], string) do
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

  defp get_button(refran_id, :rate),
    do: [[text: "Rate", callback_data: "action:rate:" <> refran_id]]

  defp get_button(refran_id, :show),
    do: [[text: "Show info", callback_data: "action:show_refran_info:" <> refran_id]]

  def id_to_string(id) when is_integer(id), do: Integer.to_string(id)
  def id_to_string(id) when is_binary(id), do: id
end
