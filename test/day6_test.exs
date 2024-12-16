defmodule Day6Test do
  use ExUnit.Case

  @input """
  ....#.....
  .........#
  ..........
  ..#.......
  .......#..
  ..........
  .#..^.....
  ........#.
  #.........
  ......#...
  """

  describe "Day 6: " do
    test "Calculate the guard's route length" do
      assert Day6.measure_route_length(@input) == 41
    end

    test "Calculate number of possible obstacles to create an infinitel oop" do
      assert Day6.find_positions_to_add_an_obstacle(@input) == 6
    end
  end
end
