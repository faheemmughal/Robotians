defmodule Robotians.MarsTest do
  use ExUnit.Case, async: true
  alias Robotians.Mars

  setup do
    {:ok, mars} = Mars.start_link(%{x: 5, y: 5})
    %{mars: mars}
  end

  test "gets the size" do
    assert Mars.size() == %{x: 5, y: 5}
  end

  test "gets scented cooridnates" do
    assert Mars.scented_coordinates() == []
  end

  test "sets scented cooridnates" do
    Mars.add_scented_coordinate(%{x: 0, y: 1})
    Mars.add_scented_coordinate(%{x: 4, y: 5})

    assert Mars.scented_coordinates() == [%{x: 4, y: 5}, %{x: 0, y: 1}]
  end
end
