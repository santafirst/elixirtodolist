defmodule DiscussWeb.Plugs.AuthRequested do
  import Plug.Conn
  import Phoenix.Controller

  alias Discuss.Repo
  alias DiscussWeb.User
  alias DiscussWeb.Router.Helpers

  def init(_params) do

  end

  def call(conn, _params) do
    if conn.assigns[:user] do
      conn
    else
      conn
      |> put_flash(:error, "Devi essere loggato!")
      |> redirect(to: Helpers.topic_path(conn, :index))
      |> halt

    end
  end
end