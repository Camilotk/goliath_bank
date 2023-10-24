defmodule GoliathBank.Users.Create do
  alias GoliathBank.Users.User
  alias GoliathBank.Repo

  def call(params) do
    params
    |> User.changeset()
    |> Repo.insert()
  end
end
