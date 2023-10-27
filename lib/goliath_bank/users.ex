defmodule GoliathBank.Users do
  alias GoliathBank.Users.{Create, Get, Update, Delete, List, Verify}

  defdelegate create(params), to: Create, as: :call
  defdelegate delete(id), to: Delete, as: :call
  defdelegate get(id), to: Get, as: :call
  defdelegate list(), to: List, as: :call
  defdelegate update(params), to: Update, as: :call
  defdelegate login(params), to: Verify, as: :call
end
