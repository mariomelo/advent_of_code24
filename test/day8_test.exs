defmodule Day8Test do
  use ExUnit.Case

  @input """
  ............
  ........0...
  .....0......
  .......0....
  ....0.......
  ......A.....
  ............
  ............
  ........A...
  .........A..
  ............
  ............
  """

  describe "Day 8: " do
    test "Find the antinodes in a line in a given distance" do
      assert Day8.count_locations_with_antinodes(@input, false) == 14
    end

    test "Find the antinodes in a line in any distance" do
      assert Day8.count_locations_with_antinodes(@input, true) == 34
    end
  end
end
