defmodule ServerProcessTest do
  use ExUnit.Case
  doctest ServerProcess

  test "put and get element of key value store" do
  	pid = ServerProcess.start(KeyValueStore)
  	ServerProcess.call(pid, {:put, :some_key, :some_value})
  	assert ServerProcess.call(pid, {:get, :some_key}) == :some_value
  end

  test "put with cast and get element of key value store" do
  	pid = ServerProcess.start(KeyValueStore)
  	ServerProcess.cast(pid, {:put, :some_key, :some_value})
  	assert ServerProcess.call(pid, {:get, :some_key}) == :some_value
  end

end
