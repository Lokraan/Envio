defmodule Envio.MixProject do
  use Mix.Project

  def project do
    [
      app: :envio,
      version: "0.1.0",
      elixir: "~> 1.7",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      mod: {Envio, []},
      extra_applications: [:logger, :inets]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:nostrum, git: "https://github.com/Kraigie/nostrum.git"},
      {:ex_image_info, "~> 0.2.4"},
      {:httpoison, "~> 1.4", override: true}
    ]
  end
end
