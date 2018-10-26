defmodule Every do
  @moduledoc """
  Every gives you ability to use `Process.send_after/3`
  with calculated intervals which can be rounded to every
  (note: all functions return values only in seconds)

    1. Minute,
    2. N minutes,
    3. Hour,
    4. N Hours.

  Every method accepts optional `relative_to` parameter
  if it is provided then duration in seconds until next
  call will be calculated relative to given `relative_to`.
  """

  @doc """
  Calculate how many seconds left
  until next minute starts.

  If `relative_to` `DateTime` is not provided
  then current moment in time is used.

  Returns: `integer` number of seconds.

  ## Example

      iex> {:ok, now, _} = DateTime.from_iso8601("2018-10-14T16:48:12.000Z")
      iex> Every.minute(now)
      48
  """
  def minute(relative_to \\ Timex.now()) do
    # Return seconds til next minute
    60 - relative_to.second
  end

  @doc """
  Calculate how many minutes left
  until next interval when relative
  `DateTime` is not provided and equals to `nil`.

  Returns: `integer` number of seconds.

  ## Example

      iex> {:ok, now, _} = DateTime.from_iso8601("2018-10-14T16:48:12.000Z")
      iex> Every.minutes(5, now)  # 16:50 > 15:50:00 - 16:48:12
      108
  """
  def minutes(interval, relative_to) when is_nil(relative_to) do
    minutes(interval, Timex.now())
  end

  @doc """
  Calculate how many minutes left
  until next interval.

  If `relative_to` `DateTime` is not provided
  then current moment in time is used.

  Returns: `integer` number of seconds.

  ## Example

      iex> {:ok, now, _} = DateTime.from_iso8601("2018-10-14T16:48:12.000Z")
      iex> Every.minutes(5, now)  # 16:50 > 15:50:00 - 16:48:12
      108
  """
  def minutes(interval, relative_to) do
    next_due = get_next_interval(relative_to.minute, interval) - relative_to.minute

    get_diff(
      Timex.shift(relative_to, minutes: next_due),
      relative_to
    )
  end

  @doc """
  Calculate how many minutes left
  until next hour starts.

  If `relative_to` `DateTime` is not provided
  then current moment in time is used.

  Returns: `integer` number of seconds.

  ## Example

      iex> {:ok, now, _} = DateTime.from_iso8601("2018-10-14T16:48:12.000Z")
      iex> Every.hour(now)
      768
  """
  def hour(relative_to \\ Timex.now()) do
    minutes_left = 60 - relative_to.minute
    seconds_left = 60 - relative_to.second
    60 * minutes_left + seconds_left
  end

  @doc """
  Calculate how many minutes left
  until next hour starts.

  If `relative_to` `DateTime` is not provided
  then current moment in time is used.

  Returns: `integer` number of seconds.

  ## Example

      iex> {:ok, now, _} = DateTime.from_iso8601("2018-10-14T16:48:12.000Z")
      iex> Every.hour(now)
      768
  """
  def hours(interval, relative_to) when is_nil(relative_to) do
    hours(interval, Timex.now())
  end

  @doc """
  Calculate how many minutes left
  until next hour starts.

  If `relative_to` `DateTime` is not provided
  then current moment in time is used.

  Returns: `integer` number of seconds.

  ## Example

      iex> {:ok, now, _} = DateTime.from_iso8601("2018-10-14T16:48:12.000Z")
      iex> Every.hour(now)
      768
  """
  def hours(interval, relative_to) do
    next_due = get_next_interval(relative_to.hour, interval) - relative_to.hour
    minutes_left = 60 - relative_to.minute
    seconds_left = 60 - relative_to.second
    3600 * (next_due - 1) + 60 * minutes_left + seconds_left
  end

  @doc """
  Calculate interval until next day.

  If `relative_to` `DateTime` is not provided
  then current moment in time is used.

  Returns: `integer` number of seconds.

  ## Example

      iex> {:ok, now, _} = DateTime.from_iso8601("2018-10-14T16:48:12.000Z")
      iex> Every.day(now)  # Time remaining 7h 25m 48s
      25908
  """
  def day(relative_to \\ Timex.now()) do
    # First we need to nullify all values except day value
    midnight = %{
      relative_to |
      :hour => 0,
      :minute => 0,
      :second => 0,
      :microsecond => {0, 0}
    }

    # Then we need to shift by 1 day and get difference
    # between new day and given `relative_to` date with
    # `:second` resolution as a result.
    next_day = Timex.shift(midnight, days: 1)
    DateTime.diff(next_day, relative_to, :second)
  end

  defp get_diff(result, initial_time) do
    # Returns difference between two `DateTime` instances
    # with `:second` resolution.
    clamped = %{result | :second => 0, :microsecond => {0, 0}}
    DateTime.diff(clamped, initial_time, :second)
  end

  defp get_next_interval(value, round_value) do
    # Uses `rem` function to get remainder for value
    # then calculates next step value, for example
    # value=48, round_value=15
    # then the result will look like
    # 48 + 15 - (48%15) = 60
    value + round_value - rem(value, round_value)
  end
end
