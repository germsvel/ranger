defmodule RangerWeb.SettingsLive do
  use RangerWeb, :live_view

  alias Ranger.{Repo, User}
  alias RangerWeb.SettingsLive.EditableInputComponent

  def render(assigns) do
    ~H"""
    <div class="space-y-4">
      <.live_component module={EditableInputComponent} id="name" field={:name} user={@user} />

      <.live_component module={EditableInputComponent} id="email" field={:email} user={@user} />
    </div>
    """
  end

  def mount(params, _, socket) do
    user = get_user(params["user_id"])

    {:ok, assign(socket, user: user)}
  end

  def handle_info({:updated_user, user}, socket) do
    socket
    |> assign(:user, user)
    |> noreply()
  end

  defp noreply(socket), do: {:noreply, socket}

  defp get_user(user_id) do
    Repo.get(User, user_id)
  end
end
