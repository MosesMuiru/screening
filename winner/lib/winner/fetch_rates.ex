defmodule Winner.FetchRates do
  # just fetching the rates based on the currencies

  @spec fetch_rates(String.t()) :: any()
  def fetch_rates(currency) do
    Finch.build(:get, "https://open.er-api.com/v6/latest/#{currency}")
    |> Finch.request(Winner.Finch)
    |> case do
      {:ok, response} ->
        response.body
        |> Jason.decode!()

      {:error, reason} ->
        reason
    end
  end
end
