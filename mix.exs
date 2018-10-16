defmodule Evp.MixProject do
  use Mix.Project

  @github_url "https://github.com/FredrikL/Evp"

  def project do
    [
      app: :evp,
      version: "0.1.1",
      elixir: "~> 1.7",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      name: "EVP",
      description: "Elixir implementation of OpenSSL EVP_BytesToKey",
      package: package(),
      source_url: @github_url
    ]
  end

  def application do
    []
  end

  defp deps do
    [{:ex_doc, ">= 0.0.0", only: :dev}]
  end

  defp package() do
    [
      # These are the default files included in the package
      files: ~w(lib .formatter.exs mix.exs README* LICENSE* CHANGELOG*),
      licenses: ["MIT"],
      links: %{"GitHub" => @github_url}
    ]
  end
end
