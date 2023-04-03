defmodule RangerWeb.AlbumLive.Show do
  use RangerWeb, :live_view

  alias Ranger.{Album, Repo}

  def render(assigns) do
    ~H"""
    <div class="max-w-lg mx-auto space-y-6">
      <.link navigate={~p"/albums"}>&lt; Back</.link>

      <section class="space-y-6">
        <h2 class="text-xl font-bold text-center"><%= @album.name %></h2>

        <%= for photo_url <- @album.photo_urls do %>
          <img data-role="image" src={photo_url} class="rounded-md" />
        <% end %>
      </section>
    </div>
    """
  end

  def mount(%{"id" => id}, _, socket) do
    album = Album |> Repo.get(id)

    {:ok,
     socket
     |> assign(:album, album)}
  end
end
