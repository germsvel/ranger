defmodule RangerWeb.MetricsLive do
  use RangerWeb, :live_view

  def render(assigns) do
    ~H"""
    <div class="max-w-lg mx-auto space-y-6">
      <h2 class="text-xl font-semibold text-slate-700 text-center">
        Metrics with Magic 🪄
      </h2>

      <div class="flex space-x-4 mx-auto">
        <div class="border border-gray-300 shadow rounded-md mx-auto flex flex-col space-y-4 p-4 w-1/4 w-full">
          <%= if @metric.loading do %>
            <div data-role="loading" class="animate-pulse flex flex-col space-y-4">
              <div class="h-2 bg-slate-700 rounded"></div>
              <div class="mx-auto rounded-full bg-slate-700 h-10 w-10"></div>
            </div>
          <% else %>
            <%= if @metric.ok? do %>
              <div data-role="success" class="flex flex-col space-y-2">
                <div class="text-center"><%= @metric.result.name %></div>
                <div class="mx-auto rounded-full bg-orange-300 text-orange-800 h-10 w-10 flex items-center justify-center">
                  <%= @metric.result.value %>
                </div>
              </div>
            <% else %>
              <div data-role="failure" class="flex flex-col space-y-2">
                <div class="text-center">Failed to load</div>
                <div class="mx-auto rounded-full bg-orange-300 text-orange-800 h-10 w-10 flex items-center justify-center">
                  🤕
                </div>
              </div>
            <% end %>
          <% end %>
        </div>
      </div>
    </div>
    """
  end

  def mount(params, _, socket) do
    {
      :ok,
      socket
      |> assign_async(:metric, fn -> fetch_metric(params) end)
    }
  end

  defp fetch_metric(params) do
    force_fail = Map.get(params, "test_force_failure", false)

    if force_fail do
      {:error, "Loading error"}
    else
      Process.sleep(1500)
      # Process.sleep(metric_timeout())
      # Process.sleep(config(:timeout))
      {:ok, %{metric: %{value: 123, name: "User Visits"}}}
    end
  end

  def metric_timeout, do: 1500

  def config(key) do
    Application.get_env(:ranger, __MODULE__)[key]
  end
end
