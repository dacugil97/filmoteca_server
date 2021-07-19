defmodule FilmotecaWeb.API.V1.MovieController do
  use FilmotecaWeb, :controller
  use FilmotecaWeb, :model

  alias Filmoteca.Movies.Movie
  alias Filmoteca.Repo

  def create(conn, %{"movie" => movie_params}) do
    changeset = Movie.changeset(%Movie{}, movie_params)
    {:ok, movie} = Repo.insert(changeset)

    conn
    |> put_flash(:info, "#{movie.title} created!")
    |> put_status(:ok)
    |> send_resp(:ok, "")
  end

  def getMovies(conn, _params) do
    query = from mv in Movie,
            select: mv

    result = Repo.all(query)|> Enum.into(%{})
  end
end
