defmodule GoliathBankWeb.AccountsController do
  use GoliathBankWeb, :controller

  alias GoliathBank.Accounts
  alias Accounts.Account

  action_fallback GoliathBankWeb.FallbackController

  def create(conn, params) do
    with {:ok, %Account{} = account} <- Accounts.create(params) do
      conn
      |> put_status(:created)
      |> render(:create, account: account)
    end
  end

  def show(conn, %{"id" => id}) do
    with {:ok, %Account{} = account} <- Accounts.get(id) do
      conn
      |> put_status(:ok)
      |> render(:get, account: account)
    end
  end
end
