defmodule RangerWeb.PageController do
  use RangerWeb, :controller

  def home(conn, _params) do
    render(conn, :home, layout: false)
  end
end
