defmodule Evp.MixProject do
  use Mix.Project

  def project do
    [
      app: :evp,
      version: "0.1.0",
      elixir: "~> 1.7",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      name: "EVP",
      description: "Elixir implementation of OpenSSL EVP_BytesToKey",
      package: package(),
      source_url: "https://github.com/fredrikl/evp"
    ]
  end

  def application do
    []
  end

  defp deps do
    []
  end

  defp package() do
    [
      # These are the default files included in the package
      files: ~w(lib priv .formatter.exs mix.exs README* readme* LICENSE*
                license* CHANGELOG* changelog* src),
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/elixir-ecto/postgrex"}
    ]
  end
end