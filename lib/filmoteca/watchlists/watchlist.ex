defmodule Filmoteca.Watchlists.Watchlist do
  use FilmotecaWeb, :model
  alias Filmoteca.Users.User
  alias Filmoteca.Repo

  @primary_key false
  @derive {Jason.Encoder, only: [:id_wl, :user_id, :name, :autor, :public]}
  schema "watchlists" do
    field :id_wl, :integer, primary_key: true
    belongs_to :user, Filmoteca.Users.User, type: :integer, primary_key: true
    field :name, :string
    field :autor, :string
    field :public, :boolean, default: false
  end

  def changeset(watchlist, params) do
    IO.puts(params["user_id"])
    user = User
    |> Repo.get(params["user_id"])
    watchlist = Ecto.build_assoc(user, :watchlists, params)
    |> cast(params, [:id_wl, :name, :autor, :public])
  end

end
