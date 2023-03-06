defmodule RangerWeb.DashboardLive do
  use RangerWeb, :live_view

  import RangerWeb.NavigationComponents

  def render(assigns) do
    ~H"""
    <div class="min-h-full">
      <.navbar active={:dashboard} />

      <div class="py-10">
        <header>
          <div class="mx-auto max-w-7xl px-4 sm:px-6 lg:px-8">
            <h1 class="text-3xl font-bold leading-tight tracking-tight text-gray-900">Dashboard</h1>
          </div>
        </header>
      </div>
    </div>
    """
  end
end
