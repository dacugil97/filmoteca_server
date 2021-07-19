defmodule Filmoteca.Movies.Movie do
  use FilmotecaWeb, :model

  @primary_key {:id, :integer, []}
  @derive {Phoenix.Param, key: :id}
  @derive {Jason.Encoder, only: [:id, :title, :year, :overview, :director, :casting, :poster, :backdrop, :runtime, :rating, :omdb]}
  schema "movies" do
    field :title, :string
    field :year, :string
    field :overview, :string
    field :director, :string
    field :casting, :string
    field :poster, :string
    field :backdrop, :string
    field :runtime, :string
    field :rating, :string
    field :omdb, :boolean
  end

  def changeset(movie, params \\ %{}) do
    movie
    |> cast(params, [:id, :title, :year, :overview, :director, :casting, :poster, :backdrop, :runtime, :rating, :omdb])
  end

end
