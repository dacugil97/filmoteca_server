defmodule Filmoteca.Users.User do
  use FilmotecaWeb, :model
  use Pow.Ecto.Schema
  use Pow.Extension.Ecto.Schema,
    extensions: [PowResetPassword, PowEmailConfirmation]

  schema "users" do
    pow_user_fields()
    field :nickname, :string

    has_many :watchlists, Filmoteca.Watchlists.Watchlist
    timestamps()
  end

  def changeset(user_or_changeset, attrs) do
    user_or_changeset
    |> pow_changeset(attrs)
    |> Ecto.Changeset.cast(attrs, [:nickname])
    |> Ecto.Changeset.validate_required([:nickname])
    |> pow_extension_changeset(attrs)
  end

end
