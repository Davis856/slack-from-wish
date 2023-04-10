defmodule SlackWeb.RoomsLive do
  use SlackWeb, :live_view

  alias Slack.Room

  def mount(_params, _session, socket) do
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
    <:col :let={room} label="Room Title"><%= elem(room, 1) %></:col>
    <:col :let={room} label="Participants"><%= to_string(elem(room, 2).current_size) <> "/" <> to_string(elem(room, 2).max_size) %> </:col>
    <:col :let={room} label="Time Left"><%= to_string(elem(room, 2).lifetime) %></:col>
    <:action :let={room}>
    <.link navigate={~p"/chat/#{elem(room, 0)}/"}>Join</.link>
    </:action>
    </.table>
    """
  end
end
