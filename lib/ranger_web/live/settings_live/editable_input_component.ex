defmodule RangerWeb.SettingsLive.EditableInputComponent do
  use RangerWeb, :live_component

  alias Ranger.{Repo, User}

  def render(assigns) do
    ~H"""
    <div class="max-w-md mx-auto">
      <%= if @edit do %>
        <.simple_form
          :let={f}
          id={"#{@field}-form"}
          for={@form}
          phx-click-away="cancel"
          phx-submit="save"
          phx-target={@myself}
        >
          <.input field={{f, @field}} value={Map.get(@user, @field)} />
        </.simple_form>
      <% else %>
        <div class="space-y-8 bg-white mt-10">
          <div
            id={@field}
            phx-click="edit"
            phx-target={@myself}
            class="text-sm bg-gray-100 border-1 p-2 rounded-lg mt-2 flex items-center justify-between gap-6 hover:cursor-pointer"
          >
            <%= Map.get(@user, @field) %>
            <.icon name="hero-pencil-solid" class="w-4 h-4 stroke-current inline" />
          </div>
        </div>
      <% end %>
    </div>
    """
  end

  def mount(socket) do
    {
      :ok,
      assign(socket,
        form: to_form(%{}),
        edit: false
      )
    }
  end

  def handle_event("edit", _, socket) do
    socket
    |> assign(:edit, true)
    |> noreply()
  end

  def handle_event("cancel", _, socket) do
    socket
    |> assign(:edit, false)
    |> noreply()
  end

  def handle_event("save", params, socket) do
    user = socket.assigns.user
    updated_user = update_user(user, params)

    send(self(), {:updated_user, updated_user})

    socket
    |> assign(:edit, false)
    |> noreply()
  end

  defp noreply(socket), do: {:noreply, socket}

  defp update_user(user, params) do
    user
    |> User.changeset(params)
    |> Repo.update!()
  end
end
