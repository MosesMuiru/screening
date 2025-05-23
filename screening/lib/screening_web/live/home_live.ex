defmodule ScreeningWeb.HomeLive do
  alias Screening.EnvelopsRepo
  use ScreeningWeb, :live_view

  def mount(_params, _session, socket) do
    new_socket =
      socket
      |> assign(envelop_created: false)

    {:ok, new_socket}
  end

  def handle_event("create_envelop", %{"envelop_name" => name}, socket) do
    created =
      name
      |> EnvelopsRepo.create()
      |> case do
        {:ok, _} -> true
        {:error, _} -> true
      end

    new_socket =
      socket
      |> assign(envelop_create: created)

    {:noreply, new_socket}
  end
end
