defmodule Day4Test do
  use ExUnit.Case
  doctest Advent2024

  test "Find all the XMAS in a small box" do
    input = """
    ...S.
    ..A..
    .M...
    X....
    """

    assert Day4.find_all_xmas(input) == 1
  end

  test "Find all the XMAS" do
    input = """
    MMMSXXMASM
    MSAMXMSMSA
    AMXSXMAAMM
    MSAMASMSMX
    XMASAMXAMM
    XXAMMXXAMA
    SMSMSASXSS
    SAXAMASAAA
    MAMMMXMMMM
    MXMXAXMASX
    """

    assert Day4.find_all_xmas(input) == 18
  end
end
