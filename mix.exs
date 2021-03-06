defmodule Homunculus.Mixfile do
  use Mix.Project

  def project do
    [app: :homunculus,
     version: "0.0.2",
     elixir: "~> 0.15.0",
     escript: [ main_module: Homunculus.CLI, embed_elixir: true ],
     deps: deps]
  end

  # Configuration for the OTP application
  #
  # Type `mix help compile.app` for more information
  def application do
    [applications: [:mix],
     mod: {Homunculus, []}]
  end

  # Dependencies can be hex.pm packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1"}
  #
  # Type `mix help deps` for more examples and options
  defp deps do
    []
  end
end
