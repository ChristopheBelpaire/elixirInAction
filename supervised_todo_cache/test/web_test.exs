defmodule Todo.WebTest do
  use ExUnit.Case
  doctest Todo.Web

  setup do
    File.rm("./persist/luke")
    File.rm("./persist/john")
    :ok
  end

  test "add entry list from web server" do
    HTTPoison.start

  	%{body: body} = (HTTPoison.post! 'localhost:5454/add_entry?list=luke&date=20160101&title=dentist','')
  	assert body == "OK"
  	my_todo_pid = Todo.Cache.server_process("luke")
  	assert Todo.Server.entries(my_todo_pid, {2016, 1, 1}) == [%{date: {2016, 1, 1}, id: 1, title: "dentist"}]
  end

  test "get entry from web server" do
    HTTPoison.start

    john_list  = Todo.Cache.server_process("john")
    Todo.Server.add_entry(john_list,  %{date: {2013, 12, 19}, title: "Dentist"})
    %{body: entries} = (HTTPoison.get! 'localhost:5454/entries?list=john&date=20131219')
    assert  entries == "2013-12-19    Dentist"
  end	
end  