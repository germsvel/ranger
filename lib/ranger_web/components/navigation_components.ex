defmodule RangerWeb.NavigationComponents do
  use Phoenix.Component

  use Phoenix.VerifiedRoutes,
    endpoint: RangerWeb.Endpoint,
    router: RangerWeb.Router,
    statics: RangerWeb.static_paths()

  attr :active, :atom, required: true, values: [:dashboard, :team]

  def navbar(assigns) do
    ~H"""
    <nav class="border-b border-gray-200 bg-white">
      <div class="mx-auto max-w-7xl px-4 sm:px-6 lg:px-8">
        <div class="flex h-16 justify-between">
          <div class="flex">
            <div class="sm:-my-px sm:flex sm:space-x-8">
              <.link
                navigate={~p"/dashboard"}
                class={[
                  "inline-flex items-center border-b-2 px-1 pt-1 text-sm font-medium",
                  color_classes(@active == :dashboard)
                ]}
                data-role="page-link"
              >
                Dashboard
              </.link>

              <.link
                navigate={~p"/team"}
                class={[
                  "inline-flex items-center border-b-2 px-1 pt-1 text-sm font-medium",
                  color_classes(@active == :team)
                ]}
                data-role="page-link"
              >
                Team
              </.link>
            </div>
          </div>
        </div>
      </div>
    </nav>
    """
  end

  defp color_classes(active) do
    if active do
      "border-orange-500 text-gray-900"
    else
      "border-transparent text-gray-500 hover:border-gray-300 hover:text-gray-700"
    end
  end
end
