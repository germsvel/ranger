defmodule RangerWeb.TodoLiveDoneTest do
  use RangerWeb.ConnCase

  import Phoenix.LiveViewTest

  test "user can create a new todo", %{conn: conn} do
    {:ok, view, _} = live(conn, ~p"/todo")

    view
    |> form("#add-todo", %{todo: %{body: "Form fellowship"}})
    |> render_submit()

    assert has_element?(view, "[data-role=todo]", "Form fellowship")
  end

  test "user can create new todo (possible false positive)", %{conn: conn} do
    {:ok, view, _} = live(conn, ~p"/todo")

    html =
      view
      |> form("#add-todo", %{todo: %{body: "Form fellowship"}})
      |> render_submit()

    assert html =~ "Form fellowship"
  end

  test "user can create new todo (send event directly)", %{conn: conn} do
    {:ok, view, _} = live(conn, ~p"/todo")

    view
    |> render_submit("create", %{todo: %{body: "Form fellowship"}})

    assert has_element?(view, "[data-role=todo]", "Form fellowship")
  end
end
