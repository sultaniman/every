defmodule Every.MixProject do
  use Mix.Project

  def project do
    [
      app: :every,
      version: "0.0.1",
      elixir: "~> 1.7",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      description: description(),
      package: package()
    ]
  end

  def description do
    "Calculate even intervals for `Process.send_after/3`"
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger, :timex]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:timex, "~> 3.4"}
    ]
  end

  defp package do
    [
      # This option is only needed when you don't want to use the OTP application name
      name: "every",
      # These are the default files included in the package
      files: ~w(lib .formatter.exs mix.exs README* LICENSE* src),
      licenses: ["Apache 2.0"],
      links: %{"GitHub" => "https://github.com/imanhodjaev/every"}
    ]
  end
end
