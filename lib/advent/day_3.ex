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
    part2() |> debug(label: "Part2")
  end

  def part1 do
    input() |> min_manhattan_distance()
  end

  def part2 do
    input() |> min_drawn_distance()
  end

  def min_manhattan_distance(wires) do
    wires
    |> run_wires()
    |> Enum.map(&Map.keys/1)
    |> Enum.map(&MapSet.new/1)
    |> Enum.reduce(&MapSet.intersection/2)
    |> Enum.map(&manhattan_distance/1)
    |> Enum.min()
  end

  def min_drawn_distance(wires) do
    wires
    |> run_wires()
    |> Enum.reduce(&intersection_distance/2)
    |> Enum.min()
  end

  # the sum of distance each wire needs to run to get to the intersection
  def intersection_distance(a, b) do
    ak = a |> Map.keys() |> MapSet.new()
    bk = b |> Map.keys() |> MapSet.new()

    Enum.map(MapSet.intersection(ak, bk), fn coords ->
      Map.get(a, coords) + Map.get(b, coords)
    end)
  end

  def run_wires(wires) do
    for wire <- wires do
      {_, _, path} = Enum.reduce(wire, {{0, 0}, 0, %{}}, &step/2)
      path
    end
  end

  defp step({dir, amount}, {position, distance, path}) do
    new_position = move(position, dir, amount)

    new_path =
      Enum.reduce(1..amount, path, fn n, acc ->
        Map.put_new(acc, move(position, dir, n), distance + n)
      end)

    {new_position, distance + amount, new_path}
  end

  defp move({x, y}, :up, amount), do: {x + amount, y}
  defp move({x, y}, :down, amount), do: {x - amount, y}
  defp move({x, y}, :left, amount), do: {x, y - amount}
  defp move({x, y}, :right, amount), do: {x, y + amount}

  def parse_instruction("U" <> n), do: {:up, String.to_integer(n)}
  def parse_instruction("D" <> n), do: {:down, String.to_integer(n)}
  def parse_instruction("L" <> n), do: {:left, String.to_integer(n)}
  def parse_instruction("R" <> n), do: {:right, String.to_integer(n)}

  defp manhattan_distance({x, y}), do: abs(x) + abs(y)
end
