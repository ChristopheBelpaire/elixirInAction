defmodule TodoListServer do

	def init do
		TodoList.new
	end

	def handle_cast({:add_entry, entry}, todo_list) do
		TodoList.add_entry(todo_list, entry)
	end
	
	def handle_call({:entries, date}, todo_list) do
		{TodoList.entries(todo_list, date), todo_list}
	end	

	def handle_cast({:delete_entry, entry}, todo_list) do
		TodoList.delete_entry(todo_list, entry)
	end

	def handle_cast({:update_entry, entry_id, updater_fun}, todo_list) do
		TodoList.update_entry(todo_list, entry_id, updater_fun)
	end

end