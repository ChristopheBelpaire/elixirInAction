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
end
