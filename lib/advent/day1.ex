defmodule Advent.Day1 do
  import Advent.Helper

  @input "day1"
         |> load_input()
         |> String.trim()
         |> String.split("\n")
         |> Enum.map(&String.to_integer/1)

  def go do
    input = @input
    part1(input)
    part2(input)
  end

  def part1(input) do
    input
    |> Stream.map(&fuel_for_mass/1)
    |> Enum.sum()
    |> debug(label: "Part1")
  end

  def part2(input) do
    input
    |> Task.async_stream(&correct_fuel_for_mass/1)
    |> Enum.map(fn {:ok, value} -> value end)
    |> Enum.sum()
    |> debug(label: "Part2")
  end

  def fuel_for_mass(mass) do
    trunc(mass / 3) - 2
  end

  def correct_fuel_for_mass(mass, acc \\ 0) do
    case fuel_for_mass(mass) do
      fuel when fuel > 0 ->
        correct_fuel_for_mass(fuel, acc + fuel)

      _ ->
        acc
    end
  end
end
