defmodule GoliathBankWeb.ErrorJSON do
  def error(%{status: :not_found}) do
    %{status: :not_found, message: "User not found in database!"}
  end

  def error(%{status: :unauthorized}) do
    %{status: :unauthorized, message: "You don't have permission to access this resource!"}
  end

  def error(%{status: :invalid_value_in_amount}) do
    %{status: :invalid_value_in_amount, message: "The value in amount can't be parsed as number"}
  end

  def error(%{changeset: changeset}) do
    %{errors: Ecto.Changeset.traverse_errors(changeset, fn {msg, opts} ->
      Regex.replace(~r"%{(\w+)}", msg, fn _, key ->
        opts |> Keyword.get(String.to_existing_atom(key), key) |> to_string()
      end)
    end)}
  end

  def error(%{message: message}) do
    %{message: message}
  end
end
