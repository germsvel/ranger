defmodule RangerWeb.SettingsLiveDoneTest do
  use RangerWeb.ConnCase, async: true

  import Phoenix.LiveViewTest

  alias Ranger.{Repo, User}

  test "renders user's information", %{conn: conn} do
    user = create_user()

    {:ok, _view, html} = live(conn, ~p"/users/#{user}/settings")

    assert html =~ user.name
    assert html =~ user.email
  end

  test "users can edit their name", %{conn: conn} do
    user = create_user(%{name: "frodo"})
    {:ok, view, _html} = live(conn, ~p"/users/#{user}/settings")

    view
    |> element("#name")
    |> render_click()

    view
    |> form("#name-form", %{name: "bilbo"})
    |> render_submit()

    assert has_element?(view, "#name", "bilbo")
  end

  test "users can edit their email", %{conn: conn} do
    user = create_user(%{email: "frodo@hobitton.com"})
    {:ok, view, _html} = live(conn, ~p"/users/#{user}/settings")

    view
    |> element("#email")
    |> render_click()

    view
    |> form("#email-form", %{email: "frodo@fellowship.com"})
    |> render_submit()

    assert has_element?(view, "#email", "frodo@fellowship.com")
  end

  defp create_user(params \\ %{}) do
    %{email: "random@example.com", name: "randomname"}
    |> Map.merge(params)
    |> User.changeset()
    |> Repo.insert!()
  end
end
