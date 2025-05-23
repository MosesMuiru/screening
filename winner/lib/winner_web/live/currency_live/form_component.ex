defmodule WinnerWeb.CurrencyLive.FormComponent do
  use WinnerWeb, :live_component

  alias Winner.Conversions

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        {@title}
        <:subtitle>Use this form to manage currency records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="currency-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:target_currency]} type="text" label="Target currency" />
        <.input field={@form[:from_currency]} type="text" label="From currency" />
        <.input field={@form[:amount]} type="number" label="Amount" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Currency</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{currency: currency} = assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)
     |> assign_new(:form, fn ->
       to_form(Conversions.change_currency(currency))
     end)}
  end

  @impl true
  def handle_event("validate", %{"currency" => currency_params}, socket) do
    changeset = Conversions.change_currency(socket.assigns.currency, currency_params)
    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{"currency" => currency_params}, socket) do
    save_currency(socket, socket.assigns.action, currency_params)
  end

  defp save_currency(socket, :edit, currency_params) do
    case Conversions.update_currency(socket.assigns.currency, currency_params) do
      {:ok, currency} ->
        notify_parent({:saved, currency})

        {:noreply,
         socket
         |> put_flash(:info, "Currency updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp save_currency(socket, :new, currency_params) do
    currency_params
    |> IO.inspect(label: "cuurennnyyy")

    case Conversions.create_currency(currency_params) do
      {:ok, currency} ->
        notify_parent({:saved, currency})

        {:noreply,
         socket
         |> put_flash(:info, "Currency created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp conv(from, target) do
    results = Winner.FetchRates.fetch_rates(target)
    results["rates"][from]
  end

  def fetch(currency) do
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
