defmodule Advent.Day2 do
  import Advent.Helper

  @input "day2" |> load_input() |> String.trim() |> String.split(",")

  def input, do: @input

  def go do
    part1() |> debug(label: "Part1")
    part2() |> debug(label: "Part2")
  end

  def part1 do
    input()
    |> Intcode.new()
    |> Intcode.set_memory(1, 12)
    |> Intcode.set_memory(2, 2)
    |> Intcode.run()
    |> Intcode.get_memory(0)
  end

  def part2 do
    memory = input()
    computer = Intcode.new(memory)

    max = length(memory) - 1
    inputs = for x <- 0..max, y <- 0..max, do: {x, y}

    attempt_combination = fn {x, y} ->
      computer
      |> Intcode.set_memory(1, x)
      |> Intcode.set_memory(2, y)
      |> Intcode.run()
      |> Intcode.get_memory(0)
      |> Kernel.==(19_690_720)
    end

    {x, y} = Enum.find(inputs, attempt_combination)

    100 * x + y
  end
end
