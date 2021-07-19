defmodule FilmotecaWeb.PageController do
  use FilmotecaWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
