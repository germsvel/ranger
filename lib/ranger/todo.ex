defmodule Ranger.Todo do
  use Ecto.Schema
  import Ecto.Changeset

  schema "todos" do
    field :body, :string

    timestamps()
  end

  @doc false
  def changeset(todo \\ %__MODULE__{}, attrs) do
    todo
    |> cast(attrs, [:body])
    |> validate_required([:body])
  end
end
