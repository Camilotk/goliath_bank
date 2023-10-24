defmodule GoliathBank.Accounts.Create do
  alias GoliathBank.Accounts.Account
  alias GoliathBank.Repo

  def call(params) do
    params
    |> Account.changeset()
    |> Repo.insert()
  end
end
