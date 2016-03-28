defmodule Todo.CacheTest do
  use ExUnit.Case
  doctest Todo.Cache

  setup do
    File.rm("./persist/My todo list")
    File.rm("./persist/other todo list")
    :ok
  end

  test "create a todo supervisor" do
    {:ok, pid} = Todo.Supervisor.start_link
    assert is_pid(pid)
  end

  test "add and get an entry to todo list" do
    Todo.Supervisor.start_link
    my_todo_pid = Todo.Cache.server_process("My todo list")
    Todo.Server.add_entry(my_todo_pid, %{date: {2013, 12, 19}, title: "Dentist"})

    assert Todo.Server.entries(my_todo_pid, {2013, 12, 19}) == [%{date: {2013, 12, 19}, id: 1, title: "Dentist"}]




  end

end
