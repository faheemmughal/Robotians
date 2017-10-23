defmodule Robotians.RobotTest do
  use ExUnit.Case, async: true
  alias Robotians.Robot

  doctest Robot

  setup do
    [
      state: %{
        position: %{x: 1, y: 5, orientation: "N"},
        size: %{x: 5, y: 5}
      }
    ]
  end

  test "moves and returns the new position when it is on the grid", context do
    instruction = "R"
    expected_position = %{x: 1, y: 5, orientation: "E"}
    expected_state = %{context[:state]|position: expected_position}

    {:reply, {:ok, response}, new_state} =
      Robot.handle_call({:move, instruction}, nil, context[:state])

    assert response == expected_state
    assert new_state == expected_state
  end

  test "returns last known position if instruction take it off the grid", context do
    instruction = "F"
    expected_position = %{x: 1, y: 5, orientation: "N"}
    expected_state = %{context[:state]|position: expected_position}

    {:reply, {:lost, response}, new_state} =
      Robot.handle_call({:move, instruction}, nil, context[:state])

    assert response == expected_state
    assert new_state == expected_state
  end
end
