defmodule Every do
  @moduledoc """
  Documentation for Every.
  """
  @type initial_time() :: DateTime.t

  def five_minutes(initial_time) do
    
  end

  def fifteen_minutes(initial_time) do
    
  end

  def hour(initial_time) do
    
  end

  def day(initial_time) do
    
  end

  @spec round_to(initial_time()) :: integer()
  defp round_to(initial_time, round_value) do
    truncated = DateTime.truncate(initial_time, :seconds)
  end
end
