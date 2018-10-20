defmodule Every.MixProject do
  use Mix.Project

  def project do
    [
      app: :every,
      version: "0.0.4",
      elixir: "~> 1.7",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      description: description(),
      package: package(),
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: [
        coveralls: :test,
        "coveralls.detail": :test,
        "coveralls.post": :test,
        "coveralls.html": :test
      ]
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
      {:timex, "~> 3.4"},
      {:ex_doc, "~> 0.19", only: :dev, runtime: false},
      {:excoveralls, "~> 0.10", only: :test},
      {:credo, "~> 0.10.0", only: [:dev, :test], runtime: false}
    ]
  end

  defp package do
    [
      name: "every",
      files: ~w(lib .formatter.exs mix.exs README* LICENSE*),
      licenses: ["Apache 2.0"],
      links: %{"GitHub" => "https://github.com/imanhodjaev/every"}
    ]
  end
end
