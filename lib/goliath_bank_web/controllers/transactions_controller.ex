defmodule GoliathBankWeb.TransactionsController do
  use GoliathBankWeb, :controller

  alias GoliathBank.Transactions

  action_fallback GoliathBankWeb.FallbackController

  def create(conn, %{"sender_id" => sender_id, "receiver_id" => receiver_id, "amount" => amount}) do
    with {:ok, %{save_in_database: transaction}} <- Transactions.create(sender_id, receiver_id, Decimal.new(amount)) do
        conn
        |> put_status(:created)
        |> render(:create, transaction: transaction)
    end
  end
end
