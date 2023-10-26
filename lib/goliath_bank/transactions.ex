defmodule GoliathBank.Transactions do
  alias GoliathBank.Transactions.Create

  defdelegate create(params), to: Create, as: :call
end
