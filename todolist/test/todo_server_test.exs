defmodule TodoServerTest do
  use ExUnit.Case
  doctest TodoServer

  test "create new todo list process" do
    assert is_pid(TodoServer.start)
  end

  test "add a todo in todo list server" do
    todo_server = TodoServer.start
    TodoServer.add_entry(todo_server, %{date: {2013, 12, 19}, title: "Dentist"})
    assert TodoServer.entries(todo_server, {2013, 12, 19}) == [%{date: {2013, 12, 19}, id: 1, title: "Dentist"}]
  end  

  test "delete a todo in todo list server" do
    todo_server = TodoServer.start
    TodoServer.add_entry(todo_server, %{date: {2013, 12, 19}, title: "Dentist"})
    TodoServer.delete_entry(todo_server, 1)
    assert TodoServer.entries(todo_server, {2013, 12, 19}) == []
	end  

	
  test "update element in todolist server" do
  	todo_server = TodoServer.start
  	TodoServer.add_entry(todo_server, %{date: {2015, 1,1}, title: "Shopping"})
  	TodoServer.update_entry(todo_server, 1, fn(entry) -> Map.put(entry, :title, "Meditation") end)
  	assert TodoServer.entries(todo_server, {2015,1,1}) == [%{date: {2015, 1, 1}, id: 1, title: "Meditation"}]
  end

end  