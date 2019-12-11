defmodule Advent.Day8 do
  import Advent.Helper

  @input "day8" |> load_input() |> String.trim()

  def input, do: @input

  def go do
    part1() |> debug(label: "Part1")
    part2() |> IO.puts()
  end

  def part1 do
    min_layer = input() |> layers() |> Enum.min_by(&num_digits(&1, 0))
    num_digits(min_layer, 1) * num_digits(min_layer, 2)
  end

  def part2 do
    input()
    |> layers()
    |> stack_image()
    |> make_printable()
  end

  def layers(input) do
    {:ok, stream} = StringIO.open(input)

    stream
    |> IO.binstream(1)
    |> Stream.map(&String.to_integer/1)
    |> Enum.chunk_every(150, 150, :discard)
  end

  def stack_image(layers) do
    stack_pixels = fn {front, back} -> with 2 <- front, do: back end
    Enum.reduce(layers, fn back_layer, front_layer ->
      Enum.zip(front_layer, back_layer) |> Enum.map(stack_pixels)
    end)
  end

  defp num_digits(layer, value) do
    Enum.count(layer, & &1 == value)
  end

  defp make_printable(image) do
    print_pixel = fn
      0 -> " "
      1 -> "*"
    end

    image
    |> Stream.map(print_pixel)
    |> Stream.chunk_every(25)
    |> Stream.intersperse("\n")
    |> Enum.to_list()
  end
end
