defmodule Todo.DatabaseWorkerTest do
  use ExUnit.Case
  doctest Todo.DatabaseWorker

  test "start database worker with process registry" do
    Todo.ProcessRegistry.start_link
  	{:ok, pid} = GenServer.start_link(Todo.DatabaseWorker, "./persist", name: {:via, Todo.ProcessRegistry, {:database_worker, 1}})
  	assert is_pid(pid)
  end
end  