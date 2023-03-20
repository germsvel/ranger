defmodule RangerWeb.TimelineLiveDoneTest do
  use RangerWeb.ConnCase, async: true

  import Phoenix.LiveViewTest

  alias Ranger.Timeline

  test "renders quotes", %{conn: conn} do
    [post] = Timeline.posts(limit: 1)
    {:ok, view, _html} = live(conn, ~p"/timeline")

    assert has_element?(view, "[data-role=post]", post.text)
    assert has_element?(view, "[data-role=author]", post.author)
  end

  test "user can see older posts with infinite scroll", %{conn: conn} do
    [post] = Timeline.posts(offset: 10, limit: 1)
    {:ok, view, _html} = live(conn, ~p"/timeline")

    view
    |> element("#load-more", "Loading ...")
    |> render_hook("load-more")

    assert has_element?(view, "[data-role=post]", post.text)
    assert has_element?(view, "[data-role=author]", post.author)
  end
end
