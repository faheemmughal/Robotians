defmodule Robotians do
  @moduledoc """
  What's better than robots? Robots on Mars!
  """

  alias Robotians.Mars
  alias Robotians.Robot

  # Client

  def setup_world(size) do
    Mars.start_link(size)
  end

  def create_robot(start_position) do
    Robot.start_link(start_position)
  end

  def move_robot(pid, instructions) do
    case Robot.follow_instructions(pid, instructions) do
      {:lost, position} ->
        report_lost_robot
        {:lost, position}
      {:ok, position} ->
        {:ok, position}
    end
  end

  defp report_lost_robot(pid, position) do
    :ok = Mars.add_scented_coordinate(position)
    :ok = Robot.stop(pid)
  end
end
