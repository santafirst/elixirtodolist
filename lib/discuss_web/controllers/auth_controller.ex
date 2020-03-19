defmodule DiscussWeb.AuthController do
  use DiscussWeb, :controller
  plug Ueberauth

  alias DiscussWeb.User
  alias Discuss.Repo


  def callback(%{assigns: %{ueberauth_auth: auth}} = conn, _params) do
    user_params = %{token: auth.credentials.token, email: auth.info.email, provider: "github"}
    changeset = User.changeset(%User{}, user_params)

    signin(conn, changeset)
  end

  defp signin(conn, changeset) do

    case insert_or_update(changeset) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "Bentornato!")
        |> put_session(:user_id, user.id)
        |> redirect(to: Routes.topic_path(conn, :index))
      {:error, _reason} ->
        conn
        |> put_flash(:error, "UTENTE NON TROVATO")
        |> redirect(to: Routes.topic_path(conn, :new))
    end

  end

  def signout(conn, _params) do
    conn
    |> clear_session
    |> put_flash(:info, "Logout effettuato")
    |> redirect(to: Routes.topic_path(conn, :index))
  end

  defp insert_or_update(changeset) do
    case Repo.get_by(User, email: changeset.changes.email) do
      nil -> Repo.insert(changeset)
      user -> {:ok, user}
    end
  end
end