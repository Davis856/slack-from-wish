defmodule Slack.Message do

  def list_messages() do
    :ets.tab2list(:messages)
  end

  def insert_message(message) do
    :ets.insert(:messages, message)
  end

end
