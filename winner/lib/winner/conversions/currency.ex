defmodule Winner.Conversions.Currency do
  use Ecto.Schema
  import Ecto.Changeset

  schema "currencies" do
    field :amount, :integer
    field :from_currency, :string
    field :target_currency, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(currency, attrs) do
    currency
    |> cast(attrs, [:target_currency, :from_currency, :amount])
    |> validate_required([:target_currency, :from_currency, :amount])
  end
end
