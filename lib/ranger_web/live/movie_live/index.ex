defmodule RangerWeb.MovieLive.Index do
  use RangerWeb, :live_view

  import Phoenix.Naming, only: [humanize: 1]

  alias Ranger.{CloudinaryUpload, Movie, Repo}

  def render(assigns) do
    ~H"""
    <div class="max-w-lg mx-auto space-y-6">
      <h2 class="text-2xl font-semibold text-blue-700 px-2 rounded-md bg-gradient-to-r from-blue-200 to-transparent">
        Your Favorite Movie Posters
      </h2>
      <section phx-drop-target={@uploads.posters.ref}>
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
            <.live_file_input upload={@uploads.posters} />

            <button
              type="submit"
              class="rounded-md bg-blue-50 px-3.5 py-2.5 text-sm font-semibold text-blue-600 shadow-sm hover:bg-blue-100"
            >
              Upload
            </button>
          </.form>
        </div>
      </section>

      <%= if !Enum.empty?(@uploads.posters.entries) do %>
        <section>
          <h2 class="text-xl font-bold text-center">Movie Poster Preview</h2>

          <%= for err <- upload_errors(@uploads.posters) do %>
            <p class="text-red-500 font-semibold"><%= humanize(err) %></p>
          <% end %>

          <%= for entry <- @uploads.posters.entries do %>
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
     |> assign(:changeset, Movie.changeset(%{}))
     |> allow_upload(:posters,
       accept: ~w(.jpg .jpeg .png),
       max_entries: 2,
       external: &presign_upload/2
     )}
  end

  def handle_event("validate", %{"movie" => params}, socket) do
    changeset =
      params
      |> Movie.changeset()
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("cancel-upload", %{"ref" => ref}, socket) do
    {:noreply, cancel_upload(socket, :posters, ref)}
  end

  def handle_event("save", %{"movie" => params}, socket) do
    uploaded_file_paths =
      consume_uploaded_entries(socket, :posters, fn _, entry ->
        {:ok, cloudinary_image_url(entry)}
      end)

    params
    |> Map.put("poster_urls", uploaded_file_paths)
    |> Movie.changeset()
    |> Repo.insert()
    |> case do
      {:ok, movie} ->
        {:noreply, push_navigate(socket, to: ~p"/movies/#{movie}")}

      {:error, changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp presign_upload(entry, socket) do
    cloud_name = cloudinary_config()[:cloud_name]

    fields = %{
      folder: "testing-liveview",
      public_id: filename(entry)
    }

    credentials = %{
      api_key: cloudinary_config()[:api_key],
      api_secret: cloudinary_config()[:api_secret]
    }

    updated_fields = CloudinaryUpload.sign_form_upload(fields, credentials)

    meta = %{
      uploader: "Cloudinary",
      url: CloudinaryUpload.image_api_url(cloud_name),
      fields: updated_fields
    }

    {:ok, meta, socket}
  end

  defp cloudinary_image_url(entry) do
    folder = "testing-liveview"
    cloud_name = cloudinary_config()[:cloud_name]
    cloudinary_url = CloudinaryUpload.image_url(cloud_name)

    Path.join([cloudinary_url, folder, filename(entry)])
  end

  defp filename(entry) do
    entry.uuid
  end

  defp cloudinary_config do
    Application.get_env(:ranger, :cloudinary)
  end
end
