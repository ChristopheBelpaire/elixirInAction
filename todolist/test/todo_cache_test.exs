defmodule TodoCacheTest do
  use ExUnit.Case
  doctest TodoCache

  test "create new todo cache" do
    {:ok, cache_pid} = TodoCache.start
    assert is_pid(cache_pid) == true
  end

  test "create a new list from cache" do
    {:ok, cache_pid} = TodoCache.start
    IO.puts TodoCache.server_process(cache_pid, "Christophe's list")
  end
end  