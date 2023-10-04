defmodule RangerWeb.MetricsLiveDoneTest do
  use RangerWeb.ConnCase, async: true

  import Phoenix.LiveViewTest

  test "renders loading screen", %{conn: conn} do
    {:ok, _view, html} = live(conn, ~p"/metrics")

    assert html =~ "data-role=\"loading\""
  end

  test "renders metric after loading (sleep)", %{conn: conn} do
    {:ok, view, _html} = live(conn, ~p"/metrics")

    Process.sleep(2000)

    assert has_element?(view, "[data-role=success]", "User Visits")
  end

  test "renders metric after loading (render_async)", %{conn: conn} do
    {:ok, view, _html} = live(conn, ~p"/metrics")

    assert render_async(view, 2000) =~ "User Visits"
  end

  test "renders metric after loading (metric timeout)", %{conn: conn} do
    {:ok, view, _html} = live(conn, ~p"/metrics")
    timeout = RangerWeb.MetricsLive.metric_timeout()

    assert render_async(view, timeout + 100) =~ "User Visits"
  end

  test "renders metric after loading (App config)", %{conn: conn} do
    {:ok, view, _html} = live(conn, ~p"/metrics")
    timeout = Application.get_env(:ranger, RangerWeb.MetricsLive)[:timeout]

    assert render_async(view, timeout + 100) =~ "User Visits"
  end

  test "renders failure message if metric fails to load (inject query param)", %{conn: conn} do
    {:ok, view, _html} = live(conn, ~p"/metrics?test_force_failure=true")

    assert render_async(view) =~ "Failed to load"
  end
end
