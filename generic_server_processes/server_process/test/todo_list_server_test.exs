defmodule TodoListTest do
  use ExUnit.Case
  doctest TodoList

  test "create a new todo list server process" do
  	pid = ServerProcess.start(TodoListServer)
  	assert is_pid(pid)
  end

  test "add and get entry to a todo list server" do
  	pid = ServerProcess.start(TodoListServer)
  	ServerProcess.cast(pid, {:add_entry, %{date: {2013, 12, 19}, title: "Dentist"}})
  	assert ServerProcess.call(pid, {:entries, {2013, 12, 19}}) == [%{date: {2013, 12, 19}, id: 1, title: "Dentist"}]
  end

  test "delete entry to a todo list server" do
  	pid = ServerProcess.start(TodoListServer)
  	ServerProcess.cast(pid, {:add_entry, %{date: {2013, 12, 19}, title: "Dentist"}})
  	ServerProcess.cast(pid, {:delete_entry, 1})
  	assert ServerProcess.call(pid, {:entries, {2013, 12, 19}}) == []
  end

  test "update element in todolist server" do
    pid = ServerProcess.start(TodoListServer)
  	ServerProcess.cast(pid, {:add_entry, %{date: {2013, 12, 19}, title: "Dentist"}})
  	ServerProcess.cast(pid, {:update_entry, 1, fn(entry) -> Map.put(entry, :title, "Meditation") end})
  	assert ServerProcess.call(pid, {:entries, {2013, 12, 19}}) == [%{date: {2013, 12, 19}, id: 1, title: "Meditation"}]
  end

end  