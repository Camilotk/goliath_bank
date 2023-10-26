defmodule GoliathBankWeb.TransactionsController do
  use GoliathBankWeb, :controller

  alias GoliathBank.Transactions

  action_fallback GoliathBankWeb.FallbackController

  def create(conn, %{"sender_id" => sender_id, "receiver_id" => receiver_id, "amount" => amount}) do
    case Transactions.create(sender_id, receiver_id, Decimal.new(amount)) do
      {:ok, %{save_in_database: transaction}} ->
        conn
        |> put_status(:created)
        |> render(:create, transaction: transaction)
      # {:error, _reason} ->
      #   conn
      #   |> put_status(:unprocessable_entity)
      #   |> render(GoliathBankWeb.FallbackController, "error.json")
    end
  end
end
