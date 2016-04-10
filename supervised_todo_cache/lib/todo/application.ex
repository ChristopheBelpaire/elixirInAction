defmodule Todo.Application do 
	use Application

	def start(_, _) do
		Todo.Supervisor.start_link
		Todo.Web.start_server
	end
end