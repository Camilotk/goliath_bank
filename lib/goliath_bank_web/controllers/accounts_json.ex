defmodule GoliathBankWeb.AccountsJSON do
  def create(%{account: account}), do: %{data: account}
  def get(%{account: account}), do: %{data: account}
end
