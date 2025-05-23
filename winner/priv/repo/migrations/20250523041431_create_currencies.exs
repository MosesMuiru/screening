defmodule Winner.Repo.Migrations.CreateCurrencies do
  use Ecto.Migration

  def change do
    create table(:currencies) do
      add :target_currency, :string
      add :from_currency, :string
      add :amount, :integer

      timestamps(type: :utc_datetime)
    end
  end
end
