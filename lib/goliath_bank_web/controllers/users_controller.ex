defmodule GoliathBankWeb.UsersController do
  use GoliathBankWeb, :controller

  alias GoliathBank.Users.User
  alias GoliathBank.Users.Create

  def create(conn, params) do
    with {:ok, %User{} = user} <- Create.call(params) do
      conn
      |> put_status(:created)
      |> render(:create, user: user)
    end
  end
end
