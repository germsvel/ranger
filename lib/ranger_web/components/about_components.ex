defmodule RangerWeb.AboutComponents do
  use Phoenix.Component

  attr :type, :string,
    values: ["hobbit", "wizard", "human", "elf", "dwarf"],
    required: true

  def badge(assigns) do
    ~H"""
    <span class={["px-2 py-1 rounded-lg text-sm", colors_from_badge_type(@type)]}>
      <%= @type %>
    </span>
    """
  end

  defp colors_from_badge_type(type) do
    %{
      "hobbit" => "bg-green-700 text-green-100",
      "human" => "bg-blue-700 text-blue-100",
      "dwarf" => "bg-yellow-700 text-yellow-100",
      "wizard" => "bg-red-700 text-red-100",
      "elf" => "bg-gray-700 text-gray-100"
    }[type]
  end

  slot :title, required: true
  slot :inner_block, required: true

  def card(assigns) do
    ~H"""
    <div class="border-2 p-4 rounded-lg max-w-sm">
      <div class="text-sm border-b-1 mb-4 flex flex-row justify-between align-center">
        <%= render_slot(@title) %>
      </div>

      <div>
        <%= render_slot(@inner_block) %>
      </div>
    </div>
    """
  end
end
