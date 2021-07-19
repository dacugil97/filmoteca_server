defmodule Filmoteca.Watchlists.Subscription do
  use FilmotecaWeb, :model

  @primary_key false
  @derive {Jason.Encoder, only: [:id_user, :id_creator, :id_wl]}
  schema "subscriptions" do
    field :id_user, :integer, primary_key: true
    field :id_creator, :integer, primary_key: true
    field :id_wl, :integer, primary_key: true
  end

  def changeset(watchlistcontent, params) do
    watchlistcontent
    |> cast(params, [:id_user, :id_creator, :id_wl])
  end

end
