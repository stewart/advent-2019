defmodule Advent.Day5Test do
  use ExUnit.Case, async: true

  alias Advent.Day5

  test "part1" do
    assert Day5.part1() == 6_731_945
  end

  test "part2" do
    assert Day5.part2() == 9_571_668
  end
end
