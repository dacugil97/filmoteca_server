defmodule FilmotecaWeb.PowEmailConfirmation.MailerView do
  use FilmotecaWeb, :mailer_view

  def subject(:email_confirmation, _assigns), do: "Confirm your email address"
end
