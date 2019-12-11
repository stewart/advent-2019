defmodule Advent.Day6 do
  import Advent.Helper

  @input load_input("day6")

  def input, do: @input

  def go do
    part1() |> debug(label: "Part1")
    part2() |> debug(label: "Part2")
  end

  def part1 do
    input()
    |> get_orbital_pairs()
    |> build_orbital_map()
    |> total_orbit_count("COM")
  end

  def part2 do
    input()
    |> get_orbital_pairs()
    |> build_orbital_map()
    |> find_shortest_transfer!("YOU", "SAN")
  end

  def get_orbital_pairs(input) do
    input
    |> String.trim()
    |> String.split("\n")
    |> Enum.map(&String.split(&1, ")", parts: 2))
  end

  def build_orbital_map(orbit_pairs) do
    Enum.reduce(orbit_pairs, :digraph.new(), fn [a, b], graph ->
      :digraph.add_vertex(graph, a)
      :digraph.add_vertex(graph, b)
      :digraph.add_edge(graph, b, a)
      graph
    end)
  end

  def total_orbit_count(orbital_map, body, total \\ 0) do
    suborbit_count =
      orbital_map
      |> :digraph.in_neighbours(body)
      |> Stream.map(&total_orbit_count(orbital_map, &1, total + 1))
      |> Enum.sum()

    total + suborbit_count
  end

  # mutates map!
  def find_shortest_transfer!(orbital_map, orig, dest) do
    for [to, from] <- get_orbital_pairs(input()),
      do: :digraph.add_edge(orbital_map, to, from)

    case :digraph.get_short_path(orbital_map, orig, dest) do
      false -> raise "cannot find path from #{orig} to #{dest}"
      path -> length(path) - 3
    end
  end
end
