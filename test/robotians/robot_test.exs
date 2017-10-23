defmodule Robotians.RobotTest do
  use ExUnit.Case, async: true
  alias Robotians.Robot

  setup do
    [
      state: %{
        position: %{x: 1, y: 5, orientation: "N"},
        size: %{x: 5, y: 5}
      }
    ]
  end

  test "stays at original position if instructions are empty", context do
    instructions = []
    {:reply, {:ok, response}, new_state} =
      Robot.handle_call({:follow_instructions, instructions}, nil, context[:state])
    assert response == context[:state]
    assert new_state == context[:state]
  end

  test "moves correctly if instructions are not off the grid", context do
    instructions = ["R", "R", "F", "F", "L"]
    expected_position = %{x: 1, y: 3, orientation: "E"}
    expected_state = %{context[:state]|position: expected_position}

    {:reply, {:ok, response}, new_state} =
      Robot.handle_call({:follow_instructions, instructions}, nil, context[:state])

    assert response == expected_state
    assert new_state == expected_state
  end

  test "returns last known position if instructions take it off the grid", context do
    instructions = ["L", "R", "F", "F", "L"]
    expected_position = %{x: 1, y: 5, orientation: "N"}
    expected_state = %{context[:state]|position: expected_position}

    {:reply, {:lost, response}, new_state} =
      Robot.handle_call({:follow_instructions, instructions}, nil, context[:state])

    assert response == expected_state
    assert new_state == expected_state
  end
end
