defmodule Todo.CacheTest do
  use ExUnit.Case
  doctest Todo.Cache

  setup do
    File.rm("./persist/My todo list")
    File.rm("./persist/other todo list")
    :ok
  end



  test "add and get an entry to todo list" do
    my_todo_pid = Todo.Cache.server_process("My todo list")
    Todo.Server.add_entry(my_todo_pid, %{date: {2013, 12, 19}, title: "Dentist"})

    assert Todo.Server.entries(my_todo_pid, {2013, 12, 19}) == [%{date: {2013, 12, 19}, id: 1, title: "Dentist"}]

  end

  test "create todo list and try to access is twice should return the same pid" do
    my_todo_pid = Todo.Cache.server_process("My todo list")
    my_todo_pid_2 = Todo.Cache.server_process("My todo list")
    assert my_todo_pid == my_todo_pid_2
  end

end
