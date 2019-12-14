defmodule Advent.Day5 do
  import Advent.Helper

  @input "day5" |> load_input() |> String.trim() |> String.split(",")

  def input, do: @input

  def go do
    part1() |> debug(label: "Part1")
    part2() |> debug(label: "Part2")
  end

  def part1 do
    input()
    |> Intcode.new()
    |> Intcode.push_input(1)
    |> Intcode.run()
    |> Intcode.diagnostic_code()
  end

  def part2 do
    input()
    |> Intcode.new()
    |> Intcode.push_input(5)
    |> Intcode.run()
    |> Intcode.diagnostic_code()
  end
end
