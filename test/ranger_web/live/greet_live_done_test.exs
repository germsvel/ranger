defmodule RangerWeb.GreetLiveDoneTest do
  use RangerWeb.ConnCase

  import Phoenix.LiveViewTest

  test "rendering disconnected state", %{conn: conn} do
    disconnected = conn |> get(~p"/greet")

    assert html_response(disconnected, 200) =~ "Welcome to stateless HTTP"
  end

  test "upgrading to connected state", %{conn: conn} do
    disconnected = conn |> get(~p"/greet")
    {:ok, _view, html} = live(disconnected)

    assert html =~ "Welcome to Testing LiveView"
  end

  test "rendering connected state", %{conn: conn} do
    {:ok, _view, html} = live(conn, ~p"/greet")

    assert html =~ "Welcome to Testing LiveView"
  end

  test "rendering with the view", %{conn: conn} do
    {:ok, view, _html} = live(conn, ~p"/greet")

    assert view.module == RangerWeb.GreetLive
    assert is_pid(view.pid)
    assert render(view) =~ "Welcome to Testing LiveView"
  end
end
