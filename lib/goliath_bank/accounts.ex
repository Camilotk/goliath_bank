defmodule GoliathBank.Accounts do
  alias GoliathBank.Accounts.Create

  defdelegate create(params), to: Create, as: :call
end
