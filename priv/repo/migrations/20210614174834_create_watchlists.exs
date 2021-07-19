defmodule Filmoteca.Repo.Migrations.CreateWatchlists do
  use Ecto.Migration

  def change do
    create table(:watchlists, primary_key: false) do
      add :user_id, references(:users, type: :integer), primary_key: true
      add :id_wl, :integer, primary_key: true
      add :name, :string
      add :autor, :string
      add :public, :boolean
    end

    create index(:watchlists, [:user_id])

  end
end
