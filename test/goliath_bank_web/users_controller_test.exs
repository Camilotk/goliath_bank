defmodule GoliathBankWeb.UsersControllerTest do
  use GoliathBankWeb.ConnCase

  alias GoliathBank.Users
  alias Users.User

  describe "create/2" do
    test "successfully creates an user", %{conn: conn} do
      params = %{
        first_name: "Kristof",
        last_name: "Doppelganger",
        cpf: "48244118075",
        password: "qwerty"
      }

      response =
        conn
        |> post(~p"/api/users", params)
        |> json_response(:created)

      assert %{"data" => %{
                            "id" => _id,
                            "first_name" => "Kristof",
                            "last_name" => "Doppelganger",
                            "cpf" => "48244118075"
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

      assert %{"errors" => %{"cpf" => ["CPF is invalid", "should be 11 character(s)"]}} = response
    end
  end

  describe "delete/1" do
    test "test if a user has been deleted", %{conn: conn} do
      params = %{
        first_name: "Keyser",
        last_name: "Soze",
        cpf: "02987502010",
        password: "qwerty"
      }

      {:ok, %User{id: id}} = Users.create(params)

      response =
        conn
        |> delete(~p"/api/users/#{id}", params)
        |> json_response(:ok)

        assert %{"data" => %{
          "id" => id,
          "first_name" => "Keyser",
          "last_name" => "Soze",
          "cpf" => "02987502010"
        }} = response
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
        first_name: "Barney",
        last_name: "Westside",
        cpf: "11704366097",
        password: "qwerty"
      }

      {:ok, user} = Users.create(params)

      response =
        conn
        |> get("/api/users")
        |> json_response(:ok)

      assert %{"data" => [
                          %{"id" => _id, "cpf" => "11704366097", "first_name" => "Barney", "last_name" => "Westside"}
                        ]} = response
    end
  end

  describe "show/1" do
    test "returns a specific user with success", %{conn: conn} do
      params = %{
        first_name: "Bob",
        last_name: "Swarley-man",
        cpf: "93929389002",
        password: "qwerty"
      }

      {:ok, user} = Users.create(params)

      response =
        conn
        |> get("/api/users/#{user.id}")
        |> json_response(:ok)

      assert %{"data" => %{"id" => _id, "cpf" => "93929389002", "first_name" => "Bob", "last_name" => "Swarley-man"}} = response
    end

    test "returns an error when user is not found", %{conn: conn} do
      non_existent_user_id = 999

      response =
        conn
        |> get("/api/users/#{non_existent_user_id}")
        |> json_response(:not_found)

      assert %{"message" => "User not found in database!", "status" => "not_found"} = response
    end
  end

  describe "update/2" do
    test "successfully updates a user's information", %{conn: conn} do
      params = %{
        first_name: "Barack",
        last_name: "Obama Jr.",
        cpf: "58592320046",
        password: "qwerty"
      }

      {:ok, user} = Users.create(params)

      updated_params = %{
        first_name: "Novo Nome",
        last_name: "Novo Sobrenome"
      }

      response =
        conn
        |> put("/api/users/#{user.id}", updated_params)
        |> json_response(:ok)

      assert %{"data" => %{"id" => _id, "cpf" => "58592320046", "first_name" => "Novo Nome", "last_name" => "Novo Sobrenome"}} = response
    end

    test "returns an error when trying to update a non-existent user", %{conn: conn} do
      non_existent_user_id = 999
      updated_params = %{
        first_name: "Novo Nome",
        last_name: "Novo Sobrenome"
      }

      response =
        conn
        |> put("/api/users/#{non_existent_user_id}", updated_params)
        |> json_response(:not_found)

      assert  %{"message" => "User not found in database!", "status" => "not_found"} = response
    end
  end
end
