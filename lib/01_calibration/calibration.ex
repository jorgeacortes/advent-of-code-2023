defmodule AdventOfCode2023.Calibration do
  @moduledoc false

  def read_file(file_path) do
    result =
      case File.read(file_path) do
        {:ok, content} ->
          total =
            content
            |> String.split("\n", trim: true)
            |> Enum.map(&process_line/1)
            # |> IO.inspect()
            |> Enum.sum()

        # IO.puts("Sum: #{total}")

        {:ok, total}

        {:error, reason} ->
          IO.puts("Error reading the file: #{reason}")
          :error
      end
      result
  end

  defp process_line(line) do
    # IO.puts("Processing line: #{line}")
    result =
      line
      |> String.codepoints()
      |> extract_numbers()
      |> convert_number()

      # IO.puts("Result #{result}")

      result
  end

  defp extract_numbers(codepoints) do
    Enum.filter(codepoints,
      fn x ->
        x in numbers()
      end
    )
  end

  defp convert_number([first]) do
    {number, _} = Integer.parse(first <> first)
    number
  end

  defp convert_number([first | rest]) do
    {number, _} = Integer.parse(first <> extract_last(rest))
    number
  end

  defp convert_number([]) do
    0
  end

  defp extract_last([last]) do
    last
  end

  defp extract_last([_head | tail]) do
    extract_last(tail)
  end

  defp extract_last([]) do
  end

  defp numbers() do
    0..9
    |> Enum.to_list()
    |> Enum.map(fn x -> Integer.to_string(x) end)
  end

end
