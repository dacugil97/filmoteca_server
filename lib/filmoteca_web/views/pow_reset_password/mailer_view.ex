defmodule FilmotecaWeb.PowResetPassword.MailerView do
  use FilmotecaWeb, :mailer_view

  def subject(:reset_password, _assigns), do: "Reset password link"
end
