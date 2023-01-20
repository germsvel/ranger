defmodule Ranger.Newsletter.Subscription do
  use Ecto.Schema
  import Ecto.Changeset

  schema "subscriptions" do
    field :email, :string

    timestamps()
  end

  @doc false
  def changeset(subscription, attrs) do
    subscription
    |> cast(attrs, [:email])
    |> validate_required([:email])
    |> validate_format(:email, ~r/.*@.*/)
  end
end
