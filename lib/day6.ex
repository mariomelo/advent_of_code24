defmodule Day6 do
  alias Helpers.Matrix

  @filename "day6.txt"

  @guard_positions ["^", ">", "<", "v"]
  @directions %{
    "^" => :up,
    ">" => :right,
    "<" => :left,
    "v" => :down
  }

  def find_positions_to_add_an_obstacle(input) do
    room_map = create_room_map(input)
    {initial_position, direction} = find_initial_position(room_map)

    start_walking([], room_map, initial_position, direction)
    # Removes the starting position
    |> Enum.reverse()
    |> Enum.slice(1..-1)
    |> try_obstacles_in_steps(room_map, initial_position, direction)
    |> Enum.filter(fn item -> item == :loop end)
    |> Enum.count()
  end

  defp try_obstacles_in_steps(steps_taken, room_map, initial_position, direction) do
    steps_taken
    |> Enum.map(fn {position, _direction} -> position end)
    |> Enum.uniq()
    |> Enum.map(fn position ->
      updated_room_map =
        Map.update(room_map, position, "#", fn _ -> "#" end)

      start_walking([], updated_room_map, initial_position, direction)
    end)
  end

  def measure_route_length(input) do
    room_map = create_room_map(input)
    {initial_position, direction} = find_initial_position(room_map)

    start_walking([], room_map, initial_position, direction)
    |> Enum.map(fn {position, _direction} -> position end)
    |> Enum.uniq()
    |> Enum.count()
  end

  defp start_walking(positions_walked, _map, _current_position, :exit), do: positions_walked
  defp start_walking(_positions_walked, _map, _current_position, :loop), do: :loop

  defp start_walking(positions_walked, room_map, current_position, direction) do
    next_step_position = find_next_step(current_position, direction)
    next_step_content = Map.get(room_map, next_step_position, :exit)

    {next_position, next_direction} =
      get_next_position(next_step_content, current_position, direction, next_step_position)

    # The guard already walked this tile in the same direction, so it's a loop!
    is_a_loop? =
      Enum.any?(positions_walked, fn {past_position, past_direction} ->
        past_position == next_position and past_direction == next_direction
      end)

    next_direction = if is_a_loop?, do: :loop, else: next_direction

    start_walking(
      [{current_position, direction} | positions_walked],
      room_map,
      next_position,
      next_direction
    )
  end

  def get_next_position("#", current_position, :up, _next_step), do: {current_position, :right}
  def get_next_position("#", current_position, :right, _next_step), do: {current_position, :down}
  def get_next_position("#", current_position, :down, _next_step), do: {current_position, :left}
  def get_next_position("#", current_position, :left, _next_step), do: {current_position, :up}

  def get_next_position(:exit, current_position, _direction, _next_step),
    do: {current_position, :exit}

  def get_next_position(_, _current_position, direction, next_step), do: {next_step, direction}

  defp find_next_step({line, column}, :up), do: {line - 1, column}
  defp find_next_step({line, column}, :left), do: {line, column - 1}
  defp find_next_step({line, column}, :down), do: {line + 1, column}
  defp find_next_step({line, column}, :right), do: {line, column + 1}

  defp find_initial_position(room_map) do
    {position, direction} =
      room_map
      |> Enum.find(fn {_key, value} -> value in @guard_positions end)

    {position, Map.get(@directions, direction)}
  end

  defp create_room_map(input) do
    Matrix.create_from_input(input)
  end

  def first_star do
    Helpers.FileReader.read_file(@filename)
    |> measure_route_length()
  end

  # Answer: 1604 - It takes a while to run (about 5 minutes in my computer with an M3Pro processor)
  def second_star do
    Helpers.FileReader.read_file(@filename)
    |> find_positions_to_add_an_obstacle()
  end
end
