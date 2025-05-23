defmodule Screening.Repo.Migrations.CreateIncomes do
  use Ecto.Migration

  def change do
    create table("incomes") do
      add :income_name, :string
      add :amount, :integer

      add :envelop_id, references(:envelops, on_delete: :delete_all)
    end
  end
end
