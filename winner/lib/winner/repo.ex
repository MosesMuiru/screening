defmodule Winner.Repo do
  use Ecto.Repo,
    otp_app: :winner,
    adapter: Ecto.Adapters.Postgres
end
