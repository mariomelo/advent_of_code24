defmodule Day2 do
  @filename "day2.txt"

  def get_total_dampened_reports(input) do
    input
    |> handle_input()
    |> Enum.map(&Day2.is_dampened_report_safe?/1)
    |> Enum.count(fn item -> item == true end)
  end

  def get_total_safe_reports(input) do
    input
    |> handle_input()
    |> Enum.map(&Day2.is_report_safe?/1)
    |> Enum.count(fn item -> item == true end)
  end

  def is_dampened_report_safe?(report) do
    is_report_safe?(report) or is_dampened_report_safe?(report, 0)
  end

  defp is_dampened_report_safe?(report, level_to_exclude)
       when length(report) == level_to_exclude,
       do: false

  defp is_dampened_report_safe?(report, level_to_exclude) do
    dampened_report = List.delete_at(report, level_to_exclude)

    is_report_safe?(dampened_report) or is_dampened_report_safe?(report, level_to_exclude + 1)
  end

  def is_report_safe?(report) do
    check_distance(report) and check_order(report)
  end

  defp check_order(report) when length(report) == 1, do: true

  defp check_order([first_item, second_item | rest_of_report]) do
    if(first_item > second_item) do
      check_order([second_item | rest_of_report], :descending)
    else
      check_order([second_item | rest_of_report], :ascending)
    end
  end

  defp check_order(report, _) when length(report) == 1, do: true

  defp check_order([first_item, second_item | rest_of_report], :ascending) do
    first_item < second_item and check_order([second_item | rest_of_report], :ascending)
  end

  defp check_order([first_item, second_item | rest_of_report], :descending) do
    first_item > second_item and check_order([second_item | rest_of_report], :descending)
  end

  defp check_distance(report) when length(report) == 1, do: true

  defp check_distance([first_number, second_number | rest_of_report]) do
    distance = abs(first_number - second_number)
    distance >= 1 and distance <= 3 and check_distance([second_number | rest_of_report])
  end

  defp handle_input(input) do
    String.split(input, "\n", trim: true)
    |> Enum.map(&Day2.split_and_convert/1)
  end

  def split_and_convert(report_line) do
    String.split(report_line, " ", trim: true)
    |> Enum.map(&String.to_integer/1)
  end

  def first_star do
    Helpers.FileReader.read_file(@filename)
    |> get_total_safe_reports()
  end

  def second_star do
    Helpers.FileReader.read_file(@filename)
    |> get_total_dampened_reports()
  end
end
