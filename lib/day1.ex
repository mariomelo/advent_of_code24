defmodule Day1 do
  @filename "day1.txt"

  def get_list_difference(input) do
    {first_list, second_list} = handle_input(input)

    Enum.zip(first_list, second_list)
    |> Enum.map(fn {first_num, second_num} -> abs(first_num - second_num) end)
    |> Enum.sum()
  end

  def get_list_similarity(input) do
    {first_list, second_list} = handle_input(input)

    first_list
    |> Enum.map(fn first_number ->
      result = first_number * Enum.count(second_list, fn n -> n == first_number end)
      result
    end)
    |> Enum.sum()
  end

  defp handle_input(input) do
    all_numbers =
      input
      |> String.split("\n", trim: true)
      |> Enum.flat_map(fn line -> String.split(line, " ", trim: true) end)
      |> Enum.map(&String.to_integer/1)

    first_list =
      all_numbers
      |> Enum.take_every(2)
      |> Enum.sort()

    second_list =
      all_numbers
      |> Enum.reverse()
      |> Enum.take_every(2)
      |> Enum.sort()

    {first_list, second_list}
  end

  def first_star do
    Helpers.FileReader.read_file(@filename)
    |> get_list_difference()
  end

  def second_star do
    Helpers.FileReader.read_file(@filename)
    |> get_list_similarity()
  end
end
