defmodule GoliathBankWeb.UsersController do
  use GoliathBankWeb, :controller

  alias GoliathBank.Users
  alias Users.User

  action_fallback GoliathBankWeb.FallbackController

  def create(conn, params) do
    with {:ok, %User{} = user} <- Users.create(params) do
      conn
      |> put_status(:created)
      |> render(:create, user: user)
    end
  end
end
