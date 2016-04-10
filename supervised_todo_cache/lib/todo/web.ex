defmodule Todo.Web do
	use Plug.Router

	plug :match
	plug :dispatch 

	def start_server do
		Plug.Adapters.Cowboy.http(__MODULE__, nil, port: 5454)
	end

	post "/add_entry" do
    conn 
    |> Plug.Conn.fetch_query_params
    |> add_entry
    |> respond
	end

	get "/entries" do
		conn
		|> Plug.Conn.fetch_query_params
		|> entries
		|> respond
	end	



  defp entries(conn) do
  	entries = conn.params["list"]
  	|> Todo.Cache.server_process
  	|> Todo.Server.entries(parse_date(conn.params["date"]))
  	|> format_entries
		Plug.Conn.assign(conn, :response, entries)
  end		


  defp format_entries(entries) do
    for entry <- entries do
      {y,m,d} = entry.date
      "#{y}-#{m}-#{d}    #{entry.title}"
    end
    |> Enum.join("\n")
  end

	defp add_entry(conn) do
		conn.params["list"]
		|> Todo.Cache.server_process 
		|> Todo.Server.add_entry(%{date: parse_date(conn.params["date"]), title: conn.params["title"]})
		Plug.Conn.assign(conn, :response, "OK")
	end

	defp respond(conn) do
		conn
		|> Plug.Conn.put_resp_content_type("text/plaiın")
		|> Plug.Conn.send_resp(200, conn.assigns[:response])
	end

  defp parse_date(
    # Using pattern matching to extract parts from YYYYMMDD string
    << year::binary-size(4), month::binary-size(2), day::binary-size(2) >>
  ) do
    {String.to_integer(year), String.to_integer(month), String.to_integer(day)}
  end

end