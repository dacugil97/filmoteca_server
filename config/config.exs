# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :filmoteca, Filmoteca.Repo,
  username: "postgres",
  password: "postgres",
  database: "filmoteca_dev",
  hostname: "localhost"

config :filmoteca,
  ecto_repos: [Filmoteca.Repo]

# Configures the endpoint
config :filmoteca, FilmotecaWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "AIUTTpPrsx+7qFze1jOxFFTWG9DWM1CSGNrt6O8ivXP/pSgBiwFhgiodweAbo/yJ",
  render_errors: [view: FilmotecaWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Filmoteca.PubSub,
  live_view: [signing_salt: "U0SvaWC8"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Pow config
config :filmoteca, :pow,
  user: Filmoteca.Users.User,
  repo: Filmoteca.Repo,
  extensions: [PowResetPassword, PowEmailConfirmation],
  controller_callbacks: Pow.Extension.Phoenix.ControllerCallbacks,
  mailer_backend: FilmotecaWeb.Pow.Mailer,
  web_mailer_module: FilmotecaWeb,
  web_module: FilmotecaWeb

config :filmoteca, FilmotecaWeb.Pow.Mailer,
  adapter: Swoosh.Adapters.Sendgrid,
  api_key: "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"

# Swoosh config
#config :filmoteca, Filmoteca.Pow.Mailer,
#  adapter: Swoosh.Adapters.Mailjet,
#  api_key: mailjet_api_key,
#  secret: mailjet_secret_key

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
