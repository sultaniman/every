# CHANGELOG

## Dev

* Resolution is milliseconds now so `Process.send_after/3` friendly, so you don't have to do manual work.


## Version 0.0.6


### Improvements

Thanks to @janpieper

* Drop use Timex to avoid unnecessary third party module aliasing,
* Clean up @moduledoc and @doc,
* Use Timex for calculations instead of doing it manually,
* Fix a bug with calculating the interval in hour/1 and hours/2,
* Parse datetime in setup and pass as context into tests to parse only once,
* Test hours/2 instead of hour/1 in doctest for hours/2 😉.

### Deprecations

* minutes(interval, nil) and hours(interval, nil) are deprecated and using them will log warnings.
