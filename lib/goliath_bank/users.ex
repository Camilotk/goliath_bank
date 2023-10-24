defmodule GoliathBank.Users do
  alias GoliathBank.Users.Create

  defdelegate create(params), to: Create, as: :call
end
