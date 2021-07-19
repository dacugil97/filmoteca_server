defmodule FilmotecaWeb.Router do
  use FilmotecaWeb, :router
  use Pow.Phoenix.Router
  use Pow.Extension.Phoenix.Router,
    extensions: [PowResetPassword, PowEmailConfirmation]

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
    plug :fetch_session
    plug :fetch_flash
    plug FilmotecaWeb.APIAuthPlug, otp_app: :filmoteca
  end

  scope "/api/v1", FilmotecaWeb.API.V1, as: :api_v1 do
    pipe_through :api

    resources "/registration", RegistrationController, singleton: true, only: [:create]
    resources "/session", SessionController, singleton: true, only: [:create, :delete]
    post "/session/renew", SessionController, :renew
    get "/getUserData", SessionController, :getUserData
    resources "/movies", MovieController
    resources "/watchlists", WatchlistController
    post "/watchlist/addMovie", WatchlistController, :addMovie
    get "/watchlist/getWatchlists", WatchlistController, :getWatchlists
    get "/watchlist/getUserMovies", WatchlistController, :getUserMovies
    get "/watchlist/getWatchlistcontents", WatchlistController, :getWatchlistcontents
    delete "/watchlist/deleteMovie", WatchlistController, :deleteWatchlistcontent
    delete "/watchlist/deleteWatchlist", WatchlistController, :deleteWatchlist
    get "/watchlist/public", WatchlistController, :searchPublicWatchlist
    get "/watchlist/getPublicMovies", WatchlistController, :getPublicMovies
    post "/watchlist/subscribe", WatchlistController, :subscribeToWatchlist
    get "/watchlist/getSubscriptions", WatchlistController, :getSubscriptions
    get "/watchlist/getSubscriptionWls", WatchlistController, :getSubscriptionWatchlists
    delete "/watchlist/unsubscribe", WatchlistController, :unsubscribe
  end

  #scope "/", FilmotecaWeb do
  #  pipe_through [:browser, :not_authenticated]
  #
  #  get "/signup", RegistrationController, :new, as: :signup
  #  post "/signup", RegistrationController, :create, as: :signup
  #  get "/login", SessionController, :new, as: :login
  #  post "/login", SessionController, :create, as: :login
  #  get "/csrftoken", SessionController, :gettoken
  #  get "/session", SessionController, :getsession
  #end

  #scope "/", FilmotecaWeb do
  #  pipe_through [:browser, :protected]

  #  delete "/logout", SessionController, :delete, as: :logout
  #end

  scope "/" do
    pipe_through :browser

    pow_routes()
    pow_extension_routes()
  end

  # Other scopes may use custom stacks.
  # scope "/api", FilmotecaWeb do
  #   pipe_through :api
  # end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser
      live_dashboard "/dashboard", metrics: FilmotecaWeb.Telemetry
    end
  end
end
