defmodule Screening.Repo.Migrations.CreateEnvelop do
  use Ecto.Migration

  def change do
    create table("envelops") do
      add :name, :string
    end
  end
end
