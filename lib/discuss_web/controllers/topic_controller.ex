defmodule DiscussWeb.TopicController do
  use DiscussWeb, :controller
  alias Discuss.Repo
  alias DiscussWeb.Topic

  plug DiscussWeb.Plugs.AuthRequested when action in [:new, :create, :edit, :update, :delete]
  plug :check_topic_owner when action in [:new, :create, :edit, :update, :delete]

  def index(conn, _params) do
    IO.puts("    ==========    ")
    IO.inspect(conn)
    topics = Repo.all(Topic)

    render conn, "index.html", topics: topics
  end

  def new(conn, _params) do
    changeset = Topic.changeset(%Topic{}, %{})

    render conn, "new.html", changeset: changeset
  end

  def show(conn, %{"id" => topic_id}) do
    topic = Repo.get(Topic, topic_id)
    render conn, "show.html", topic: topic
  end

  def create(conn, %{"topic" => topic}) do
    changeset = conn.assigns[:user]
      |> Ecto.build_assoc(:topics)
      |> Topic.changeset(topic)

    case Repo.insert(changeset) do
      {:ok, post} ->
        conn
        |> put_flash(:info, "Topic creato")
        |> redirect(to: Routes.topic_path(conn, :index))
      {:error, post} ->
        conn
        |> put_flash(:error, "Topic errato")
        |> redirect(to: Routes.topic_path(conn, :new))
    end
  end

  def edit(conn, %{"id" => topic_id}) do
    topic = Repo.get(Topic, topic_id)
    changeset = Topic.changeset(topic)

    render conn, "edit.html", topic: topic, changeset: changeset
  end

  def update(conn, %{"id" => topic_id, "topic" => topic}) do
    old_topic = Repo.get(Topic, topic_id)
    changeset = Topic.changeset(old_topic, topic)


    case Repo.update(changeset) do
      {:ok, post} ->
        conn
        |> put_flash(:info, "Topic modificato")
        |> redirect(to: Routes.topic_path(conn, :index))
      {:error, post} ->
        conn
        |> put_flash(:error, "Topic errato")
        |> redirect(to: Routes.topic_path(conn, :new))
    end

  end

  def delete(conn, %{"id" => topic_id}) do
    Repo.get!(Topic, topic_id)
    |> Repo.delete!

    conn
    |> put_flash(:info, " Topic cancellato")
    |> redirect(to: Routes.topic_path(conn, :index))
  end

  defp check_topic_owner(conn, _params) do
    %{params: %{"id" => topic_id}} = conn

    if Repo.get(Topic, topic_id).user_id == conn.assigns.user_id do
      conn
    else
      conn
      |> put_flash(:info, "Operazione non consentita")
      |> redirect(to: Routes.topic_path(conn, :index))
      |> halt()

    end
  end
end
