defmodule Ranger.NewsletterFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Ranger.Newsletter` context.
  """

  @doc """
  Generate a subscription.
  """
  def subscription_fixture(attrs \\ %{}) do
    {:ok, subscription} =
      attrs
      |> Enum.into(%{
        email: "some@example.com"
      })
      |> Ranger.Newsletter.create_subscription()

    subscription
  end
end
