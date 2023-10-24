defmodule GoliathBank.Users.List do
  alias GoliathBank.Users.User
  alias GoliathBank.Repo

  def call() do
    case Repo.all(User) do
      nil -> {:error, :not_found}
      users -> {:ok, users}
    end
  end
end
