defmodule CubeConundrumTest do
  use ExUnit.Case
  alias AdventOfCode2023.CubeConundrum
  doctest CubeConundrum

  ExUnit.Case.register_attribute(__MODULE__, :data)

  @test_cases [
    %{
      rules: %{red: 12, green: 13, blue: 14},
      games_possible: [1, 2, 5],
    },
    %{
      rules: %{red: 12, green: 13, blue: 0},
      games_possible: [],
    },
    %{
      rules: %{red: 20, green: 20, blue: 20},
      games_possible: [1,2,3,4,5],
    },
    %{
      rules: %{red: 30, green: 30, blue: 30},
      games_possible: [1,2,3,4,5],
    },
  ]

  Enum.with_index(@test_cases, fn data, idx ->
    @data data
    test "CubeConundrum sample game is processed correctly: case #{idx}", context do
      %{rules: rules, games_possible: games} = context.registered.data
      sum = Enum.sum(games)
      assert {:ok, games, sum} == CubeConundrum.read_file(
              "./test/02_cube_conundrum/data/document.txt", rules)
    end
  end)

end
