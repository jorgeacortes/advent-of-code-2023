defmodule AdventOfCode2023.CubeConundrum do
  @moduledoc false

  def read_file(file_path, rules) do
    case File.read(file_path) do
      {:ok, content} ->
        games_record =
        read_games(content)
        |> Enum.map(fn {id, cube_string} -> {id, read_cube_string(cube_string)} end)

        result =
          games_record
          |> Enum.map(fn {id, game} -> {id, sum_cubes_by_color_and_play(game)}end)
          |> validate_games(rules)
          |> Enum.filter(fn {_, possible} -> possible end)
          |> Enum.map(fn {game_number, true} -> game_number end)

        sum = Enum.reduce(result, 0,  fn game, acc -> acc + game end)

      {:ok, result, sum}

      {:error, reason} ->
        IO.puts("Error reading the file: #{reason}")
        :error
    end
  end

  defp read_games(doc) do
    doc
    |> String.split("\n", trim: true)
    |> Enum.map(fn line -> String.split(line, ": ", trim: true) end)
    |> Enum.map(fn [game | [cubes | _]] -> {get_game_number(game), cubes} end)
  end

  defp get_game_number(s) do
    s
    |> String.replace("Game ", "")
    |> String.to_integer()
  end

  defp read_cube_string(cubes) do
      cubes
      |> String.split("; ", trim: true)
      |> Enum.map(fn play -> String.split(play, ", ", trim: true) end)
      |> Enum.map(fn play -> map_cubes(play) end)
  end

  defp map_cubes(cubes) do
    cubes
      |> Enum.map(fn x -> String.split(x, " ", trim: true) end)
      |> Enum.map(fn [num | [color]] -> {String.to_integer(num), color} end)

  end

  defp sum_play_cubes_by_color(play) do
    play
      |> Enum.reduce(%{}, fn {count, id}, acc ->
        atom_id = String.to_atom(id)
        Map.update(acc, atom_id, count, fn prev -> prev + count end)
      end)
  end

  defp sum_cubes_by_color_and_play(game_plays) do
    game_plays
      |> Enum.map(fn play -> sum_play_cubes_by_color(play) end)
  end

  defp validate_games(games, rules) do
    games
      |> Enum.map(fn game -> validate_game(game, rules) end)
  end

  defp validate_game({id, plays}, rules) do
    possible =
      plays
        |> Enum.map(fn play -> validate_play(play, rules) end)
        |> Enum.all?(fn possible -> possible == true end)
    {id, possible}
  end

  defp validate_play(cubes, rules) do
      cubes
        |> Map.to_list()
        |> Enum.all?(
          fn {cube_name, value} ->
            value <= Map.get(rules, cube_name)
          end)
  end

end
