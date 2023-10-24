defmodule GoliathBankWeb.UsersJSON do
  def create(%{user: user}), do: %{message: "Created with success!", data: user}
end
