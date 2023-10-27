defmodule GoliathBank.Users.Verify do
  alias GoliathBank.Users
  alias Users.User

  def call(%{"id" => id, "password" => password}) do
    case Users.get(id) do
      {:ok, user} -> verify(password, user)
      {:error, _} = error-> error
    end
  end

  defp verify(password, %User{password_hash: password_hash} = user) do
    if Argon2.verify_pass(password, password_hash) do
      {:ok, user}
    else
      {:error, :unauthorized}
    end
  end
end
