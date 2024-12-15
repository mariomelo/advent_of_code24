defmodule Day4 do
  @filename "day4.txt"

  @word_size 4
  @valid_words ["XMAS", "SAMX"]

  def find_all_xmas(input) do
    lines = handle_input(input)

    horizontal =
      lines
      |> Enum.map(&find_horizontal_xmas/1)
      |> Enum.sum()

    vertical =
      lines
      |> find_vertical_xmas()
      |> Enum.sum()

    bottom_diagonal(lines) + top_diagonal(lines) + vertical + horizontal
  end

  defp bottom_diagonal(lines) do
    (diagonal_from_bottom(lines) ++ diagonal_from_bottom_left(lines))
    |> Enum.map(&find_horizontal_xmas/1)
    |> Enum.sum()
  end

  defp top_diagonal(lines) do
    (diagonal_from_top(lines) ++ diagonal_from_top_left(lines))
    |> Enum.map(&find_horizontal_xmas/1)
    |> Enum.sum()
  end

  defp diagonal_from_bottom(lines) do
    columns = Range.new(0, length(lines) - 1) |> Range.to_list()

    Enum.map(columns, fn column ->
      create_diagonal_word(Enum.reverse(lines), column)
    end)
  end

  defp diagonal_from_top(lines) do
    columns = Range.new(0, length(lines) - 1) |> Range.to_list()

    Enum.map(columns, fn column ->
      create_diagonal_word(lines, column)
    end)
  end

  defp diagonal_from_bottom_left(original_lines) do
    lines =
      original_lines
      |> Enum.reverse()
      |> Enum.slice(1, length(original_lines) - 1)
      |> transpose()

    columns = Range.new(0, length(lines) - 1) |> Range.to_list()

    Enum.map(columns, fn column ->
      create_diagonal_word(lines, column)
    end)
  end

  defp diagonal_from_top_left(original_lines) do
    lines =
      original_lines
      |> Enum.slice(1, length(original_lines) - 1)
      |> transpose()

    columns = Range.new(0, length(lines) - 1) |> Range.to_list()

    Enum.map(columns, fn column ->
      create_diagonal_word(lines, column)
    end)
  end

  defp create_diagonal_word(lines, column) do
    Enum.with_index(lines)
    |> Enum.map(fn {line, index} -> Enum.at(line, column + index) end)
  end

  def transpose(list) do
    Enum.zip_with(list, &Function.identity/1)
  end

  defp find_vertical_xmas(line) do
    line
    |> transpose()
    |> Enum.map(&find_horizontal_xmas/1)
  end

  def find_horizontal_xmas(line) do
    Enum.chunk_every(line, @word_size, 1, :discard)
    |> Enum.map(fn letters -> Enum.join(letters, "") end)
    |> Enum.count(fn word -> word in @valid_words end)
  end

  defp handle_input(input) do
    String.split(input, "\n", trim: true)
    |> Enum.map(fn line -> String.split(line, "", trim: true) end)
  end

  def first_star do
    Helpers.FileReader.read_file(@filename)
    |> find_all_xmas
  end

  def second_star do
    Helpers.FileReader.read_file(@filename)
  end
end
