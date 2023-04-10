defmodule Slack.Room do

  def list_rooms() do
    :ets.tab2list(:rooms)
  end

  # {key, %{}, []} = room
  def insert_room(room) do
    :ets.insert(:rooms, room)
  end

  def room_exists(id) do
    IO.inspect(id)
    :ets.lookup(:rooms, id)
  end

end
