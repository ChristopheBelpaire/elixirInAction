defmodule Todo.ProcessRegistry do
	use GenServer
	import Kernel, except: [send: 2]

  def start_link do
    IO.puts "Starting process registry"
    GenServer.start_link(__MODULE__, nil, name: :process_registry)
  end

  def register_name(key, pid) do
    GenServer.call(:process_registry, {:register_name, key, pid})
  end

  def whereis_name(key) do
    case :ets.lookup(:process_registry, key) do
      [{^key, pid}] -> pid;
      _ -> :undefined
    end
  end

  def unregister_name(key) do
    GenServer.call(:process_registry, {:unregister_name, key})
  end

	def init(_) do
	  :ets.new(:process_registry, [:named_table, :protected, :set])
		{:ok, %{}}
	end

	def handle_call({:register_name, key, pid}, _, state) do
    if whereis_name(key) != :undefined do
      # Some other process has registered under this alias
      {:reply, :no, state}
    else
      Process.monitor(pid)
      :ets.insert(:process_registry, {key, pid})
      {:reply, :yes, state}
    end	
	end


	def handle_call({:unregister_name, key}, _, process_registry) do
    :ets.delete(:process_registry, key)
    {:reply, key, process_registry}
  end

	def handle_info({:DOWN, _, :process, pid, _}, process_registry) do
		:ets.match_delete(:process_registry, {:_, pid})
		{:noreply, process_registry}
	end

	def send(key, message) do
		case whereis_name(key) do
			:undefined -> {:badarg, {key, message}}
			pid -> 
				Kernel.send(pid, message)
				pid
		end		
	end


end