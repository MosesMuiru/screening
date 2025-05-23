defmodule Winner.ConversionsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Winner.Conversions` context.
  """

  @doc """
  Generate a currency.
  """
  def currency_fixture(attrs \\ %{}) do
    {:ok, currency} =
      attrs
      |> Enum.into(%{
        amount: 42,
        from_currency: "some from_currency",
        target_currency: "some target_currency"
      })
      |> Winner.Conversions.create_currency()

    currency
  end
end
