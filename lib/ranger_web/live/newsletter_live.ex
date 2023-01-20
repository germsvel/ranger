defmodule RangerWeb.NewsletterLive do
  use RangerWeb, :live_view

  alias Ranger.Newsletter

  def render(assigns) do
    ~H"""
    <.simple_form :let={f} id="subscribe" phx-change="validate" for={@changeset}>
      <.input phx-debounce="500" type="email" field={{f, :email}} placeholder="email address" />

      <span class="text-sm text-gray-500">No spam. Unsubscribe anytime</span>

      <:actions>
        <.button>Subscribe</.button>
      </:actions>
    </.simple_form>
    """
  end

  def mount(_, _, socket) do
    changeset = Newsletter.new_subscription()

    {:ok, assign(socket, :changeset, changeset)}
  end

  def handle_event("validate", %{"subscription" => params}, socket) do
    changeset = params |> Newsletter.new_subscription() |> Map.put(:action, :insert)

    {:noreply, assign(socket, :changeset, changeset)}
  end
end
