defmodule Builds do
  @derive [Poison.Encoder]
  defstruct [:ref, :status, :finished_at]
end
