defmodule Robotians.Mars do
  @moduledoc """
  Mars Agent
  Keeps track of mars size and scents of lost robots
  """

  use Agent

  # Client

  def start(size) do
    Agent.start_link(fn ->
        %{
          size: size,
          scented_coordinates: []
        }
      end,
      name: __MODULE__)
  end

  def size do
    Agent.get(__MODULE__, fn state ->
      state.size
    end)
  end

  def scented_coordinates do
    Agent.get(__MODULE__, fn state ->
      state.scented_coordinates
    end)
  end

  def add_scented_coordinate(coordinate) do
    Agent.update(__MODULE__,
      fn(state=%{scented_coordinates: scented_coordinates}) ->
        %{state|scented_coordinates: [coordinate|scented_coordinates]}
      end
    )
  end
end
