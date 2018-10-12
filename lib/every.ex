defmodule Every do
  @moduledoc """
  Every gives you ability to use `Process.send_after/3`
  with calculated intervals which can be rounded to every

    1. Five minutes,
    2. Fifteen minutes,
    3. Hour,
    4. Day (midnight)

  Every method accepts optional `relative_to` parameter
  if it is provided then seconds til next call will be
  calculated relative to give `relative_to`.
  """
  use Timex

  def five_minutes(relative_to \\ Timex.now()) do
    next_due = get_next_interval(relative_to.minute, 5) - relative_to.minute
    Timex.shift(relative_to, minutes: next_due)
    |> get_diff(relative_to)
  end

  def fifteen_minutes(relative_to \\ Timex.now()) do
    next_due = get_next_interval(relative_to.minute, 15) - relative_to.minute
    Timex.shift(relative_to, minutes: next_due)
    |> get_diff(relative_to)
  end

  defp get_diff(result, initial_time) do
    clamped = %{result | :second => 0, :microsecond => {0, 0}}
    DateTime.diff(clamped, initial_time, :second)
  end

  defp get_next_interval(value, round_value) do
    value - rem(value, round_value) + round_value
  end
end
