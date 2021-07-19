defmodule FilmotecaWeb.API.V1.SessionController do
  use FilmotecaWeb, :controller
  use FilmotecaWeb, :model

  alias FilmotecaWeb.APIAuthPlug
  alias Filmoteca.Repo
  alias Filmoteca.Users.User
  alias Filmoteca.Watchlists.Watchlist
  alias Filmoteca.Watchlists.Watchlistcontent
  alias Filmoteca.Watchlists.Subscription
  alias Plug.Conn

  @spec create(Conn.t(), map()) :: Conn.t()
  def create(conn, %{"user" => user_params}) do
    conn
    |> Pow.Plug.authenticate_user(user_params)
    |> case do
      {:ok, conn} ->
        json(conn, %{data: %{access_token: conn.private.api_access_token, renewal_token: conn.private.api_renewal_token}})

      {:error, conn} ->
        conn
        |> put_status(401)
        |> json(%{error: %{status: 401, message: "Invalid email or password"}})
    end
  end

  @spec renew(Conn.t(), map()) :: Conn.t()
  def renew(conn, _params) do
    config = Pow.Plug.fetch_config(conn)

    conn
    |> APIAuthPlug.renew(config)
    |> case do
      {conn, nil} ->
        conn
        |> put_status(401)
        |> json(%{error: %{status: 401, message: "Invalid token"}})

      {conn, _user} ->
        json(conn, %{data: %{access_token: conn.private.api_access_token, renewal_token: conn.private.api_renewal_token}})
    end
  end

  @spec delete(Conn.t(), map()) :: Conn.t()
  def delete(conn, _params) do
    conn
    |> Pow.Plug.delete()
    |> json(%{data: %{}})
  end

  def getUserData(conn, %{"email" => email}) do
    id_query = from u in "users",
            where: u.email == ^email,
            select: u.id
    nick_query = from u in "users",
            where: u.email == ^email,
            select: u.nickname
    id = Repo.all(id_query)
    nick = Repo.all(nick_query)
    conn
    |> json(%{user_id: id, user_nickname: nick})
  end

  def deleteUserData(conn, %{"id_user" => id_user}) do
    from(wlc in Watchlistcontent, where: wlc.id_user == ^id_user) |> Repo.delete_all
    from(wl in Watchlist, where: wl.user_id == ^id_user) |> Repo.delete_all
    from(u in User, where: u.id_user == ^id_user) |> Repo.delete_all
    from(sub in Subscription, where: sub.id_creator == ^id_user) |> Repo.delete_all
    conn
    |> put_status(:ok)
    |> send_resp(200, "ok")
  end
end
