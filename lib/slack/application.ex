defmodule Slack.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start_phase(:tables, :normal, _) do
    Slack.EtsDatabase.initialize() |>
    Enum.map(fn row ->
      :ets.new(elem(row, 0), elem(row, 1))
    end)

    # TO MOVE THIS FROM HERE, ONLY FOR TESTING PURPOSES!
    Slack.Room.insert_room(
      {UUID.uuid4(), "The Room",
       %{
         :max_size => 20,
         :current_size => 1,
         :lifetime => 12,
         :create_time => DateTime.utc_now()
       }, ["Hello"]}
    )
    :ok
  end

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      SlackWeb.Telemetry,
      # Start the Ecto repository
      Slack.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: Slack.PubSub},
      # Start Finch
      {Finch, name: Slack.Finch},
      # Start the Endpoint (http/https)
      SlackWeb.Endpoint
      # Start a worker by calling: Slack.Worker.start_link(arg)
      # {Slack.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Slack.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    SlackWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
