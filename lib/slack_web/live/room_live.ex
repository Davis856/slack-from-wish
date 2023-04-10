defmodule SlackWeb.RoomLive do
  use SlackWeb, :live_view

  alias Slack.Room

  def mount(params, _session, socket) do
    case Room.room_exists(params["id"]) do
      [] -> {:ok, socket |> assign(error: "Room not found") |> put_flash(:error, "Room not found!") |> push_redirect(to: "/chat")}
      _ -> {:ok, socket}
    end
  end

  def render(assigns) do
    ~H"""
    <div class="container">
    elu
    </div>

    <.back navigate={~p"/chat"}>Back to Rooms</.back>
    """
  end
end
