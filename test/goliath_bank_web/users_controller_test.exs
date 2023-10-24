defmodule GoliathBankWeb.UsersControllerTest do
  use GoliathBankWeb.ConnCase

  alias GoliathBank.Users

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

    test "got invalid params in user creation", %{conn: conn} do
      params = %{
        first_name: "Fulano",
        last_name: "de Tal",
        cpf: "2345678901",
        password: "qwerty"
      }

      response =
        conn
        |> post(~p"/api/users", params)
        |> json_response(:bad_request)

        assert %{"errors" => %{"cpf" => ["should be 11 character(s)"]}} = response
    end
  end

  describe "list/0" do
    test "test if it returns a list with success", %{conn: conn} do
      response =
        conn
        |> get(~p"/api/users")
        |> json_response(:ok)

      assert %{"data" => []} = response
    end

    test "test if the inserted user is coming in the listing", %{conn: conn} do
      params = %{
        first_name: "Fulano",
        last_name: "de Tal",
        cpf: "23456789001",
        password: "qwerty"
      }

      # Create a user using the Users module
      {:ok, user} = Users.create(params)

      response =
        conn
        |> get("/api/users")
        |> json_response(:ok)

      # Assert that the response contains the inserted user
      assert %{"data" => [
                          %{"id" => _id, "cpf" => "23456789001", "first_name" => "Fulano", "last_name" => "de Tal"}
                        ]} = response
    end
  end
end
