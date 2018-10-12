defmodule Every do
  @moduledoc """
  Every gives you ability to use `Process.send_after/3`
  with calculated intervals which can be rounded to every

    1. Five minutes,
    2. Fifteen minutes,
    3. Hour,
    4. Day (midnight)

  Every method accepts optional `initial_time` parameter
  if it is provided then seconds til next call will be
  calculated relative to give `initial_time`.
  """
  @type initial_time() :: DateTime.t | NaiveDateTime.t
  @type round_value() :: DateTime.t | NaiveDateTime.t

  @spec round_to(initial_time()) :: integer()
  def five_minutes(initial_time \\ nil) do

  end

  @spec round_to(initial_time()) :: integer()
  def fifteen_minutes(initial_time \\ nil) do

  end

  @spec round_to(initial_time()) :: integer()
  def hour(initial_time \\ nil) do

  end

  @spec round_to(initial_time()) :: integer()
  def day(initial_time \\ nil) do

  end

  @spec round_to(initial_time(), round_value()) :: integer()
  defp round_to(initial_time \\ nil, round_value) do
    truncated = DateTime.truncate(initial_time, :seconds)
  end
end
