defmodule Filmoteca.Repo.Migrations.CreateMovie do
  use Ecto.Migration

  def change do
    create table(:movies, primary_key: false) do
      add :id, :integer, primary_key: true
      add :title, :string
      add :year, :string
      add :overview, :text
      add :director, :string
      add :casting, :string
      add :poster, :string
      add :backdrop, :string
      add :runtime, :string
      add :rating, :string
      add :omdb, :boolean
    end

  end
end
