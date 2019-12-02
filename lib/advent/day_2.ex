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
    # part2() |> debug(label: "Part2")
  end

  def part1 do
    input()
    |> List.replace_at(1, 12)
    |> List.replace_at(2, 2)
    |> run_program()
    |> hd()
  end

  def part2 do
    input()
  end

  ## Utils

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
