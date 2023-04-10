defmodule SlackWeb.RoomsLive do
  use SlackWeb, :live_view

  alias Slack.Room

  def mount(_params, _session, socket) do
    Room.insert_room(
      {"The Room",
       %{
         :max_size => 20,
         :current_size => 1,
         :lifetime => 12,
         :create_time => DateTime.utc_now()
       }, ["Hello"]}
    )

    {:ok, socket |> assign(:username, "") |> assign(:rooms, Room.list_rooms())}
  end

  def render(assigns) do
    ~H"""
    <.modal id="new-room-modal">
    </.modal>
    <div class="new-room">
    <.button phx-click={show_modal("new-room-modal")}>New Room</.button>
    </div>
    <.table id="rooms" rows={assigns.rooms}>
    <:col :let={room} label="Room Title"><%= elem(room, 0) %></:col>
    <:col :let={room} label="Participants"><%= to_string(elem(room, 1).current_size) <> "/" <> to_string(elem(room, 1).max_size) %> </:col>
    <:action :let={post}>
    <.link>Join</.link>
    </:action>
    </.table>
    """
  end
end
