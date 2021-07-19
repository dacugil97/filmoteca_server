defmodule Filmoteca.Repo do
  use Ecto.Repo,
    otp_app: :filmoteca,
    adapter: Ecto.Adapters.Postgres
end
