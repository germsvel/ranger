defmodule RangerWeb.MovieLive.IndexDoneTest do
  use RangerWeb.ConnCase

  import Phoenix.LiveViewTest

  alias Ranger.{CloudinaryUpload, Movie, Repo}

  test "user can see preview of poster to be uploaded", %{conn: conn} do
    {:ok, view, _html} = live(conn, ~p"/movies")

    view |> upload("fellowship-poster.jpg")

    assert has_element?(view, "[data-role='image-preview']")
  end

  test "user can cancel upload", %{conn: conn} do
    {:ok, view, _html} = live(conn, ~p"/movies")

    view
    |> upload("fellowship-poster.jpg")
    |> cancel_upload()

    refute has_element?(view, "[data-role='image-preview']")
  end

  test "user sees error when uploading too many files", %{conn: conn} do
    {:ok, view, _html} = live(conn, ~p"/movies")

    view
    |> upload("fellowship-poster.jpg")
    |> upload("fellowship-poster.jpg")
    |> upload("fellowship-poster.jpg")

    assert render(view) =~ "Too many files"
  end

  test "generates correct metadata for external upload", %{conn: conn} do
    {:ok, view, _html} = live(conn, ~p"/movies")

    {:ok, %{entries: entries}} =
      view
      |> file_input("#upload-form", :posters, [
        %{
          name: "fellowship-poster.jpg",
          content: File.read!("test/support/images/fellowship-poster.jpg"),
          type: "image/jpeg"
        }
      ])
      |> preflight_upload()

    for {_k, v} <- entries do
      assert v.uploader == "Cloudinary"
      assert v.url =~ CloudinaryUpload.image_api_url(cloud_name())
      assert v.fields[:folder] == "testing-liveview"

      assert is_binary(v.fields[:public_id])
      refute String.ends_with?(v.fields[:public_id], ".png")

      assert is_binary(v.fields[:signature])
      refute is_nil(v.fields[:api_key])
      refute is_nil(v.fields[:timestamp])
    end
  end

  test "user can create movie and stores correct URLs", %{conn: conn} do
    {:ok, view, _html} = live(conn, ~p"/movies")

    {:ok, show_view, _show_html} =
      view
      |> upload("fellowship-poster.jpg")
      |> create_movie("The Fellowship of the Ring")
      |> follow_redirect(conn)

    assert has_element?(show_view, "h2", "The Fellowship of the Ring")
    assert has_element?(show_view, "[data-role='image']")
    assert hd(last_movie().poster_urls) =~ CloudinaryUpload.image_url(cloud_name())
  end

  defp last_movie do
    Movie |> Ecto.Query.last() |> Repo.one()
  end

  defp cloud_name do
    Application.get_env(:ranger, :cloudinary)[:cloud_name]
  end

  defp create_movie(view, name) do
    view
    |> form("#upload-form", %{movie: %{name: name}})
    |> render_submit()
  end

  defp cancel_upload(view) do
    view
    |> element("[data-role='cancel-upload']")
    |> render_click()
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
end
