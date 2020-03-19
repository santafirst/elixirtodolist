defmodule DiscussWeb.CommentsChannel do
  use DiscussWeb, :channel

  def join(name, _params, socket) do
    IO.puts("++++++++++++ SOCKET ++++++++++++")
    IO.inspect(name)
    %{:ok, %{}, socket}

  end

  def handle_in() do

  end

end