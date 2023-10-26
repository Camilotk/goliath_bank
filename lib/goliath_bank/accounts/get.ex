defmodule GoliathBank.Accounts.Get do
  alias GoliathBank.Accounts.Account
  alias GoliathBank.Repo

  def call(id) do
    case Repo.get(Account, id) do
      nil -> {:error, :not_found}
      account -> {:ok, account}
    end
  end
end
