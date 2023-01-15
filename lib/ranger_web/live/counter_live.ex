defmodule RangerWeb.CounterLive do
  use RangerWeb, :live_view

  def render(assigns) do
    ~H"""
    <div class="max-w-xs mx-auto flex justify-center space-x-10 border-2 p-8">
      <.button id="decrement" phx-click="decrease" class="bg-red-500 hover:bg-red-700" type="button">
        <svg
          xmlns="http://www.w3.org/2000/svg"
          fill="none"
          viewBox="0 0 24 24"
          stroke-width="1.5"
          stroke="currentColor"
          class="w-6 h-6"
        >
          <path stroke-linecap="round" stroke-linejoin="round" d="M19.5 12h-15" />
        </svg>
      </.button>

      <div id="count" class="font-extrabold text-3xl"><%= @count %></div>

      <.button id="increment" phx-click="increase" class="bg-blue-500 hover:bg-blue-700" type="button">
        <svg
          xmlns="http://www.w3.org/2000/svg"
          fill="none"
          viewBox="0 0 24 24"
          stroke-width="1.5"
          stroke="currentColor"
          class="w-6 h-6"
        >
          <path stroke-linecap="round" stroke-linejoin="round" d="M12 4.5v15m7.5-7.5h-15" />
        </svg>
      </.button>
    </div>
    """
  end

  def mount(_, _, socket) do
    {:ok, assign(socket, :count, 0)}
  end

  def handle_event("increase", _, socket) do
    {:noreply, update(socket, :count, fn count -> count + 1 end)}
  end

  def handle_event("decrease", _, socket) do
    {:noreply, update(socket, :count, fn count -> count - 1 end)}
  end
end
