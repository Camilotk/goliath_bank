defmodule GoliathBank.Repo.Migrations.AddUsersTable do
  use Ecto.Migration

  def change do
    create table("users") do
      add :name, :string, null: false
      add :password_hash, :string, null: false
      add :email, :string, null: false
      add :cpf, :string, null: false

      timestamps()
    end

    unique_index("users", [:cpf])
  end
end
