defmodule GoliathBankWeb.TransactionsController do
  use GoliathBankWeb, :controller

  alias GoliathBank.Transactions

  action_fallback GoliathBankWeb.FallbackController

  def create(conn, params) do
    IO.inspect(params)
    with {:ok, %{save_in_database: transaction}} <- Transactions.create(params) do
        conn
        |> put_status(:created)
        |> render(:create, transaction: transaction)
    end
  end
end
