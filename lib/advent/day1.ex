defmodule Advent.Day1 do
  import Advent.Helper

  @input "day1"
         |> load_input()
         |> String.trim()
         |> String.split("\n")
         |> Enum.map(&String.to_integer/1)

  def input, do: @input

  def go do
    part1() |> debug(label: "Part 1")
    part2() |> debug(label: "Part 2")
  end

  def part1 do
    input() |> Stream.map(&fuel_for_mass/1) |> Enum.sum()
  end

  def part2 do
    input() |> Stream.map(&correct_fuel_for_mass/1) |> Enum.sum()
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
