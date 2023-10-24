defmodule GoliathBankWeb.UsersJSON do
  def create(%{user: user}), do: %{message: "Created with success!", data: user}
  def delete(%{user: user}), do: %{data: user}
  def get(%{user: user}), do: %{data: user}
  def index(%{users: users}), do: %{data: users}
  def update(%{user: user}), do: %{data: user}
end
