defmodule Advent.Day3 do
  import Advent.Helper

  @input "day3"
         |> load_input()
         |> String.trim()
         |> String.split("\n")
         |> Enum.map(&(&1 |> String.split(",")))

  def input do
    for wire <- @input do
      for instruction <- wire do
        parse_instruction(instruction)
      end
    end
  end

  def go do
    part1() |> debug(label: "Part1")
    # part2() |> debug(label: "Part2")
  end

  def part1 do
    [one, two] = input()
    closest_intersection_distance(one, two)
  end

  # TODO implement me!
  def part2 do
    [one, two] = input()
  end

  def closest_intersection_distance(one, two) do
    [one, two]
    |> intersections()
    |> Enum.min_by(& manhattan_distance({0, 0}, &1))
    |> manhattan_distance({0, 0})
  end

  def closest_intersection_steps(one, two) do
  end

  def intersections(wires) do
    [one, two] = for wire <- wires, do: draw_path(wire)
    crossings = MapSet.intersection(one, two)
  end

  defp draw_path(instructions) do
    update = fn
      ({x, y}, {:up, amount}) ->
        visits = for n <- 0..amount, do: {x + n, y}
        final = {x + amount, y}
        {final, visits}

      ({x, y}, {:down, amount}) ->
        visits = for n <- 0..amount, do: {x - n, y}
        final = {x - amount, y}
        {final, visits}

      ({x, y}, {:left, amount}) ->
        visits = for n <- 0..amount, do: {x, y - n}
        final = {x, y - amount}
        {final, visits}

      ({x, y}, {:right, amount}) ->
        visits = for n <- 0..amount, do: {x, y + n}
        final = {x, y + amount}
        {final, visits}
    end

    {_, visited_locations} =
      Enum.reduce(instructions, {{0, 0}, MapSet.new()}, fn instruction, {position, visited} ->
        {position, visits} = update.(position, instruction)
        {position, MapSet.union(visited, MapSet.new(visits))}
      end)

    MapSet.delete(visited_locations, {0, 0})
  end

  def parse_instruction("U" <> n), do: {:up, String.to_integer(n)}
  def parse_instruction("D" <> n), do: {:down, String.to_integer(n)}
  def parse_instruction("L" <> n), do: {:left, String.to_integer(n)}
  def parse_instruction("R" <> n), do: {:right, String.to_integer(n)}

  defp manhattan_distance({x1, y1}, {x2, y2}), do: abs(x1 - x2) + abs(y1 - y2)
end
