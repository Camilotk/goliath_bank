defmodule GoliathBankWeb.UsersControllerTest do
  use GoliathBankWeb.ConnCase
  describe "create/2" do
    test "successfully creates an user", %{conn: conn} do
      params = %{
        first_name: "Fulano",
        last_name: "de Tal",
        cpf: "23456789001",
        password: "qwerty"
      }

      response =
        conn
        |> post(~p"/api/users", params)
        |> json_response(:created)

      assert %{"data" => %{
                            "id" => _id,
                            "first_name" => "Fulano",
                            "last_name" => "de Tal",
                            "cpf" => "23456789001"
                          }, "message" => "Created with success!"} = response
    end
  end
end
