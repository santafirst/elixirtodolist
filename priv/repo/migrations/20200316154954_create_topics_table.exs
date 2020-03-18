defmodule Discuss.Repo.Migrations.CreateTopicsTable do
  use Ecto.Migration

  def up do
    create table("topics") do
      add :title, :string
    end
  end
end
