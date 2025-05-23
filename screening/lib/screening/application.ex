defmodule Screening.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      ScreeningWeb.Telemetry,
      Screening.Repo,
      {DNSCluster, query: Application.get_env(:screening, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Screening.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: Screening.Finch},
      # Start a worker by calling: Screening.Worker.start_link(arg)
      # {Screening.Worker, arg},
      # Start to serve requests, typically the last entry
      ScreeningWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Screening.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    ScreeningWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
