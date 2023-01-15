defmodule RangerWeb.CounterLiveDoneTest do
  use RangerWeb.ConnCase

  import Phoenix.LiveViewTest

  test "user can increase counter", %{conn: conn} do
    {:ok, view, _} = live(conn, ~p"/counter")

    view
    |> element("#increment")
    |> render_click()

    assert has_element?(view, "#count", "1")
  end

  test "user can increase counter (potentially false positive)", %{conn: conn} do
    {:ok, view, _} = live(conn, ~p"/counter")

    html =
      view
      |> element("#increment")
      |> render_click()

    assert html =~ "1"
  end

  test "user can increase counter (target event directly)", %{conn: conn} do
    {:ok, view, _} = live(conn, ~p"/counter")

    render_click(view, "increase")

    assert has_element?(view, "#count", "1")
  end

  test "user can decrease counter", %{conn: conn} do
    {:ok, view, _} = live(conn, ~p"/counter")

    view
    |> element("#decrement")
    |> render_click()

    assert has_element?(view, "#count", "-1")
  end
end
