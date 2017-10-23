defmodule Robotians.PositionCalculatorTest do
  use ExUnit.Case, async: true
  alias Robotians.PositionCalculator

  setup do
    [
      size: %{x: 5, y: 5}
    ]
  end

  test "test outside_grid? to be true when position is outside the grid", context do
    assert PositionCalculator.outside_grid?(context[:size], %{x: 5, y: 6})
    assert PositionCalculator.outside_grid?(context[:size], %{x: 6, y: 5})
    assert PositionCalculator.outside_grid?(context[:size], %{x: -1, y: 0})
  end

  test "test outside_grid? to be false when position is inside the grid", context do
    refute PositionCalculator.outside_grid?(context[:size], %{x: 5, y: 5})
    refute PositionCalculator.outside_grid?(context[:size], %{x: 0, y: 0})
    refute PositionCalculator.outside_grid?(context[:size], %{x: 3, y: 3})
  end
end
