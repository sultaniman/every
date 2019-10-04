defmodule Every do
  @moduledoc """
  Every gives you ability to use `Process.send_after/3` with
  intervals which can be rounded to every:

    1. Minute,
    2. N minutes,
    3. Hour,
    4. N Hours,
    5. Day.

  Every function accepts an optional `relative_to` parameter, which can be used
  to fake the current moment in time. If it is not provided, the current time
  will be used.

  **Note:** All functions return the difference in milliseconds!
  """

  @doc """
  Calculates how many milliseconds left until the next minute starts.

  ## Examples

      iex> now = Timex.parse!("2018-10-14T16:48:12.000Z", "{ISO:Extended}")
      iex> Every.minute(now)
      48_000
  """
  def minute(relative_to \\ Timex.now()) do
    (60 - relative_to.second) * 1000
  end

  @doc """
  Calculates how many milliseconds left until the next interval (minutes) will be
  reached.

  ## Examples

      iex> now = Timex.parse!("2018-10-14T16:48:12.000Z", "{ISO:Extended}")
      iex> Every.minutes(5, now)  # 16:50 > 15:50:00 - 16:48:12
      108_000
  """
  def minutes(interval, relative_to \\ Timex.now())

  def minutes(interval, relative_to) do
    minutes_until_next_interval = next_interval(relative_to.minute, interval)

    {microseconds, _precision} = relative_to.microsecond

    relative_to
    |> Timex.shift(seconds: -relative_to.second)
    |> Timex.shift(microseconds: -microseconds)
    |> Timex.shift(minutes: minutes_until_next_interval)
    |> Timex.diff(relative_to, :milliseconds)
  end

  @doc """
  Calculates how many seconds left until the next hour starts.

  ## Examples

      iex> now = Timex.parse!("2018-10-14T16:48:12.000Z", "{ISO:Extended}")
      iex> Every.hour(now)
      708_000
  """
  def hour(relative_to \\ Timex.now())

  def hour(relative_to) do
    {microseconds, _precision} = relative_to.microsecond

    relative_to
    |> Timex.shift(seconds: -relative_to.second)
    |> Timex.shift(microseconds: -microseconds)
    |> Timex.shift(minutes: -relative_to.minute)
    |> Timex.shift(hours: 1)
    |> Timex.diff(relative_to, :milliseconds)
  end

  @doc """
  Calculates how many milliseconds left until the next interval (hours) will be
  reached.

  ## Examples

      iex> now = Timex.parse!("2018-10-14T16:48:12.000Z", "{ISO:Extended}")
      iex> Every.hours(2, now)
      4_308_000
  """
  def hours(interval, relative_to \\ Timex.now())

  def hours(interval, relative_to) do
    hours_until_next_interval = next_interval(relative_to.hour, interval)

    {microseconds, _precision} = relative_to.microsecond

    relative_to
    |> Timex.shift(seconds: -relative_to.second)
    |> Timex.shift(microseconds: -microseconds)
    |> Timex.shift(minutes: -relative_to.minute)
    |> Timex.shift(hours: hours_until_next_interval)
    |> Timex.diff(relative_to, :milliseconds)
  end

  @doc """
  Calculates how many milliseconds left until the next day starts.

  ## Examples

      iex> now = Timex.parse!("2018-10-14T16:48:12.000Z", "{ISO:Extended}")
      iex> Every.day(now)  # Time remaining 7h 25m 48s
      25_908_000
  """
  def day(relative_to \\ Timex.now())
  
  def day(relative_to) do
    relative_to
    |> Timex.shift(days: 1)
    |> Timex.beginning_of_day()
    |> Timex.diff(relative_to, :milliseconds)
  end

  defp next_interval(value, round_value) do
    # Uses `rem` function to get remainder for value
    # then calculates next step value, for example
    # value=48, round_value=15
    # then the result will look like
    # 15 - (48%15) = 12
    round_value - rem(value, round_value)
  end
end
