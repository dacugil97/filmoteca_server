use Mix.Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :filmoteca, Filmoteca.Repo,
  username: "postgres",
  password: "postgres",
  database: "filmoteca_test#{System.get_env("MIX_TEST_PARTITION")}",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox


# Pow config
config :filmoteca, :pow,
  user: Filmoteca.Users.User,
  repo: Filmoteca.Repo,
  extensions: [PowResetPassword, PowEmailConfirmation],
  controller_callbacks: Pow.Extension.Phoenix.ControllerCallbacks,
  mailer_backend: FilmotecaWeb.Pow.Mailer,
  web_mailer_module: FilmotecaWeb,
  web_module: FilmotecaWeb

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :filmoteca, FilmotecaWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn
