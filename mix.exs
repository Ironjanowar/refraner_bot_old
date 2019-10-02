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
      {:ex_gram, "~> 0.8"},
      {:sqlite_ecto2, "~> 2.4"},
      {:tesla, "~> 1.2"},
      {:gun, "~> 1.3"},
      {:jason, "~> 1.1"},
      {:logger_file_backend, "0.0.11"}
    ]
  end
end
