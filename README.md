# Every

[![Build Status](https://travis-ci.com/imanhodjaev/every.svg?branch=master)](https://travis-ci.com/imanhodjaev/every)
[![Coverage Status](https://coveralls.io/repos/github/imanhodjaev/every/badge.svg?branch=master&v=1)](https://coveralls.io/github/imanhodjaev/every?branch=master)

Calculate even intervals for. Sometimes we need to have
periodic tasks to be executed exactly at certain time points, for example running
a task every 15 minutes.

1. At the beginning of hour,
2. 15th minute,
3. 30th minute,
4. 45th minute.

So instead of doing it manually, it is better if it is automated.

## Usage

Available functions:

* `Every.minute/1`
* `Every.minutes/2`
* `Every.hour/1`
* `Every.hours/2`
* `Every.day/1`

All functions accept an optional `relative_to` (`DateTime` or `NaiveDateTime`)
parameter which can be used to fake the current moment in time. If it is not
provided, the current time will be used.

`Every.minute/1`, `Every.hour/1` and `Every.day/1` only accept the optional
`relative_to` parameter. They return the milliseconds left until the next
minute/hour/day.

`Every.minutes/2` and `Every.hours/2` both accept an interval as first parameter
and the optional `relative_to` as second parameter. They return the milliseconds
until the the next interval.

**Note:** All functions return the difference in milliseconds!

### How to use with periodic tasks

```elixir
# Lets say we want to trigger our task every 5 minutes and current time is 12:02
# so next calls will be at 12:05, 12:10 ... 12:55 ...
Process.send_after(self(), :work, Every.minutes(5))

# If we want to trigger every minute
Process.send_after(self(), :work, Every.minute())

# If we want to trigger every hour
Process.send_after(self(), :work, Every.hour())

# If we want to trigger every 2 hours
Process.send_after(self(), :work, Every.hours(2))

# If we want to trigger every day
Process.send_after(self(), :work, Every.day())
```

## Installation

This library can be installed by adding `every` to the list of dependencies in
your `mix.exs`:

```elixir
def deps do
  [{:every, "~> 0.0.9"}]
end
```

https://hex.pm/packages/every

Have fun!

---------------------------------------------------------------------

<p align="center">
  ✨ 🍰 ✨&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</p>
