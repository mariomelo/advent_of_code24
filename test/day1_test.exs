defmodule Day1Test do
  use ExUnit.Case
  doctest Advent2024

  test "Sums the distance correctly" do
    input = """
    3   4
    4   3
    2   5
    1   3
    3   9
    3   3
    """

    assert Day1.get_list_difference(input) == 11
  end

  test "Finds the similarity between lists" do
    input = """
    3   4
    4   3
    2   5
    1   3
    3   9
    3   3
    """

    assert Day1.get_list_similarity(input) == 31
  end
end
