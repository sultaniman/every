# Every

[![Build Status](https://travis-ci.com/imanhodjaev/every.svg?branch=master)](https://travis-ci.com/imanhodjaev/every)

Calculate even intervals for `Process.send_after/3`.
Sometimes we need to have periodic tasks to execute exactly at
certain intervals, for example run task every 15 minutes within hour
so we want to execute our task

1. At the beginning of hour,
2. 15th minute,
3. 30th minute,
4. 45th minute.

So instead of doing it manually it is better if it automated.


## Usage

Available methods

```ex
Every.minute/1
Every.minutes/2
Every.hour/1
Every.hours/2
```

`Every.minute/1` anf `Every.hour/1` accepts optional parameter `relative_to` if provided
then makes all calculation relative to given `DateTime` struct.

`Every.minutes/2` anf `Every.hour/2` both accept time interval as a first argument and
optional parameter `relative_to` if provided then makes all calculation relative to
given `DateTime` struct. First argument is literally to be read as `Every N minutes/hours`.

All methods return duration in seconds so it is your task to turn secons into milleseconds etc.


### How to use with periodic tasks

```ex
# Lets say we want to trigger our task every 5 minutes and current time is 12:02
# so next call will be at 12:05, 12:10 ... 12:55 ...
Process.send_after(self(), :work, Every.minutes(5) * 1000)

# If we want to trigger every minute
Process.send_after(self(), :work, Every.minute() * 1000)

# If we want to trigger every hour
Process.send_after(self(), :work, Every.hour() * 1000)
```


## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `every` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:every, "~> 0.0.2"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/every](https://hexdocs.pm/every).
