defmodule Ranger.Repo.Migrations.CreateAlbums do
  use Ecto.Migration

  def change do
    create table(:albums) do
      add :name, :string, null: false
      add :photo_urls, {:array, :string}, null: false, default: []

      timestamps()
    end
  end
end
