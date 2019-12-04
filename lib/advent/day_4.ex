defmodule Advent.Day4 do
  import Advent.Helper

  @min 265_275
  @max 781_584

  def possible_values, do: @min..@max

  def go do
    part1() |> debug(label: "Part1")
    # part2() |> debug(label: "Part2")
  end

  def part1 do
    possible_values()
    |> Enum.filter(&valid_password?/1)
    |> Enum.count()
  end

  def part2 do
    possible_values()
    |> Enum.filter(&very_valid_password?/1)
    |> Enum.count()
  end

  def valid_password?(password) do
    password = Integer.to_charlist(password)
    never_decreases?(password) and has_adjacency?(password)
  end

  def very_valid_password?(password) do
    valid_password?(password) and has_double_only_match?(password)
  end

  defp never_decreases?(numbers) do
    numbers
    |> Enum.chunk_every(2, 1)
    |> Enum.all?(fn
      [x, y] when y < x -> false
      _ -> true
    end)
  end

  defp has_adjacency?(numbers) do
    numbers
    |> Enum.chunk_every(2, 1)
    |> Enum.any?(fn
      [x, x] -> true
      _ -> false
    end)
  end

  def has_double_only_match?(numbers) do
    numbers
    |> Integer.to_charlist()
    |> Enum.chunk_by(fn num -> num end)
    |> Enum.any?(fn numbers -> length(numbers) == 2 end)
  end
end
