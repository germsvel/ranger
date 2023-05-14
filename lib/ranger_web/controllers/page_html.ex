defmodule RangerWeb.PageHTML do
  use RangerWeb, :html

  embed_templates "page_html/*"

  attr :icon, :string, required: true
  attr :navigate, :string, required: true
  slot :inner_block, required: true

  def link_item(assigns) do
    ~H"""
    <.link navigate={@navigate}>
      <li class="relative flex justify-between items-center py-5 px-2 rounded-md text-lg text-blue-500 hover:text-blue-800 hover:bg-gray-100">
        <div>
          <.icon name={@icon} />
          <%= render_slot(@inner_block) %>
        </div>
        <svg
          class="h-5 w-5 flex-none text-gray-400"
          viewBox="0 0 20 20"
          fill="currentColor"
          aria-hidden="true"
        >
          <path
            fill-rule="evenodd"
            d="M7.21 14.77a.75.75 0 01.02-1.06L11.168 10 7.23 6.29a.75.75 0 111.04-1.08l4.5 4.25a.75.75 0 010 1.08l-4.5 4.25a.75.75 0 01-1.06-.02z"
            clip-rule="evenodd"
          />
        </svg>
      </li>
    </.link>
    """
  end
end
