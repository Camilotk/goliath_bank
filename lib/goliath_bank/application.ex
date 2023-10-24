defmodule GoliathBank.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      GoliathBankWeb.Telemetry,
      GoliathBank.Repo,
      {DNSCluster, query: Application.get_env(:goliath_bank, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: GoliathBank.PubSub},
      # Start a worker by calling: GoliathBank.Worker.start_link(arg)
      # {GoliathBank.Worker, arg},
      # Start to serve requests, typically the last entry
      GoliathBankWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: GoliathBank.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    GoliathBankWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
