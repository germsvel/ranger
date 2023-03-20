defmodule Ranger.TimelineTest do
  use ExUnit.Case, async: true

  alias Ranger.Timeline

  describe "posts/1" do
    test "returns number of posts requested" do
      posts = Timeline.posts(limit: 10)

      assert Enum.count(posts) == 10
    end

    test "returns number of posts requested with offset" do
      first_ten = to_set(Timeline.posts(offset: 0, limit: 10))
      second_ten = to_set(Timeline.posts(offset: 10, limit: 10))

      assert MapSet.disjoint?(first_ten, second_ten)
    end

    defp to_set(enumerable), do: MapSet.new(enumerable)
  end
end
