defmodule TodoCacheTest do
  use ExUnit.Case
  doctest TodoCache

  test "create new todo cache" do
    {:ok, cache_pid} = TodoCache.start
    assert is_pid(cache_pid) == true
  end

  test "create a new list from cache" do
    {:ok, cache_pid} = TodoCache.start
    assert is_pid(TodoCache.server_process(cache_pid, "Christophe's list"))
  end

  test "create and get new list should return same list" do
    {:ok, cache_pid} = TodoCache.start
    my_list = TodoCache.server_process(cache_pid, "Christophe's list")
    assert my_list = TodoCache.server_process(cache_pid, "Christophe's list")
  end
end  