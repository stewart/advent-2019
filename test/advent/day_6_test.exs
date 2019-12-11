defmodule Advent.Day6Test do
  use ExUnit.Case, async: true

  alias Advent.Day6

  @example_1 """
  COM)B
  B)C
  C)D
  D)E
  E)F
  B)G
  G)H
  D)I
  E)J
  J)K
  K)L
  """

  test "orbit count" do
    map = @example_1 |> Day6.get_orbital_pairs() |> Day6.build_orbital_map()
    assert Day6.total_orbit_count(map, "COM") == 42
    assert Day6.part1() == 247_089
  end

  test "transfer cost" do
    assert Day6.part2() == 442
  end
end
