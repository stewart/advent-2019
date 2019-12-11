defmodule Advent.Day4Test do
  use ExUnit.Case, async: true

  alias Advent.Day4

  test "part1" do
    assert Day4.part1() == 960
  end

  test "part2" do
    assert Day4.part2() == 626
  end

  test "valid_password?" do
    assert Day4.valid_password?(111_111)
    refute Day4.valid_password?(223_450)
    refute Day4.valid_password?(123_789)
  end

  test "very_valid_password?" do
    assert Day4.very_valid_password?(112_233)
    refute Day4.very_valid_password?(123_444)
    assert Day4.very_valid_password?(111_122)
  end
end
