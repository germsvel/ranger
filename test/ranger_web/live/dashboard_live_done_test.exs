defmodule RangerWeb.DashboardLiveDoneTest do
  use RangerWeb.ConnCase, async: true

  import Phoenix.LiveViewTest

  describe "Navigates to home page (outside of live_session)" do
    test "when clicking Testing LiveView (error tuple)", %{conn: conn} do
      {:ok, view, _html} = live(conn, ~p"/dashboard")

      {:error, {:redirect, %{to: path}}} =
        view
        |> element("#logo")
        |> render_click()

      assert path == ~p"/"
    end

    test "when clicking Testing LiveView (assert_redirect)", %{conn: conn} do
      {:ok, view, _html} = live(conn, ~p"/dashboard")

      view
      |> element("#logo")
      |> render_click()

      {path, _flash} = assert_redirect(view)
      assert path == ~p"/"
    end

    test "when clicking Testing LiveView (follow_redirect)", %{conn: conn} do
      {:ok, view, _html} = live(conn, ~p"/dashboard")

      {:ok, conn} =
        view
        |> element("#logo")
        |> render_click()
        |> follow_redirect(conn, ~p"/")

      html = html_response(conn, 200)
      assert html =~ "Testing"
      assert html =~ "LiveView"
    end
  end

  describe "Navigates to another LiveView (within live_session)" do
    test "when clicking Team (error tuple)", %{conn: conn} do
      {:ok, view, _html} = live(conn, ~p"/dashboard")

      {:error, {:live_redirect, %{to: path}}} =
        view
        |> element("[data-role=page-link]", "Team")
        |> render_click()

      assert path == ~p"/team"
    end

    test "when clicking Team (assert_redirect)", %{conn: conn} do
      {:ok, view, _html} = live(conn, ~p"/dashboard")

      view
      |> element("[data-role=page-link]", "Team")
      |> render_click()

      {path, _flash} = assert_redirect(view)
      assert path == ~p"/team"
    end

    test "when clicking Team (follow_redirect)", %{conn: conn} do
      {:ok, view, _html} = live(conn, ~p"/dashboard")

      {:ok, _team_view, team_html} =
        view
        |> element("[data-role=page-link]", "Team")
        |> render_click()
        |> follow_redirect(conn, ~p"/team")

      assert team_html =~ "Team"
    end
  end
end
