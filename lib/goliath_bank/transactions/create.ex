defmodule GoliathBank.Transactions.Create do
  alias Ecto.Multi
  alias GoliathBank.Repo
  alias GoliathBank.Accounts.Account
  alias GoliathBank.Transactions.Transaction

  def call(from_account_id, to_account_id, value) do
    with %Account{} = sender <- Repo.get(Account, from_account_id),
         %Account{} = reciever <- Repo.get(Account, to_account_id) do
         Multi.new()
         |> withdraw(sender, value)
         |> deposit(reciever, value)
         |> insert_db(from_account_id, to_account_id, value)
         |> Repo.transaction()
    else
      nil -> {:error, :not_found}
    end
  end

  defp deposit(multi, account, value) do
    new_balance = Decimal.add(account.balance, value)
    changeset = Account.changeset(account, %{balance: new_balance})
    Multi.update(multi, :deposit, changeset)
  end

  defp withdraw(multi, account, value) do
    new_balance = Decimal.sub(account.balance, value)
    changeset = Account.changeset(account, %{balance: new_balance})
    Multi.update(multi, :withdraw, changeset)
  end

  defp insert_db(multi, from_account_id, to_account_id, value) do
    transaction = Transaction.changeset(%Transaction{}, %{sender_id: from_account_id, receiver_id: to_account_id, amount: value})
    Multi.insert(multi, :save_in_database, transaction)
  end
end
