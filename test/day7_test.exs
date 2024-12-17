defmodule Day7Test do
  use ExUnit.Case

  @input """
  190: 10 19
  3267: 81 40 27
  83: 17 5
  156: 15 6
  7290: 6 8 6 15
  161011: 16 10 13
  192: 17 8 14
  21037: 9 7 18 13
  292: 11 6 16 20
  """

  describe "Day 7: " do
    test "Sum all the viable calculations" do
      assert Day7.sum_viable_calculations(@input) == 3749
    end

    test "Sum all the viable calculations with the OR operator" do
      assert Day7.sum_viable_calculations_with_or_operator(@input) == 11387
    end
  end
end
