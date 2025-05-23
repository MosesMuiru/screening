defmodule WinnerWeb.CurrencyLive.Show do
  use WinnerWeb, :live_view

  alias Winner.Conversions

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:currency, Conversions.get_currency!(id))}
  end

  defp page_title(:show), do: "Show Currency"
  defp page_title(:edit), do: "Edit Currency"
end
