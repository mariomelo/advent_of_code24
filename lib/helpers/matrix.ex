defmodule Helpers.Matrix do
  def create_from_input(input) do
    room_list =
      input
      |> String.split("\n", trim: true)
      |> Enum.map(fn line -> String.split(line, "", trim: true) end)

    for room_line <- Range.new(0, length(room_list) - 1),
        room_column <- Range.new(0, length(Enum.at(room_list, room_line)) - 1) do
      content = room_list |> Enum.at(room_line) |> Enum.at(room_column)
      {{room_line, room_column}, content}
    end
    |> Map.new()
  end

  def get_matrix_lines_and_columns(map) do
    {{line, _h}, _value} = Enum.max_by(map, fn {{line, _column}, _value} -> line end)
    {{_w, column}, _value} = Enum.max_by(map, fn {{_line, column}, _value} -> column end)

    {Range.new(0, line) |> Range.to_list(), Range.new(0, column) |> Range.to_list()}
  end

  def get_distance(point1, point2) do
    {y1, x1} = point1
    {y2, x2} = point2

    abs(y1 - y2) + abs(x1 - x2)
  end

  def get_all_points_in_line(point1, point2, lines, columns) do
    {y1, x1} = point1
    {y2, x2} = point2
    equation = {y1 - y2, x1 - x2}

    limits = {length(lines), length(columns)}

    points_forward = get_line_points_forward(point1, equation, limits, [])
    points_backward = get_line_points_backward(point1, equation, limits, [])

    Enum.concat(points_forward, points_backward)
    |> Enum.uniq()
  end

  defp get_line_points_forward({current_x, current_y}, _equation, _limits, results)
       when current_x < 0 or current_y < 0,
       do: results

  defp get_line_points_forward({current_x, current_y}, _equation, {size_y, size_x}, results)
       when current_x >= size_x or current_y >= size_y,
       do: results

  defp get_line_points_forward(
         point = {current_y, current_x},
         equation = {eq_y, eq_x},
         limits,
         results
       ) do
    get_line_points_forward({current_y + eq_y, current_x + eq_x}, equation, limits, [
      point | results
    ])
  end

  defp get_line_points_backward({current_x, current_y}, _equation, _limits, results)
       when current_x < 0 or current_y < 0,
       do: results

  defp get_line_points_backward({current_x, current_y}, _equation, {size_y, size_x}, results)
       when current_x >= size_x or current_y >= size_y,
       do: results

  defp get_line_points_backward(
         point = {current_y, current_x},
         equation = {eq_y, eq_x},
         limits,
         results
       ) do
    get_line_points_backward({current_y - eq_y, current_x - eq_x}, equation, limits, [
      point | results
    ])
  end
end
