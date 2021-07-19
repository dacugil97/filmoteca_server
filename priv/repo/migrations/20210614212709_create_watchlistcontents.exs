defmodule Filmoteca.Repo.Migrations.CreateWatchlistContents do
  use Ecto.Migration

  def change do
    create table(:watchlistcontents, primary_key: false) do
      add :id_user, :integer, primary_key: true
      add :id_wl, :integer, primary_key: true
      add :id_mv, :integer, primary_key: true
    end

  end
end
