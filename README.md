# Evp

Partial implementation of OpenSSl [EVP_BytesToKey](https://www.openssl.org/docs/man1.0.2/crypto/EVP_BytesToKey.html)

## Usage

Call `Evp.bytes_to_key/1` with a password or `Evp.bytes_to_key/1` with password and salt (8 bytes in size) to get a key and iv.

`{:ok, %{key: key, iv: iv}} = Evp.bytes_to_key("my-secret-password")`

If an invalid salt is supplied `{:error, message}` is returned.


## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `evp` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:evp, "~> 0.1.0"}
  ]
end
```
