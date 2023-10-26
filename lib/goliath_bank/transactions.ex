defmodule GoliathBank.Transactions do
  alias GoliathBank.Transactions.Create

  defdelegate create(from_account_id, to_account_id, value), to: Create, as: :call
end
