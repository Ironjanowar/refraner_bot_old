defmodule RefranerBot.MixProject do
  use Mix.Project

  def project do
    [
      app: :refraner_bot,
      version: "0.1.0",
      elixir: "~> 1.6",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {RefranerBot, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:telex, git: "https://github.com/rockneurotiko/telex.git", tag: "0.4.0"}
    ]
  end
end
