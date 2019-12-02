defmodule Advent.Day2 do
  import Advent.Helper

  @input "day2"
         |> load_input()
         |> String.trim()
         |> String.split(",")
         |> Enum.map(&String.to_integer/1)

  def input, do: @input

  def go do
    part1() |> debug(label: "Part1")
    part2() |> debug(label: "Part2")
  end

  def part1 do
    run_with_input(input(), 12, 2)
  end

  def part2 do
    program = input()
    max = length(program) - 1

    inputs = for x <- 0..max, y <- 0..max, do: {x, y}

    {x, y} =
      Enum.find(inputs, fn {x, y} ->
        run_with_input(program, x, y) == 19_690_720
      end)

    100 * x + y
  end

  ## Utils

  def run_with_input(program, one, two) do
    program
    |> List.replace_at(1, one)
    |> List.replace_at(2, two)
    |> run_program()
    |> hd()
  end

  def run_program(program, instruction_ptr \\ 0) do
    case Enum.drop(program, instruction_ptr) do
      [1, x, y, idx | _] ->
        x = Enum.at(program, x)
        y = Enum.at(program, y)
        updated_program = List.replace_at(program, idx, x + y)
        run_program(updated_program, instruction_ptr + 4)

      [2, x, y, idx | _] ->
        x = Enum.at(program, x)
        y = Enum.at(program, y)
        updated_program = List.replace_at(program, idx, x * y)
        run_program(updated_program, instruction_ptr + 4)

      [99 | _] ->
        program

      other ->
        raise ArgumentError, "unexpected opcode: #{inspect(other)}"
    end
  end
end
