defmodule TodoListGenServerTest do
  use ExUnit.Case
  doctest TodoList

  test "create a new todo list server process" do
  	{:ok, pid} = GenServer.start_link(TodoListGenServer, nil)
  	assert is_pid(pid)
  end

  test "add and get entry to a todo list server" do
  	{:ok, pid} = GenServer.start_link(TodoListGenServer, nil)
  	GenServer.cast(pid, {:add_entry, %{date: {2013, 12, 19}, title: "Dentist"}})
  	assert GenServer.call(pid, {:entries, {2013, 12, 19}}) == [%{date: {2013, 12, 19}, id: 1, title: "Dentist"}]
  end

  test "delete entry to a todo list server" do
    {:ok, pid} = GenServer.start_link(TodoListGenServer, nil)
  	GenServer.cast(pid, {:add_entry, %{date: {2013, 12, 19}, title: "Dentist"}})
  	GenServer.cast(pid, {:delete_entry, 1})
  	assert GenServer.call(pid, {:entries, {2013, 12, 19}}) == []
  end

  test "update element in todolist server" do
    {:ok, pid} = GenServer.start_link(TodoListGenServer, nil)
  	GenServer.cast(pid, {:add_entry, %{date: {2013, 12, 19}, title: "Dentist"}})
  	GenServer.cast(pid, {:update_entry, 1, fn(entry) -> Map.put(entry, :title, "Meditation") end})
  	assert GenServer.call(pid, {:entries, {2013, 12, 19}}) == [%{date: {2013, 12, 19}, id: 1, title: "Meditation"}]
  end


end  