defmodule Todo.Cache do
	use GenServer

	def init(_) do
		{:ok, HashDict.new}
	end
end	