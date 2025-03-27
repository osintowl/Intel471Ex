defmodule Intel471Ex.MixProject do
  use Mix.Project

  def project do
    [
      app: :intel471_ex,
      version: "0.1.0",
      elixir: "~> 1.15",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      description: description(),
      package: package(),
      docs: [
        main: "Intel471Ex",
        extras: ["README.md"]
      ]
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:req, "~> 0.5.8"},
      {:ex_doc, ">= 0.0.0", only: :dev, runtime: false},
      {:rename, "~> 0.1.0", only: :dev}
    ]
  end
  
  defp description do
    """
    An Elixir client for Intel 471's Titan API for cyber threat intelligence.
    """
  end
  
  defp package do
    [
      licenses: ["BSD-3-Clause"],
      links: %{
         "GitHub" => "https://github.com/osintowl/Intel471Ex"
      }
    ]
  end
end
