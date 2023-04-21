defmodule RangerWeb.MovieLive.IndexTest do
  use RangerWeb.ConnCase

  import Phoenix.LiveViewTest

  test "user can create movie", %{conn: conn} do
    {:ok, view, _html} = live(conn, ~p"/movies")

    {:ok, show_view, _show_html} =
      view
      |> upload("fellowship-poster.jpg")
      |> create_movie("The Fellowship of the Ring")
      |> follow_redirect(conn)

    assert has_element?(show_view, "h2", "The Fellowship of the Ring")
    assert has_element?(show_view, "[data-role='image']")
  end

  defp upload(view, filename) do
    view
    |> file_input("#upload-form", :posters, [
      %{
        name: filename,
        content: File.read!("test/support/images/#{filename}"),
        type: "image/jpeg"
      }
    ])
    |> render_upload(filename)

    view
    |> form("#upload-form")
    |> render_change()

    view
  end

  defp create_movie(view, name) do
    view
    |> form("#upload-form", %{movie: %{name: name}})
    |> render_submit()
  end
end
