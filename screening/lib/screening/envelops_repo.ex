defmodule Screening.EnvelopsRepo do
  alias Screening.Envelops
  alias Screening.Repo

  def create(name) do
    %Envelops{name: name}
    |> Repo.insert()
  end
end
