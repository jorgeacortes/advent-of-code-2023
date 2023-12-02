
defmodule CalibrationTest do
  use ExUnit.Case
  alias AdventOfCode2023.Calibration

  doctest Calibration

  test "Calibration document is read correctly" do
    assert {:ok, 142} == Calibration.read_file("./test/01_calibration/data/document.txt")
    assert {:ok, 142} == Calibration.read_file("./test/01_calibration/data/document2.txt")
  end
end
