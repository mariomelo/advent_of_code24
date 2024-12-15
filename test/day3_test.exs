defmodule Day3Test do
  use ExUnit.Case
  doctest Advent2024

  test "Calculates the instructions" do
    input = "xmul(2,4)%&mul[3,7]!@^do_not_mul(5,5)+mul(32,64]then(mul(11,8)mul(8,5))"

    assert Day3.calculate(input) == 161
  end

  test "Calculates the instructions with do's and dont's" do
    input = "xmul(2,4)&mul[3,7]!^don't()_mul(5,5)+mul(32,64](mul(11,8)undo()?mul(8,5))"

    assert Day3.calculate_with_donts(input) == 48
  end
end
