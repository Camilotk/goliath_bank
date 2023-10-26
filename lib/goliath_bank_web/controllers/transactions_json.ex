defmodule GoliathBankWeb.TransactionsJSON do
  def create(%{transaction: transaction}) do
    %{
      amount: transaction.amount,
      sender: transaction.sender_id,
      receiver: transaction.receiver_id
    }
  end

  def search(%{transactions: transactions}), do: transactions
end
