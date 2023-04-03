defmodule RangerWeb.AlbumLive.IndexDoneTest do
  use RangerWeb.ConnCase, async: false

  import Phoenix.LiveViewTest

  setup do
    on_exit(fn ->
      File.rm_rf!(Ranger.uploads_dir())
      File.mkdir!(Ranger.uploads_dir())
    end)
  end

  test "user can see preview of picture to be uploaded", %{conn: conn} do
    {:ok, view, _html} = live(conn, ~p"/albums")

    view
    |> file_input("#upload-form", :photos, [
      %{
        name: "moria-door.png",
        content: File.read!("test/support/images/moria-door.png"),
        type: "image/png"
      }
    ])
    |> render_upload("moria-door.png")

    assert has_element?(view, "[data-role='image-preview']")
  end

  test "user can cancel upload", %{conn: conn} do
    {:ok, view, _html} = live(conn, ~p"/albums")

    view
    |> upload("moria-door.png")
    |> cancel_upload()

    refute has_element?(view, "[data-role='image-preview']")
  end

  test "user sees error when uploading too many files", %{conn: conn} do
    {:ok, view, _html} = live(conn, ~p"/albums")

    view
    |> upload("moria-door.png")
    |> upload("moria-door.png")
    |> upload("moria-door.png")

    assert render(view) =~ "Too many files"
  end

  test "user sees error when not including album name", %{conn: conn} do
    {:ok, view, _html} = live(conn, ~p"/albums")

    html =
      view
      |> form("#upload-form", %{album: %{name: nil}})
      |> render_change()

    assert html =~ "can&#39;t be blank"
    assert has_element?(view, "p", "can't be blank")
  end

  test "user can submit upload", %{conn: conn} do
    {:ok, view, _html} = live(conn, ~p"/albums")

    {:ok, show_view, _show_html} =
      view
      |> upload("moria-door.png")
      |> create_album("Moria adventures")
      |> follow_redirect(conn)

    assert has_element?(show_view, "h2", "Moria adventures")
    assert has_element?(show_view, "[data-role='image']")
  end

  defp create_album(view, name) do
    view
    |> form("#upload-form", %{album: %{name: name}})
    |> render_submit()
  end

  defp cancel_upload(view) do
    view
    |> element("[data-role='cancel-upload']")
    |> render_click()
  end

  defp upload(view, filename) do
    view
    |> file_input("#upload-form", :photos, [
      %{
        name: filename,
        content: File.read!("test/support/images/#{filename}"),
        type: "image/png"
      }
    ])
    |> render_upload(filename)

    # ensure we have a phx-change
    # real form breaks if we don't have a phx-change validation
    view
    |> form("#upload-form")
    |> render_change()

    view
  end
end
