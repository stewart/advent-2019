defmodule Advent.Day1Test do
  use ExUnit.Case, async: true

  alias Advent.Day1

  test "part1/0" do
    assert Day1.part1() == 3_454_942
  end

  test "part2/0" do
    assert Day1.part2() == 5_179_544
  end

  test "fuel_for_mass/1" do
    assert Day1.fuel_for_mass(12) == 2
    assert Day1.fuel_for_mass(14) == 2
    assert Day1.fuel_for_mass(1969) == 654
    assert Day1.fuel_for_mass(100_756) == 33583
  end

  test "correct_fuel_for_mass/1" do
    assert Day1.correct_fuel_for_mass(14) == 2
    assert Day1.correct_fuel_for_mass(1969) == 966
    assert Day1.correct_fuel_for_mass(100_756) == 50346
  end
end
