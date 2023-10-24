defmodule GoliathBankWeb.ErrorJSON do
  def error(%{status: :not_found}) do
    %{status: :not_found, message: "User not found in database!"}
  end

  def error(%{changeset: changeset}) do
    %{errors: Ecto.Changeset.traverse_errors(changeset, fn {msg, opts} ->
      Regex.replace(~r"%{(\w+)}", msg, fn _, key ->
        opts |> Keyword.get(String.to_existing_atom(key), key) |> to_string()
      end)
    end)}
  end
end
