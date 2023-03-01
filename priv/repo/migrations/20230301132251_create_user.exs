defmodule Ranger.Repo.Migrations.CreateUser do
  use Ecto.Migration

  def change do
    create table(:user) do
      add :email, :string, null: false
      add :name, :string, null: false

      timestamps()
    end
  end
end
