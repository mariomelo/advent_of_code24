defmodule Day7 do
  @filename "day7.txt"

  def sum_viable_calculations(input) do
    equations = handle_input(input)

    equations
    |> Enum.map(fn {result, numbers} -> evaluate_line(numbers, result) end)
    |> Enum.with_index(fn result, index -> {result, Enum.at(equations, index)} end)
    |> Enum.filter(fn {result, _equation} -> result end)
    |> Enum.map(fn {_result, {value, _equation}} -> value end)
    |> Enum.sum()
  end

  def sum_viable_calculations_with_or_operator(input) do
    equations = handle_input(input)

    equations
    |> Enum.map(fn {result, numbers} -> evaluate_line_with_or_operator(numbers, result) end)
    |> Enum.with_index(fn result, index -> {result, Enum.at(equations, index)} end)
    |> Enum.filter(fn {result, _equation} -> result end)
    |> Enum.map(fn {_result, {value, _equation}} -> value end)
    |> Enum.sum()
  end

  defp handle_input(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(fn line -> String.split(line, ":", trim: true) |> List.to_tuple() end)
    |> Enum.map(&transform_line_into_struct/1)
  end

  defp evaluate_line([first_number | other_numbers], desired_result) do
    calculate_numbers(other_numbers, desired_result, first_number)
  end

  defp evaluate_line_with_or_operator([first_number | other_numbers], desired_result) do
    calculate_numbers_with_or_operator(other_numbers, desired_result, first_number)
  end

  defp calculate_numbers_with_or_operator(_numbers_left = [], desired_result, current_result),
    do: desired_result == current_result

  defp calculate_numbers_with_or_operator(
         [next_number | other_numbers],
         desired_result,
         current_result
       ) do
    concatenated_result = String.to_integer(to_string(current_result) <> to_string(next_number))

    calculate_numbers_with_or_operator(
      other_numbers,
      desired_result,
      current_result + next_number
    ) or
      calculate_numbers_with_or_operator(
        other_numbers,
        desired_result,
        current_result * next_number
      ) or
      calculate_numbers_with_or_operator(
        other_numbers,
        desired_result,
        concatenated_result
      )
  end

  defp calculate_numbers(_numbers_left = [], desired_result, current_result),
    do: desired_result == current_result

  defp calculate_numbers([next_number | other_numbers], desired_result, current_result) do
    calculate_numbers(other_numbers, desired_result, current_result + next_number) or
      calculate_numbers(other_numbers, desired_result, current_result * next_number)
  end

  defp transform_line_into_struct({result, numbers}) do
    numbers_as_integers =
      numbers
      |> String.split(" ", trim: true)
      |> Enum.map(&String.to_integer/1)

    {String.to_integer(result), numbers_as_integers}
  end

  def first_star do
    Helpers.FileReader.read_file(@filename)
    |> sum_viable_calculations()
  end

  def second_star do
    Helpers.FileReader.read_file(@filename)
    |> sum_viable_calculations_with_or_operator()
  end
end
