defmodule Robotians.Robot do
  @moduledoc """
  A Robot
  keeps track of it's position and responds to move commands
  """

  use GenServer
  alias Robotians.Mars
  alias Robotians.PositionCalculator

  # Client

  def start_link(initial_position) do
    GenServer.start_link(__MODULE__, %{
      size: Mars.size(),
      position: initial_position,
    })
  end

  def follow_instructions(pid, instructions) do
    GenServer.call(pid, {:follow_instructions, instructions})
  end

  def stop(pid) do
    GenServer.stop(pid)
  end

  # Server (callbacks)

  def handle_call({:follow_instructions, instructions}, _from, state) do
    {status, new_state} = move_all(instructions, state)
    {:reply, {status, new_state.position}, new_state}
  end

  # private

  defp move_all([], state) do
    {:ok, state}
  end

  defp move_all([first_instruction|instructions], state) do
    case move_one(first_instruction, state) do
      {:ok, new_state} -> move_all(instructions, new_state)
      {:lost, new_state} -> { :lost, new_state }
    end
  end

  # when going to move off grid from scented coordinate
  defp move_one("F", state=%{position: current_position}) do
    if Enum.member?(Mars.scented_coordinates, current_position) do
      {:ok, state}
    else
      calculate_new_position("F", state)
    end
  end

  # any instruction other than moving off grid from scented coordinate
  defp move_one(instruction, state) do
    calculate_new_position(instruction, state)
  end

  defp calculate_new_position(instruction, state=%{size: size, position: current_position}) do
    new_position = PositionCalculator.calculate(instruction, current_position)

    case PositionCalculator.outside_grid?(size, new_position) do
      false ->
        {:ok, %{state|position: new_position}}
      true ->
        {:lost, state}
    end
  end
end
