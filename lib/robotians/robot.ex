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

  def move(pid, instruction) do
    GenServer.call(pid, {:move, instruction})
  end

  # Server (callbacks)

  def handle_call({:move, instruction}, _from, state=%{position: position, size: size}) do
    new_position = PositionCalculator.calculate(instruction, position)

    {status, new_state} =
      case PositionCalculator.outside_grid?(size, new_position) do
        false -> {:ok, %{state|position: new_position}}
        true -> {:lost, state}
      end

    {:reply, {status, new_state}, new_state}
  end
end
