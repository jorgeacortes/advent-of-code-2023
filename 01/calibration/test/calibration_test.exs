defmodule CalibrationTest do
  use ExUnit.Case
  doctest Calibration

  test "Calibration document is read correctly" do
    assert {:ok, 142} == Calibration.read_file("./data/document.txt")
    assert {:ok, 142} == Calibration.read_file("./data/document2.txt")
  end
end
