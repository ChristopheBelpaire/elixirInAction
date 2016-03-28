defmodule Todo.Database do
	use GenServer
  @pool_size 3

	def start_link(db_folder) do 
	  GenServer.start_link(__MODULE__, db_folder, name: :database_server)
	end	

	def store(key, data) do
		GenServer.cast(:database_server, {:store, key, data})
	end

	def get(key) do
		GenServer.call(:database_server, {:get, key})
	end

	defp get_worker(key, workers) do
		Map.get(workers, :erlang.phash2(key, @pool_size))
	end

	def init(db_folder) do
		File.mkdir_p(db_folder)
		workers = (0..(@pool_size-1)) 
			|> Enum.reduce(%{}, fn x, workers ->
    			{:ok, pid} = GenServer.start(Todo.DatabaseWorker, db_folder) 
    			IO.puts "Starting database server "
      		Map.put(workers, x, pid)
    		end)
		{:ok, {db_folder, workers}}
	end

	def handle_cast({:store, key, data}, {db_folder, workers}) do
	  worker_pid = get_worker(key, workers)
	  Todo.DatabaseWorker.store(worker_pid, key, data)
		{:noreply, {db_folder, workers}}
	end

	def handle_call({:get, key}, _, {db_folder, workers}) do
		worker_pid = get_worker(key, workers)
		GenServer.call(worker_pid, {:get, key})
		data = Todo.DatabaseWorker.get(worker_pid, key)
	  {:reply, data,  {db_folder, workers}}
	end

	defp file_name(db_folder, key), do: "#{db_folder}/#{key}"

end