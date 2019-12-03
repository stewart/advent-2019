defmodule Advent.Day3Test do
  use ExUnit.Case, async: true

  alias Advent.Day3

  defp instructions(input) do
    input
    |> String.split(",")
    |> Enum.map(&Day3.parse_instruction/1)
  end

  test "parse_instruction/1" do
    expected = [
      right: 75,
      down: 30,
      right: 83,
      up: 83,
      left: 12,
      down: 49,
      right: 71,
      up: 7,
      left: 72
    ]

    assert instructions("R75,D30,R83,U83,L12,D49,R71,U7,L72") == expected
  end

  test "closest_intersection_distance 1" do
    wire_one = instructions("R75,D30,R83,U83,L12,D49,R71,U7,L72")
    wire_two = instructions("U62,R66,U55,R34,D71,R55,D58,R83")
    assert Day3.closest_intersection_distance([wire_one, wire_two]) == 159
  end

  test "closest_intersection_distance 2" do
    wire_one = instructions("R98,U47,R26,D63,R33,U87,L62,D20,R33,U53,R51")
    wire_two = instructions("U98,R91,D20,R16,D67,R40,U7,R15,U6,R7")
    assert Day3.closest_intersection_distance([wire_one, wire_two]) == 135
  end

  test "manhattan_distance/2" do
    assert Day3.manhattan_distance({0, 0}, {1, 1}) == 2
  end
end
