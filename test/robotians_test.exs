defmodule RobotiansTest do
  use ExUnit.Case

  setup do
    {:ok, mars} = Robotians.setup_mars(%{x: 5, y: 3})
    %{mars: mars}
  end

  test "Sample data" do
    # Sample data # 1
    # 11E
    # RFRFRFRF
    {:ok, pid} = Robotians.place_new_robot(%{x: 1, y: 1, orientation: "E"})
    instructions = ["R", "F", "R", "F", "R", "F", "R", "F"]

    {:ok, new_position} = Robotians.move_robot(pid, instructions)
    assert new_position == %{x: 1, y: 1, orientation: "E"}

    # Sample data # 2
    # 32N
    # FRRFLLFFRRFLL
    {:ok, pid} = Robotians.place_new_robot(%{x: 3, y: 2, orientation: "N"})
    instructions = ["F", "R", "R", "F", "L", "L", "F", "F", "R", "R", "F", "L", "L"]

    {status, new_position} = Robotians.move_robot(pid, instructions)
    assert status == :lost
    assert new_position == %{x: 3, y: 3, orientation: "N"}

    # Sample data # 3
    # 03W
    # LLFFFLFLFL
    {:ok, pid} = Robotians.place_new_robot(%{x: 0, y: 3, orientation: "W"})
    instructions = ["L", "L", "F", "F", "F", "L", "F", "L", "F", "L"]

    {:ok, new_position} = Robotians.move_robot(pid, instructions)
    assert new_position == %{x: 2, y: 3, orientation: "S"}
  end
end
