defmodule Screening.Repo do
  use Ecto.Repo,
    otp_app: :screening,
    adapter: Ecto.Adapters.Postgres
end
