defmodule GoliathBankWeb.TransactionsController do
  use GoliathBankWeb, :controller

  alias GoliathBank.Transactions

  action_fallback GoliathBankWeb.FallbackController

  def create(conn, params) do
    with {:ok, %{save_in_database: transaction}} <- Transactions.create(params) do
        conn
        |> put_status(:created)
        |> render(:create, transaction: transaction)
    end
  end

  def search(conn, params) do
    with transactions <- Transactions.search(params) do
        conn
        |> put_status(:created)
        |> render(:search, transactions: transactions)
    end
  end
end
