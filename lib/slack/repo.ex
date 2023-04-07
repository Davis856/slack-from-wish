defmodule Slack.Repo do
  use Ecto.Repo,
    otp_app: :slack,
    adapter: Ecto.Adapters.Postgres
end
