defmodule GoliathBank.Accounts do
  alias GoliathBank.Accounts.{Create, Get}

  defdelegate create(params), to: Create, as: :call
  defdelegate get(id), to: Get, as: :call
end
