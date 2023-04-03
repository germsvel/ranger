defmodule RangerWeb.AlbumLive.Index do
  use RangerWeb, :live_view

  import Phoenix.Naming, only: [humanize: 1]

  alias Ranger.{Album, Repo}

  def render(assigns) do
    ~H"""
    <div class="max-w-lg mx-auto space-y-6">
      <section phx-drop-target={@uploads.photos.ref}>
        <div class="space-y-2 border border-4 border-blue-100 p-8 rounded-md">
          <.form
            :let={f}
            for={@changeset}
            id="upload-form"
            phx-change="validate"
            phx-submit="save"
            class="flex flex-col space-y-6"
          >
            <.input field={{f, :name}} label="Name" />
            <.live_file_input upload={@uploads.photos} />

            <button
              type="submit"
              class="rounded-md bg-blue-50 px-3.5 py-2.5 text-sm font-semibold text-blue-600 shadow-sm hover:bg-blue-100"
            >
              Upload
            </button>
          </.form>
        </div>
      </section>

      <%= if !Enum.empty?(@uploads.photos.entries) do %>
        <section>
          <h2 class="text-xl font-bold text-center">Photo Previews</h2>

          <%= for err <- upload_errors(@uploads.photos) do %>
            <p class="text-red-500 font-semibold"><%= humanize(err) %></p>
          <% end %>

          <%= for entry <- @uploads.photos.entries do %>
            <figure class="space-y-2">
              <div class="text-right">
                <button
                  type="button"
                  data-role="cancel-upload"
                  phx-click="cancel-upload"
                  phx-value-ref={entry.ref}
                  aria-label="cancel"
                >
                  &times;
                </button>
              </div>

              <.live_img_preview data-role="image-preview" entry={entry} class="rounded-md" />
            </figure>
          <% end %>
        </section>
      <% end %>
    </div>
    """
  end

  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:changeset, Album.changeset(%{}))
     |> allow_upload(:photos, accept: ~w(.jpg .jpeg .png), max_entries: 2)}
  end

  def handle_event("validate", %{"album" => params}, socket) do
    changeset =
      params
      |> Album.changeset()
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("cancel-upload", %{"ref" => ref}, socket) do
    {:noreply, cancel_upload(socket, :photos, ref)}
  end

  def handle_event("save", %{"album" => params}, socket) do
    uploaded_file_paths =
      consume_uploaded_entries(socket, :photos, fn %{path: path}, entry ->
        dest = upload_destination(entry)
        File.cp!(path, dest)

        {:ok, Path.join(Ranger.public_uploads_path(), Path.basename(dest))}
      end)

    params
    |> Map.put("photo_urls", uploaded_file_paths)
    |> Album.changeset()
    |> Repo.insert()
    |> case do
      {:ok, album} ->
        {:noreply, push_navigate(socket, to: ~p"/albums/#{album}")}

      {:error, changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp upload_destination(entry) do
    Path.join(Ranger.uploads_dir(), filename(entry))
  end

  defp filename(entry) do
    "#{entry.uuid}-#{entry.client_name}"
  end
end
