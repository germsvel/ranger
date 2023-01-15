defmodule RangerWeb.AvatarLiveDoneTest do
  use RangerWeb.ConnCase

  import Phoenix.LiveViewTest

  alias Ranger.Gravatar

  test "renders avatar for given email (probably)", %{conn: conn} do
    email = "frodo@shire.com"
    avatar_url = Gravatar.generate(email)
    {:ok, _view, html} = live(conn, ~p"/avatar/#{email}")

    assert html =~ avatar_url
  end

  test "renders avatar for given email (brittle)", %{conn: conn} do
    email = "frodo@shire.com"
    avatar_url = Gravatar.generate(email)
    {:ok, _view, html} = live(conn, ~p"/avatar/#{email}")

    avatar = ~s(<img class="avatar" src="#{avatar_url}")

    assert html =~ avatar
  end

  test "renders avatar for given email (robust)", %{conn: conn} do
    email = "frodo@shire.com"
    avatar_url = Gravatar.generate(email)
    {:ok, view, _html} = live(conn, ~p"/avatar/#{email}")

    assert has_element?(view, ~s(img[src*="#{avatar_url}"]))
  end

  test "renders avatar for given email (clear)", %{conn: conn} do
    email = "frodo@shire.com"
    avatar_url = Gravatar.generate(email)
    {:ok, view, _html} = live(conn, ~p"/avatar/#{email}")

    avatar = element(view, ~s(img[src*="#{avatar_url}"]))

    assert has_element?(avatar)
  end
end
