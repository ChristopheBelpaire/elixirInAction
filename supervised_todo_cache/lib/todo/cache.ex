defmodule Todo.Cache do
	use GenServer

	def init(_) do
		IO.puts "Starting todo cache"
		{:ok, HashDict.new}
	end

	def handle_call({:server_process, todo_list_name}, _, todo_servers) do
		case HashDict.fetch(todo_servers, todo_list_name) do
			{:ok, todo_server} ->
				{:reply, todo_server, todo_servers}
			:error ->
				{:ok, new_server} = Todo.Server.start_link(todo_list_name)
				{:reply, 
				 new_server,
				 HashDict.put(todo_servers, todo_list_name, new_server)
				}	
		end
	end

	def server_process(todo_list_name) do
		GenServer.call(:todo_cache, {:server_process, todo_list_name})
	end
	
	def start_link do
		GenServer.start_link(__MODULE__, nil, name: :todo_cache)
	end

	def server_process(cache_pid, todo_list_name) do
		GenServer.call(cache_pid, {:server_process, todo_list_name})
	end
end