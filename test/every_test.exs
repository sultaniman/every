defmodule EveryTest do
  use ExUnit.Case
  doctest Every

  @date_string "2018-10-14T16:48:12.000Z"

  test "Every minute works as expected" do
    {:ok, datetime, _} = DateTime.from_iso8601(@date_string)
    assert Every.minute(datetime) == 48
  end

  test "Every N minutes works as expected" do
    {:ok, datetime, _} = DateTime.from_iso8601(@date_string)
    # Next time is expected to be at 16:50 because
    # 50 % 5 == 0 etc. for all examples.
    assert Every.minutes(5, datetime) == 108

    # Next time at 16:51
    assert Every.minutes(3, datetime) == 168

    # Every 10 minute will align to next to due
    # which divides without remainder thus it will
    # be 16:50 etc.
    assert Every.minutes(10, datetime) == 108

    # Next will be at 16:15
    assert Every.minutes(15, datetime) == 708
  end

  test "Every N minutes without relative time works as expected" do
    assert Every.minutes(2, nil) <= 120
  end

  test "Every hour works as expected" do
    {:ok, datetime, _} = DateTime.from_iso8601(@date_string)

    # Next time at 17:00
    assert Every.hour(datetime) == 768
  end

  test "Every N hours works as expected" do
    {:ok, datetime, _} = DateTime.from_iso8601(@date_string)

    # Next time at 18:00
    assert Every.hours(2, datetime) == 7968

    # Next time at 17:00
    assert Every.hours(1, datetime) == 4368

    # Next time at 22:00 because of remaining time
    # is about ~4.21 hours.
    assert Every.hours(10, datetime) == 15168
  end

  test "Every N hours without relative time works as expected" do
    assert Every.hours(2, nil) / 3600 > 0
    assert Every.hours(2, nil) / 3600 <= 2
  end
end
