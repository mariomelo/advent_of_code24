defmodule Day3 do
  @filename "day3.txt"

  def calculate(input) do
    find_valid_statements(input)
  end

  def calculate_with_donts(input) do
    {_status, results} =
      input
      |> String.split(~r{do\(\)|don't\(\)}, include_captures: true)
      |> Enum.reduce({:do, []}, fn command, {status, results} ->
        case command do
          "do()" -> {:do, results}
          "don't()" -> {:dont, results}
          _ -> {status, evaluate_line(command, results, status)}
        end
      end)

    Enum.sum(results)
  end

  defp evaluate_line(_, results, :dont), do: results

  defp evaluate_line(input, results, :do) do
    [calculate(input) | results]
  end

  defp find_valid_statements(input) do
    Regex.scan(~r/mul\([0-9]{1,3},[0-9]{1,3}\)/, input)
    |> List.flatten()
    |> Enum.map(&clean_string/1)
    |> Enum.map(&Enum.product/1)
    |> Enum.sum()
  end

  defp clean_string(input) do
    String.replace(input, "mul(", "")
    |> String.replace(")", "")
    |> String.split(",", trim: true)
    |> Enum.map(&String.to_integer/1)
  end

  def first_star do
    Helpers.FileReader.read_file(@filename)
    |> calculate()
  end

  def second_star do
    Helpers.FileReader.read_file(@filename)
    |> calculate_with_donts()
  end
end
