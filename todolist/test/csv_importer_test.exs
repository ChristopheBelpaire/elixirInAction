defmodule TodoList.CsvImporterTest do
  use ExUnit.Case
  doctest TodoList.CsvImporter

  test "create new todo list" do
    assert TodoList.CsvImporter.import("./test/todo.csv") == %TodoList{auto_id: 4,
    entries: HashDict.new 
 			|> HashDict.put(2, %{date: {2013, 12, 20}, id: 2, title: "Shopping"})
  		|> HashDict.put(3, %{date: {2013, 12, 19}, id: 3, title: "Movies"})
      |> HashDict.put(1, %{date: {2013, 12, 19}, id: 1, title: "Dentist"})
    }  
  end

end