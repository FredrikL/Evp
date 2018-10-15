defmodule EvpTest do
  use ExUnit.Case, async: true

  test "generate key & iv" do
    key_ = "A2D9679C7FFF3E9CF4300A2CC3FBAD7959EDAEE8A43C1A9D7168EAC46808A57A"
    iv_ = "BF5E155A28943B1046312484609C5F3C"
    {:ok, %{key: key, iv: iv}} = Evp.bytes_to_key("my-secret-password")
    assert Base.encode16(key) == key_
    assert Base.encode16(iv) == iv_
  end

  test "generate another key & iv" do
    key = "5F4DCC3B5AA765D61D8327DEB882CF992B95990A9151374ABD8FF8C5A7A0FE08"
    iv = "B7B4372CDFBCB3D16A2631B59B509E94"
    {:ok, result} = Evp.bytes_to_key("password")
    assert Base.encode16(result.key) == key
    assert Base.encode16(result.iv) == iv
  end

  test "should return error is salt is wrong size" do
    {:error, msg} = Evp.bytes_to_key("foo", "1234567")
    assert msg =~ "salt must be nil or 8 bytes long"
  end

  test "Should work with salt included" do
    key = "BBB0DDFF1B944B3CC68EAAEB7AC20099E5155BAE6ED28F668B60CBC4157DE1BD"
    iv = "FA1DD9AB5D62D787256EB8AEC82DE442"
    {:ok, result} = Evp.bytes_to_key("password", "12345678")
    assert Base.encode16(result.key) == key
    assert Base.encode16(result.iv) == iv
  end
end
