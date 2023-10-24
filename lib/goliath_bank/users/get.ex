defmodule GoliathBank.Users.Get do
  alias GoliathBank.Users.User
  alias GoliathBank.Repo

  def call(id) do
    case Repo.get(User, id) do
      nil -> {:error, :not_found}
      user -> {:ok, user}
    end
  end
end
