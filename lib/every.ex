defmodule Every do
  @moduledoc """
  Every gives you ability to use `Process.send_after/3` with calculated
  intervals which can be rounded to every:

    1. Minute,
    2. N minutes,
    3. Hour,
    4. N Hours.

  Every function accepts an optional `relative_to` parameter, which can be used
  to fake the current moment in time. If it is not provided, the current time
  will be used.

  **Note:** All functions return the difference in seconds!
  """

  @doc """
  Calculates how many seconds left until the next minute starts.

  ## Examples

      iex> {:ok, now, _} = DateTime.from_iso8601("2018-10-14T16:48:12.000Z")
      iex> Every.minute(now)
      48
  """
  def minute(relative_to \\ Timex.now()) do
    60 - relative_to.second
  end

  @doc """
  Calculates how many seconds left until the next interval (minutes) will be
  reached.

  ## Examples

      iex> {:ok, now, _} = DateTime.from_iso8601("2018-10-14T16:48:12.000Z")
      iex> Every.minutes(5, now)  # 16:50 > 15:50:00 - 16:48:12
      108
  """
  def minutes(interval, relative_to \\ Timex.now())

  def minutes(interval, nil), do: minutes(interval)

  def minutes(interval, relative_to) do
    minutes_until_next_interval = next_interval(relative_to.minute, interval)

    {microseconds, _precision} = relative_to.microsecond

    relative_to
    |> Timex.shift(seconds: -relative_to.second)
    |> Timex.shift(microseconds: -microseconds)
    |> Timex.shift(minutes: minutes_until_next_interval)
    |> Timex.diff(relative_to, :seconds)
  end

  @doc """
  Calculates how many seconds left until the next hour starts.

  ## Examples

      iex> {:ok, now, _} = DateTime.from_iso8601("2018-10-14T16:48:12.000Z")
      iex> Every.hour(now)
      708
  """
  def hour(relative_to \\ Timex.now()) do
    {microseconds, _precision} = relative_to.microsecond

    relative_to
    |> Timex.shift(seconds: -relative_to.second)
    |> Timex.shift(microseconds: -microseconds)
    |> Timex.shift(minutes: -relative_to.minute)
    |> Timex.shift(hours: 1)
    |> Timex.diff(relative_to, :seconds)
  end

  @doc """
  Calculates how many seconds left until the next interval (hours) will be
  reached.

  ## Examples

      iex> {:ok, now, _} = DateTime.from_iso8601("2018-10-14T16:48:12.000Z")
      iex> Every.hours(2, now)
      4308
  """
  def hours(interval, relative_to \\ Timex.now())

  def hours(interval, nil), do: hours(interval)

  def hours(interval, relative_to) do
    hours_until_next_interval = next_interval(relative_to.hour, interval)

    {microseconds, _precision} = relative_to.microsecond

    relative_to
    |> Timex.shift(seconds: -relative_to.second)
    |> Timex.shift(microseconds: -microseconds)
    |> Timex.shift(minutes: -relative_to.minute)
    |> Timex.shift(hours: hours_until_next_interval)
    |> Timex.diff(relative_to, :seconds)
  end

  @doc """
  Calculates how many seconds left until the next day starts.

  ## Examples

      iex> {:ok, now, _} = DateTime.from_iso8601("2018-10-14T16:48:12.000Z")
      iex> Every.day(now)  # Time remaining 7h 25m 48s
      25908
  """
  def day(relative_to \\ Timex.now()) do
    relative_to
    |> Timex.shift(days: 1)
    |> Timex.beginning_of_day()
    |> Timex.diff(relative_to, :seconds)
  end

  defp next_interval(value, round_value) do
    # Uses `rem` function to get remainder for value
    # then calculates next step value, for example
    # value=48, round_value=15
    # then the result will look like
    # 48 + 15 - (48%15) = 60
    round_value - rem(value, round_value)
  end
end
