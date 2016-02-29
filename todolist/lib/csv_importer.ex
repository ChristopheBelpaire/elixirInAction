defmodule TodoList.CsvImporter do
	def import(filename) do
		File.stream!(filename) 
		|> Stream.map(fn(line) -> 
			  [date, title] = String.split(line,  ",")
			  [year, month, day] = String.split(date,"/")
			  %{date: {String.to_integer(year), String.to_integer(month), String.to_integer(day)}, title: String.replace(title, "\n", "")}
			end) |> TodoList.new
	end
end