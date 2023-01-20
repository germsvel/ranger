defmodule Ranger.Repo.Migrations.CreateSubscriptions do
  use Ecto.Migration

  def change do
    create table(:subscriptions) do
      add :email, :string, null: false

      timestamps()
    end
  end
end
