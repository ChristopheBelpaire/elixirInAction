defmodule TodoListTest do
  use ExUnit.Case
  doctest TodoList

  test "create new todo list" do
    assert TodoList.new == %TodoList{}
  end

  test "add element to todolist" do
  	todo = TodoList.new |> TodoList.add_entry(%{date: {2015, 1,1}, title: "Shopping"})
  	assert todo == %TodoList{auto_id: 2, entries: HashDict.new |>  HashDict.put(1, %{date: {2015, 1, 1}, id: 1, title: "Shopping"})}
  end

  test "get content of todolist" do
		todo = TodoList.new |> TodoList.add_entry(%{date: {2015, 1,1}, title: "Shopping"})
  	assert TodoList.entries(todo, {2015,1,1}) == [%{date: {2015, 1, 1}, id: 1, title: "Shopping"}]
  end

  test "update element in todolist" do
  	todo = TodoList.new 
  	|> TodoList.add_entry(%{date: {2015, 1,1}, title: "Shopping"})
  	|> TodoList.update_entry(1, fn(entry) -> Map.put(entry, :title, "Meditation") end)
  	assert todo == %TodoList{auto_id: 2, entries: HashDict.new |>  HashDict.put(1, %{date: {2015, 1, 1}, id: 1, title: "Meditation"})}
  end

  test "test delete element in todolist" do
		todo = TodoList.new 
  	|> TodoList.add_entry(%{date: {2015, 1,1}, title: "Shopping"})
  	|> TodoList.delete_entry(1)
  	assert todo == %TodoList{auto_id: 2, entries: HashDict.new}
  end

  test "test to_string protocol implementation for todolist" do
    assert to_string(TodoList.new) == "#TodoList"
  end	

  test "test collectable protocol implementation for todolist" do
    entries = [
      %{date: {2013, 12, 19}, title: "Dentist"},
      %{date: {2013, 12, 20}, title: "Shopping"}
    ]
    todo_list = for entry <- entries, into: TodoList.new, do: entry
    assert todo_list ==  %TodoList{auto_id: 3, entries: HashDict.new |>  HashDict.put(2, %{date: {2013, 12, 20}, id: 2, title: "Shopping"}) |> HashDict.put(1, %{date: {2013, 12, 19}, id: 1, title: "Dentist"})}
  end
end
