defmodule FilmotecaWeb.API.V1.WatchlistController do
  use FilmotecaWeb, :controller
  use FilmotecaWeb, :model

  alias Filmoteca.Watchlists.Watchlist
  alias Filmoteca.Watchlists.Watchlistcontent
  alias Filmoteca.Watchlists.Subscription
  alias Filmoteca.Movies.Movie
  alias Filmoteca.Repo

  def create(conn, %{"watchlist" => watchlist_params}) do
    changeset = Watchlist.changeset(%Watchlist{}, watchlist_params)
    {:ok, _watchlist} = Repo.insert(changeset)

    conn
    |> put_flash(:info, "WatchList created!")
    |> put_status(:ok)
    |> send_resp(:ok, "")
  end

  def addMovie(conn, %{"watchlistcontent" => watchlistcontent_params}) do
    changeset = Watchlistcontent.changeset(%Watchlistcontent{}, watchlistcontent_params)
    {:ok, _watchlist} = Repo.insert(changeset)

    conn
    |> put_flash(:info, "movie added!")
    |> put_status(:ok)
    |> send_resp(:ok, "")
  end

  def getWatchlists(conn, %{"id_user" => id_user}) do
    query = from wl in Watchlist,
            where: wl.user_id == ^id_user,
            select: wl
    wls = Repo.all(query)|> Repo.preload(:user)
    conn
    |> json(%{watchlists: wls})
  end

  def getUserMovies(conn, %{"id_user" => id_user}) do
    query = from wlc in Watchlistcontent,
            join: m in Movie,
            on: wlc.id_mv == m.id,
            where: wlc.id_user == ^id_user,
            select: m
    mvs = Repo.all(query)
    conn
    |> json(%{movies: mvs})
  end

  def getWatchlistcontents(conn, %{"id_user" => id_user}) do
    query = from wlc in Watchlistcontent,
            where: wlc.id_user == ^id_user,
            select: wlc
    wlcs = Repo.all(query)
    conn
    |> json(%{contents: wlcs})
  end

  def getSubscriptions(conn, %{"id_user" => id_user}) do
    query = from sub in Subscription,
            where: sub.id_user == ^id_user,
            select: sub
    subs = Repo.all(query)
    conn
    |> json(%{subscriptions: subs})
  end

  def deleteWatchlistcontent(conn, %{"id_user" => id_user, "id_wl" => id_wl, "id_mv" => id_mv}) do
    from(wlc in Watchlistcontent, where: wlc.id_user == ^id_user and wlc.id_wl == ^id_wl and wlc.id_mv == ^id_mv) |> Repo.delete_all
    conn
    |> put_status(:ok)
    |> send_resp(200, "ok")
  end

  def deleteWatchlist(conn, %{"id_user" => id_user, "id_wl" => id_wl}) do
    from(wlc in Watchlistcontent, where: wlc.id_user == ^id_user and wlc.id_wl == ^id_wl) |> Repo.delete_all
    from(wl in Watchlist, where: wl.user_id == ^id_user and wl.id_wl == ^id_wl) |> Repo.delete_all
    from(sub in Subscription, where: sub.id_creator == ^id_user and sub.id_wl == ^id_wl) |> Repo.delete_all
    conn
    |> put_status(:ok)
    |> send_resp(200, "ok")
  end

  def searchPublicWatchlist(conn, %{"input" => input}) do
    like = "%#{input}%"
    query = from wl in Watchlist,
            where: wl.public == true
            and (like(wl.name, ^like) or like(wl.autor, ^like)),
            select: wl
    publics = Repo.all(query)
    conn
    |>json(%{watchlists: publics})
  end

  def getSubscriptionWatchlists(conn, %{"id_user" => id_user}) do
    query = from sub in Subscription,
            join: wl in Watchlist,
            on: sub.id_creator == wl.user_id,
            where: sub.id_user == ^id_user
            and sub.id_wl == wl.id_wl,
            select: wl
    subs = Repo.all(query)
    conn
    |> json(%{watchlists: subs})
  end

  def getPublicMovies(conn, %{"id_creator" => id_creator, "id_wl" => id_wl}) do
    query = from wlc in Watchlistcontent,
            join: m in Movie,
            on: wlc.id_mv == m.id,
            where: wlc.id_user == ^id_creator and wlc.id_wl == ^id_wl,
            select: m
    mvs = Repo.all(query)
    conn
    |> json(%{movies: mvs})
  end

  def subscribeToWatchlist(conn, %{"subscription" => subscription_params}) do
      changeset = Subscription.changeset(%Subscription{}, subscription_params)
      {:ok, _subscription} = Repo.insert(changeset)

      conn
      |> put_flash(:info, "subscription added!")
      |> put_status(:ok)
      |> send_resp(:ok, "")
  end

  def unsubscribe(conn, %{"id_user" => id_user, "id_creator" => id_creator, "id_wl" => id_wl}) do
    from(sub in Subscription, where: sub.id_user == ^id_user and sub.id_creator == ^id_creator and sub.id_wl == ^id_wl) |> Repo.delete_all
    conn
    |> put_status(:ok)
    |> send_resp(200, "ok")
  end

end
