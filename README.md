# Every

Generate at rounded intervals for `Process.send_after/3`.

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

```ex
Every.minute()  # Returns seconds remaining until next minute starts
Every.minutes(5, Timex.now())  # Returns minutes remaining until next interval starts
Every.hour()  # Returns minutes remaining until next hour starts
Every.hours(1, Timex.now())  # Returns minutes remaining until next hour starts
```

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `every` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:every, "~> 0.0.1"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/every](https://hexdocs.pm/every).

