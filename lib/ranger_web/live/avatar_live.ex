defmodule RangerWeb.AvatarLive do
  use RangerWeb, :live_view

  def render(assigns) do
    ~H"""
    <div class="flex justify-center">
      <img class="avatar" src={@avatar_url} />
    </div>
    """
  end

  def mount(params, _, socket) do
    avatar_url = Ranger.Gravatar.generate(params["email"])

    {:ok, assign(socket, avatar_url: avatar_url)}
  end
end
