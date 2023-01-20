defmodule Ranger.NewsletterTest do
  use Ranger.DataCase

  alias Ranger.Newsletter

  describe "subscriptions" do
    alias Ranger.Newsletter.Subscription

    import Ranger.NewsletterFixtures

    @invalid_attrs %{email: nil}

    test "create_subscription/1 with valid data creates a subscription" do
      valid_attrs = %{email: "some@example.com"}

      assert {:ok, %Subscription{} = subscription} = Newsletter.create_subscription(valid_attrs)
      assert subscription.email == "some@example.com"
    end

    test "create_subscription/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Newsletter.create_subscription(@invalid_attrs)
    end

    test "change_subscription/1 returns a subscription changeset" do
      subscription = subscription_fixture()
      assert %Ecto.Changeset{} = Newsletter.change_subscription(subscription)
    end
  end
end
