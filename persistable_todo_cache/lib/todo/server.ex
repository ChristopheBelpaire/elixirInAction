defmodule Todo.Server do
	use GenServer

	def init(name) do
		{:ok, {name, Todo.Database.get(name) || Todo.List.new}}
	end

	def handle_call({:entries, date}, _from ,{name, todo_list}) do
		{:reply, Todo.List.entries(todo_list, date), {name, todo_list}}
	end	

	def handle_cast({:add_entry, entry}, {name, todo_list}) do
	  new_state = Todo.List.add_entry(todo_list, entry)
	  Todo.Database.store(name, new_state)
		{:noreply, {name, new_state}}
	end
	
	def handle_cast({:delete_entry, entry}, todo_list) do
		{:noreply, TodoList.delete_entry(todo_list, entry)}
	end

	def handle_cast({:update_entry, entry_id, updater_fun}, todo_list) do
		{:noreply, TodoList.update_entry(todo_list, entry_id, updater_fun)}
	end

	def start(name) do
		GenServer.start(__MODULE__, name)
	end

	def entries(pid, date) do
		GenServer.call(pid, {:entries, date})
	end

	def add_entry(pid, entry) do
		GenServer.cast(pid, {:add_entry, entry})
	end
end