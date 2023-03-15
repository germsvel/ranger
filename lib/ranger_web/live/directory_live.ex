defmodule RangerWeb.DirectoryLive do
  use RangerWeb, :live_view

  alias Ranger.Directory

  def render(assigns) do
    ~H"""
    <div class="flex h-full">
      <div class="flex min-w-0 flex-1 flex-col overflow-hidden">
        <div class="flex flex-1 overflow-hidden">
          <aside class="w-96 flex-shrink-0 border-r border-gray-200 flex flex-col">
            <div class="px-6 pt-6 pb-4">
              <h2 class="text-lg font-medium text-gray-900">Directory</h2>
            </div>
            <nav class="min-h-0 flex-1 overflow-y-auto" aria-label="Directory">
              <div class="relative">
                <div class="sticky top-0 border-b border-gray-200 bg-gray-50 px-6 py-1"></div>
                <ul role="list" class="relative divide-y divide-gray-200">
                  <%= for member <- @members do %>
                    <li>
                      <div class="relative flex items-center space-x-3 px-6 py-5 focus-within:ring-2 focus-within:ring-inset focus-within:ring-pink-500 hover:bg-gray-50">
                        <div class="flex-shrink-0">
                          <img class="h-10 w-10 rounded-full" src={member.image_url} alt="" />
                        </div>
                        <div class="min-w-0 flex-1">
                          <.link
                            data-role="member"
                            patch={~p"/directory/#{member.id}"}
                            class="focus:outline-none"
                          >
                            <span class="absolute inset-0" aria-hidden="true"></span>
                            <p class="text-sm font-medium text-gray-900"><%= member.name %></p>
                            <p class="truncate text-sm text-gray-500"><%= member.type %></p>
                          </.link>
                        </div>
                      </div>
                    </li>
                  <% end %>
                </ul>
              </div>
            </nav>
          </aside>

          <main class="relative flex-1 overflow-y-auto focus:outline-none">
            <article id="active-member">
              <div>
                <div class="mx-auto max-w-5xl px-4 sm:px-6 lg:px-8">
                  <div class="mt-10">
                    <div class="flex">
                      <img
                        class="h-24 w-24 rounded-full ring-4 ring-white sm:h-32 sm:w-32"
                        src={@active_member.image_url}
                        alt=""
                      />
                    </div>
                  </div>
                  <div class="mt-6 min-w-0 flex-1 sm:block">
                    <h1 class="truncate text-2xl font-bold text-gray-900">
                      <%= @active_member.name %>
                    </h1>
                  </div>
                </div>
              </div>
              <div class="mx-auto mt-6 max-w-5xl px-4 sm:px-6 lg:px-8">
                <dl class="grid grid-cols-1 gap-x-4 gap-y-8 sm:grid-cols-2">
                  <div class="sm:col-span-1">
                    <dt class="text-sm font-medium text-gray-500">Title</dt>
                    <dd class="mt-1 text-sm text-gray-900"><%= @active_member.title %></dd>
                  </div>

                  <div class="sm:col-span-1">
                    <dt class="text-sm font-medium text-gray-500">Type</dt>
                    <dd class="mt-1 text-sm text-gray-900"><%= @active_member.type %></dd>
                  </div>

                  <div class="sm:col-span-2">
                    <dt class="text-sm font-medium text-gray-500">About</dt>
                    <dd class="mt-1 max-w-prose space-y-5 text-sm text-gray-900">
                      <p>
                        <%= @active_member.description %>
                      </p>
                    </dd>
                  </div>
                </dl>
              </div>
            </article>
          </main>
        </div>
      </div>
    </div>
    """
  end

  def mount(_, _, socket) do
    members = Directory.all_members()
    active_member = hd(members)

    {:ok, assign(socket, members: members, active_member: active_member)}
  end

  def handle_params(%{"id" => id}, _, socket) do
    member = Directory.get_by(id: String.to_integer(id))

    {:noreply, assign(socket, :active_member, member)}
  end

  def handle_params(_, _, socket) do
    {:noreply, socket}
  end
end
