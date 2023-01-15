defmodule RangerWeb.GreetLive do
  use RangerWeb, :live_view

  def render(assigns) do
    ~H"""
    <%= if @live do %>
      <h1 class="text-4xl font-bold tracking-tight sm:text-center sm:text-6xl">
        Welcome to Testing LiveView
      </h1>
    <% else %>
      <h1 class="text-4xl font-bold tracking-tight sm:text-center sm:text-6xl">
        Welcome to stateless HTTP
      </h1>
    <% end %>
    """
  end

  def mount(_, _, socket) do
    if connected?(socket) do
      {:ok, assign(socket, :live, true)}
    else
      {:ok, assign(socket, :live, false)}
    end
  end
end
