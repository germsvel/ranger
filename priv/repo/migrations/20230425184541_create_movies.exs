defmodule Ranger.Repo.Migrations.CreateMovies do
  use Ecto.Migration

  def change do
    create table(:movies) do
      add :name, :string, null: false
      add :poster_urls, {:array, :string}, null: false, default: []

      timestamps()
    end
  end
end
