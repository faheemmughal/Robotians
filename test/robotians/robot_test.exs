defmodule Robotians.RobotTest do
  use ExUnit.Case, async: true
  alias Robotians.Robot
  alias Robotians.Mars

  setup_all do
    {:ok, mars} = Mars.start_link(%{x: 5, y: 5})
    %{mars: mars}
  end

  setup do
    [
      state: %{
        position: %{x: 1, y: 5, orientation: "N"},
        size: Mars.size()
      }
    ]
  end

  test "stays at original position if instructions are empty", context do
    instructions = []
    {:reply, {:ok, new_position}, new_state} =
      Robot.handle_call({:follow_instructions, instructions}, nil, context[:state])
    assert new_position == context[:state].position
    assert new_state == context[:state]
  end

  test "moves correctly if instructions are not off the grid", context do
    instructions = ["R", "R", "F", "F", "L"]
    expected_position = %{x: 1, y: 3, orientation: "E"}
    expected_state = %{context[:state]|position: expected_position}

    {:reply, {:ok, new_position}, new_state} =
      Robot.handle_call({:follow_instructions, instructions}, nil, context[:state])

    assert new_position == expected_state.position
    assert new_state == expected_state
  end

  test "returns last known position if instructions take it off the grid", context do
    instructions = ["L", "R", "F", "F", "L"]
    expected_position = %{x: 1, y: 5, orientation: "N"}
    expected_state = %{context[:state]|position: expected_position}

    {:reply, {:lost, new_position}, new_state} =
      Robot.handle_call({:follow_instructions, instructions}, nil, context[:state])

    assert new_position == expected_state.position
    assert new_state == expected_state
  end
end
