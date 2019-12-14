defmodule Advent.Day2Test do
  use ExUnit.Case, async: true

  alias Advent.Day2

  test "part1" do
    assert Day2.part1() == 4_570_637
  end

  test "part2" do
    assert Day2.part2() == 5485
  end
end
