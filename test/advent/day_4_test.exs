defmodule Advent.Day4Test do
  use ExUnit.Case, async: true

  alias Advent.Day4

  test "part1" do
    assert Day4.part1 == 960
  end

  test "part2" do
    assert Day4.part2 == 626
  end

  test "valid_password?" do
    assert Day4.valid_password?(111111)
    refute Day4.valid_password?(223450)
    refute Day4.valid_password?(123789)
  end

  test "very_valid_password?" do
    assert Day4.very_valid_password?(112233)
    refute Day4.very_valid_password?(123444)
    assert Day4.very_valid_password?(111122)
  end
end
