defmodule WinnerWeb.CurrencyLive.Index do
  use WinnerWeb, :live_view

  alias Winner.Conversions
  alias Winner.Conversions.Currency

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :currencies, Conversions.list_currencies())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Currency")
    |> assign(:currency, Conversions.get_currency!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Currency")
    |> assign(:currency, %Currency{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Currencies")
    |> assign(:currency, nil)
  end

  @impl true
  def handle_info({WinnerWeb.CurrencyLive.FormComponent, {:saved, currency}}, socket) do
    {:noreply, stream_insert(socket, :currencies, currency)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    currency = Conversions.get_currency!(id)
    {:ok, _} = Conversions.delete_currency(currency)

    {:noreply, stream_delete(socket, :currencies, currency)}
  end
end
