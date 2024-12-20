defmodule Day8 do
  alias Helpers.Matrix

  @filename "day8.txt"

  def count_locations_with_antinodes(input, ignore_distance?) do
    map = Matrix.create_from_input(input)

    {lines, columns} =
      Matrix.get_matrix_lines_and_columns(map)

    map
    |> find_antennas()
    |> Enum.flat_map(fn {_name, positions} ->
      find_all_antinodes(positions, lines, columns, ignore_distance?, [])
    end)
    |> List.flatten()
    |> Enum.uniq()
    |> Enum.count()
  end

  defp find_antennas(map) do
    map
    |> Enum.reject(fn {_position, content} -> content == "." end)
    |> Enum.group_by(
      fn {_position, antenna_name} -> antenna_name end,
      fn {position, _antenna_name} -> position end
    )
  end

  defp find_all_antinodes([], _lines, _columns, _ignore_distance?, results), do: results

  defp find_all_antinodes([current_antenna | rest], lines, columns, ignore_distance?, results) do
    antenna_results = find_antinodes(current_antenna, rest, lines, columns, ignore_distance?)
    find_all_antinodes(rest, lines, columns, ignore_distance?, [antenna_results | results])
  end

  defp find_antinodes(_antenna1, [], _lines, _columns, _ignore_distance?), do: []

  defp find_antinodes(antenna1, [antenna2 | other_antennas], lines, columns, ignore_distance?) do
    antinodes =
      Matrix.get_all_points_in_line(antenna1, antenna2, lines, columns)
      |> Enum.filter(fn point ->
        distance_from_antenna_1 = Matrix.get_distance(antenna1, point)
        distance_from_antenna_2 = Matrix.get_distance(antenna2, point)

        distance_from_antenna_1 == 2 * distance_from_antenna_2 or
          distance_from_antenna_2 == 2 * distance_from_antenna_1 or ignore_distance?
      end)

    [antinodes | find_antinodes(antenna1, other_antennas, lines, columns, ignore_distance?)]
  end

  def get_distances_from_antenna(antenna, lines, columns) do
    for line <- lines, column <- columns do
      {{line, column}, Matrix.get_distance({line, column}, antenna)}
    end
  end

  def first_star do
    Helpers.FileReader.read_file(@filename)
    |> count_locations_with_antinodes(false)
  end

  def second_star do
    Helpers.FileReader.read_file(@filename)
    |> count_locations_with_antinodes(true)
  end
end
