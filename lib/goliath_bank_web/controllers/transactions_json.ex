defmodule GoliathBankWeb.TransactionsJSON do
  def create(%{transaction: transaction}) do
    %{
      amount: transaction.amount,
      sender: transaction.sender_id,
      receiver: transaction.receiver_id
    }
  end

  def search(%{transactions: transactions}), do: Enum.map(transactions, &render_transaction/1)

  def render_transaction(transaction) do
    %{
      transaction_id: transaction.id,
      sender: transaction.sender_id,
      receiver: transaction.receiver_id,
      amount: transaction.amount,
      datetime: transaction.inserted_at
    }
  end
end
