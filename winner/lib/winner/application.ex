defmodule Winner.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      WinnerWeb.Telemetry,
      Winner.Repo,
      {DNSCluster, query: Application.get_env(:winner, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Winner.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: Winner.Finch},
      # Start a worker by calling: Winner.Worker.start_link(arg)
      # {Winner.Worker, arg},
      # Start to serve requests, typically the last entry
      WinnerWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Winner.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    WinnerWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
