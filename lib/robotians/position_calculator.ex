defmodule Robotians.PositionCalculator do

  # Is the position inside grid or outside grid?
  def outside_grid?(_size=%{x: size_x}, _position=%{x: x}) when x < 0 or x > size_x do
    true
  end

  def outside_grid?(_size=%{y: size_y}, _position=%{y: y}) when y < 0 or y > size_y do
    true
  end

  def outside_grid?(_size, _position) do
    false
  end

  # Turn left
  def calculate("L", old_position=%{orientation: "N"}) do
    %{old_position | orientation: "W"}
  end

  def calculate("L", old_position=%{orientation: "E"}) do
    %{old_position | orientation: "N"}
  end

  def calculate("L", old_position=%{orientation: "S"}) do
    %{old_position | orientation: "E"}
  end

  def calculate("L", old_position=%{orientation: "W"}) do
    %{old_position | orientation: "S"}
  end

  # Turn right
  def calculate("R", old_position=%{orientation: "N"}) do
    %{old_position | orientation: "E"}
  end

  def calculate("R", old_position=%{orientation: "E"}) do
    %{old_position | orientation: "S"}
  end

  def calculate("R", old_position=%{orientation: "S"}) do
    %{old_position | orientation: "W"}
  end

  def calculate("R", old_position=%{orientation: "W"}) do
    %{old_position | orientation: "N"}
  end

  # move in the direction you are facing
  def calculate("F", old_position=%{y: y, orientation: "N"}) do
    %{old_position | y: y + 1}
  end

  def calculate("F", old_position=%{x: x, orientation: "E"}) do
    %{old_position | x: x + 1}
  end

  def calculate("F", old_position=%{y: y, orientation: "S"}) do
    %{old_position | y: y - 1}
  end

  def calculate("F", old_position=%{x: x, orientation: "W"}) do
    %{old_position | x: x - 1}
  end
end
