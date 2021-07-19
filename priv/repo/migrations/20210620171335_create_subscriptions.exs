defmodule Filmoteca.Repo.Migrations.CreateSubscriptions do
  use Ecto.Migration

  def change do
    create table(:subscriptions, primary_key: false) do
      add :id_user, :integer, primary_key: true
      add :id_creator, :integer, primary_key: true
      add :id_wl, :integer, primary_key: true
    end
  end
end
