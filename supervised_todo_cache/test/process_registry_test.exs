defmodule Todo.ProcessRegistryTest do
  use ExUnit.Case
  doctest Todo.ProcessRegistry
  test "register a process" do
  	Todo.ProcessRegistry.start_link
  	assert Todo.ProcessRegistry.register_name({:database_worker, 1}, self) == :yes
  	assert is_pid(Todo.ProcessRegistry.whereis_name({:database_worker, 1}))
  end

  test "send messager to registred process" do
  	Todo.ProcessRegistry.start_link
  	assert Todo.ProcessRegistry.register_name({:database_worker, 1}, self) == :yes
  	Todo.ProcessRegistry.send({:database_worker, 1}, "hello")
  	assert "hello" == (receive do msg -> msg end) 
  end

  test "unregister registred process" do
  	Todo.ProcessRegistry.start_link
  	assert Todo.ProcessRegistry.register_name({:database_worker, 1}, self) == :yes
  	Todo.ProcessRegistry.unregister_name({:database_worker, 1})
  	assert Todo.ProcessRegistry.whereis_name({:database_worker, 1}) == :undefined
  end
end  
