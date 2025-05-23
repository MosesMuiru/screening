defmodule Screening.Incomes do
  use Ecto.Schema
  alias Screening.Envelops

  schema "incomes" do
    field :income_name, :string
    field :amount, :integer

    belongs_to :envelop, Envelops
  end
end
