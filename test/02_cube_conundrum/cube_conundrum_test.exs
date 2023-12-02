defmodule CubeConundrumTest do
  use ExUnit.Case
  alias AdventOfCode2023.CubeConundrum

  doctest CubeConundrum

  test "CubeConundrum sample game is processed correctly" do
    rules = ["12 red", "13 green", "14 blue"]
    games_possible = [1, 2, 5]
    games_sum = 8
    assert {:ok, games_possible, games_sum} == CubeConundrum.read_file("./test/02_cube_conundrum/data/document.txt", rules)
  end
end
