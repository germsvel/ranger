defmodule RangerWeb.MovieLive.Show do
  use RangerWeb, :live_view

  alias Ranger.{Movie, Repo}

  def render(assigns) do
    ~H"""
    <div class="max-w-lg mx-auto space-y-6">
      <.link navigate={~p"/movies"}>&lt; Back</.link>

      <section class="space-y-6">
        <h2 class="text-xl font-bold text-center"><%= @movie.name %></h2>

        <%= for poster_url <- @movie.poster_urls do %>
          <img data-role="image" src={poster_url} class="rounded-md" />
        <% end %>
      </section>
    </div>
    """
  end

  def mount(%{"id" => id}, _, socket) do
    movie = Movie |> Repo.get(id)

    {:ok,
     socket
     |> assign(:movie, movie)}
  end
end
