defmodule Evp do
  @doc """
  Generates a key and iv based using MD5 using the password string as start.

  salt must be 8 bytes or nil
  """
  @key_len 256 / 8
  @iv_len 16

  @spec bytes_to_key(String.t(), binary()) ::
          {:ok, %{key: String.t(), iv: String.t()}} | {:error, String.t()}
  def bytes_to_key(password, salt) do
    if salt !== nil && byte_size(salt) !== 8 do
      {:error, "salt must be nil or 8 bytes long was #{byte_size(salt)}"}
    else
      pw =
        if salt !== nil do
          password <> salt
        else
          password
        end

      bytes_to_key(pw)
    end
  end

  @spec bytes_to_key(String.t()) ::
          {:ok, %{key: String.t(), iv: String.t()}} | {:error, String.t()}
  def bytes_to_key(password) do
    loop(password, @key_len, @iv_len)
  end

  defp loop(password, key_len, iv_len, key \\ <<>>, iv \\ <<>>, tmp \\ <<>>) do
    if(key_len > 0 || iv_len > 0) do
      tmp = :crypto.hash(:md5, tmp <> password)

      {key, key_len, used} =
        if(key_len > 0) do
          used = min(key_len, byte_size(tmp))
          part = binary_part(tmp, 0, Kernel.trunc(used))
          {key <> part, key_len - used, used}
        else
          {key, 0, 0}
        end

      {iv, iv_len} =
        if used < byte_size(tmp) do
          if(iv_len > 0) do
            used = min(iv_len, byte_size(tmp))
            part = binary_part(tmp, 0, Kernel.trunc(used))
            {iv <> part, iv_len - used}
          else
            {iv, 0}
          end
        else
          {iv, iv_len}
        end

      loop(password, key_len, iv_len, key, iv, tmp)
    else
      {:ok, %{key: key, iv: iv}}
    end
  end
end
