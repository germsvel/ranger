defmodule RangerWeb.TimelineLive do
  use RangerWeb, :live_view

  alias Ranger.Timeline

  def render(assigns) do
    ~H"""
    <ul
      id="posts"
      role="list"
      class="px-6 py-3 rounded-md bg-gradient-to-b from-cyan-100 to-red-100 mx-auto max-w-lg divide-y divide-gray-300"
      phx-update="stream"
    >
      <li :for={{id, post} <- @streams.posts} id={id} class="py-6 space-y-2" data-role="post">
        <div class="font-semibold" data-role="author"><%= post.author %></div>
        <div class="text-lg"><%= post.text %></div>
      </li>
    </ul>

    <div class="py-4 text-center text-lg animate-pulse" id="load-more" phx-hook="InfiniteScroll">
      Loading ...
    </div>
    """
  end

  def mount(_, _, socket) do
    offset = 0
    limit = 10
    posts = Timeline.posts(limit: limit)

    {
      :ok,
      socket
      |> stream(:posts, posts)
      |> assign(:offset, offset)
      |> assign(:limit, limit)
    }
  end

  def handle_event("load-more", _, socket) do
    socket =
      socket
      |> update(:offset, fn offset -> offset + socket.assigns.limit end)
      |> stream_new_posts()

    {:noreply, socket}
  end

  defp stream_new_posts(socket) do
    offset = socket.assigns.offset
    limit = socket.assigns.limit
    posts = Timeline.posts(offset: offset, limit: limit)

    Enum.reduce(posts, socket, fn post, socket ->
      stream_insert(socket, :posts, post)
    end)
  end
end
