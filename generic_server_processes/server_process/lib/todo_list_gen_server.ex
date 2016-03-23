defmodule TodoListGenServer do
	use GenServer

	def init(args) do
		{:ok, TodoList.new}
	end

	def handle_cast({:add_entry, entry}, todo_list) do
		{:noreply, TodoList.add_entry(todo_list, entry)}
	end
	
	def handle_call({:entries, date}, _from ,todo_list) do
		{:reply, TodoList.entries(todo_list, date), todo_list}
	end	

	def handle_cast({:delete_entry, entry}, todo_list) do
		{:noreply, TodoList.delete_entry(todo_list, entry)}
	end

	def handle_cast({:update_entry, entry_id, updater_fun}, todo_list) do
		{:noreply, TodoList.update_entry(todo_list, entry_id, updater_fun)}
	end

	def start do
		GenServer.start(TodoListGenServer, nil)
	end
end