defmodule Day2Test do
  use ExUnit.Case
  doctest Advent2024

  test "Checks the amount of safe reports" do
    input = """
    7 6 4 2 1
    1 2 7 8 9
    9 7 6 2 1
    1 3 2 4 5
    8 6 4 4 1
    1 3 6 7 9
    """

    assert Day2.get_total_safe_reports(input) == 2
  end

  test "Maps unsafe situations" do
    input = """
    7 6 4 2 1
    1 2 7 8 9
    9 7 6 2 1
    1 3 2 4 5
    8 6 4 4 1
    1 3 6 7 9
    """

    assert Day2.get_total_dampened_reports(input) == 4
  end
end
