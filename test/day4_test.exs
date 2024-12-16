defmodule Day4Test do
  use ExUnit.Case

  describe "Day 4: " do
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

    test "check if a 3x3 square is an X-mas X" do
      xmas1 =
        """
        MXS
        AAA
        MXS
        """
        |> String.split("\n", trim: true)
        |> Enum.map(fn line -> String.split(line, "", trim: true) end)

      xmas2 =
        """
        MXM
        AAA
        SXS
        """
        |> String.split("\n", trim: true)
        |> Enum.map(fn line -> String.split(line, "", trim: true) end)

      not_xmas =
        """
        MXS
        AAA
        SXS
        """
        |> String.split("\n", trim: true)
        |> Enum.map(fn line -> String.split(line, "", trim: true) end)

      assert Day4.is_this_square_an_x_mas?(xmas1) == true
      assert Day4.is_this_square_an_x_mas?(xmas2) == true
      assert Day4.is_this_square_an_x_mas?(not_xmas) == false
    end

    test "find all x-mas X's in an input" do
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

      assert Day4.find_all_mas_xs(input) == 9
    end
  end
end
