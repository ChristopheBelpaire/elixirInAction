defmodule Todo.CacheTest do
  use ExUnit.Case
  doctest Todo.Cache

  setup do
    File.rm("./persist/My todo list")
    File.rm("./persist/other todo list")
    :ok
  end

  test "create a todo cache" do
    {:ok, pid} = Todo.Cache.start
    assert is_pid(pid)
  end

  test "add and get an entry to todo list" do
    {:ok, cache_pid} = Todo.Cache.start
    my_todo_pid = Todo.Cache.server_process(cache_pid, "My todo list")
    GenServer.cast(my_todo_pid, {:add_entry, %{date: {2013, 12, 19}, title: "Dentist"}})
    assert GenServer.call(my_todo_pid, {:entries, {2013, 12, 19}}) == [%{date: {2013, 12, 19}, id: 1, title: "Dentist"}]

    other_todo_pid = Todo.Cache.server_process(cache_pid, "other todo list")
    GenServer.cast(other_todo_pid, {:add_entry, %{date: {2013, 12, 20}, title: "Yoga"}})
    assert GenServer.call(other_todo_pid, {:entries, {2013, 12, 20}}) == [%{date: {2013, 12, 20}, id: 1, title: "Yoga"}]
  end

end
