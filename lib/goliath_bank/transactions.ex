defmodule GoliathBank.Transactions do
  alias GoliathBank.Transactions.{Create, Search}

  defdelegate create(params), to: Create, as: :call
  defdelegate search(params), to: Search, as: :call
end
