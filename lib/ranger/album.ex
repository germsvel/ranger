defmodule Ranger.Album do
  use Ecto.Schema
  import Ecto.Changeset

  schema "albums" do
    field :name, :string
    field :photo_urls, {:array, :string}, default: []

    timestamps()
  end

  @doc false
  def changeset(album \\ %__MODULE__{}, attrs) do
    album
    |> cast(attrs, [:name, :photo_urls])
    |> validate_required([:name, :photo_urls])
  end
end
