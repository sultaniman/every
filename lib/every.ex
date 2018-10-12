defmodule Every do
  @moduledoc """
  Every gives you ability to use `Process.send_after/3`
  with calculated intervals which can be rounded to every

    1. Five minutes,
    2. Fifteen minutes,
    3. Hour,
    4. Day (midnight)
  """
  @type initial_time() :: DateTime.t | NaiveDateTime.t

  @spec round_to(initial_time()) :: integer()
  def five_minutes(initial_time) do

  end

  @spec round_to(initial_time()) :: integer()
  def fifteen_minutes(initial_time) do

  end

  @spec round_to(initial_time()) :: integer()
  def hour(initial_time) do

  end

  @spec round_to(initial_time()) :: integer()
  def day(initial_time) do

  end

  @spec round_to(initial_time()) :: integer()
  defp round_to(initial_time, round_value) do
    truncated = DateTime.truncate(initial_time, :seconds)
  end
end
