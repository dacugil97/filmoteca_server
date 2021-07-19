defmodule Filmoteca.Watchlists.Watchlistcontent do
  use FilmotecaWeb, :model

  @primary_key false
  @derive {Jason.Encoder, only: [:id_user, :id_wl, :id_mv]}
  schema "watchlistcontents" do
    field :id_user, :integer, primary_key: true
    field :id_wl, :integer, primary_key: true
    field :id_mv, :integer, primary_key: true
  end

  def changeset(watchlistcontent, params) do
    watchlistcontent
    |> cast(params, [:id_user, :id_wl, :id_mv])
  end

end
