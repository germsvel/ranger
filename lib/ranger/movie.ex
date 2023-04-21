defmodule Ranger.Movie do
  use Ecto.Schema
  import Ecto.Changeset

  schema "movies" do
    field :poster_urls, {:array, :string}, default: []
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(movie \\ %__MODULE__{}, attrs) do
    movie
    |> cast(attrs, [:name, :poster_urls])
    |> validate_required([:name, :poster_urls])
  end
end
