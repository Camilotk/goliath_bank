defmodule GoliathBank.Accounts.Create do
  alias GoliathBank.Accounts.Account
  alias GoliathBank.Users.User
  alias GoliathBank.Repo

  def call(%{"user_id" => id} = params) do
    case Repo.get(User, id) do
      nil -> {:error, :not_found}
      _ -> create(params)
    end
  end

  defp create(params) do
    params
    |> Account.changeset()
    |> Repo.insert()
  end
end
