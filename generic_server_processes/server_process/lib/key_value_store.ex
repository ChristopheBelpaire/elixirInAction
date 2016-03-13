defmodule KeyValueStore do
	def init do
		HashDict.new
	end

	def handle_call({:put, key, value}, state) do
		{:ok, HashDict.put(state, key, value)}
	end

	def handle_call({:get, key}, state) do
		{HashDict.get(state, key), state}
	end	
end