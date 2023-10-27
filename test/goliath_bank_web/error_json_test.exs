defmodule GoliathBankWeb.ErrorJSONTest do
  use GoliathBankWeb.ConnCase, async: true

  alias GoliathBank.Users.User

  test "renders 404" do
    assert GoliathBankWeb.ErrorJSON.error(%{status: :not_found}) == %{message: "User not found in database!", status: :not_found}
  end

  test "renders 500" do
    changeset = User.changeset(%{cpf: "1234"})
    assert GoliathBankWeb.ErrorJSON.error(%{changeset: changeset}) ==
      %{errors: %{
                  cpf: ["CPF is invalid","should be 11 character(s)"],
                  first_name: ["can't be blank"],
                  last_name: ["can't be blank"],
                  password: ["can't be blank"]}}
  end
end
