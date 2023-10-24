defmodule GoliathBank.Users do
  alias GoliathBank.Users.{Create, Get}

  defdelegate create(params), to: Create, as: :call
  defdelegate get(id), to: Get, as: :call
end
