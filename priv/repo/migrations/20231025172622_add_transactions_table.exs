defmodule GoliathBank.Repo.Migrations.AddTransactionsTable do
  use Ecto.Migration

  def change do
    create table("transactions") do
      add :amount, :decimal, null: false
      add :sender_id, references(:accounts, on_delete: :nothing)
      add :receiver_id, references(:accounts, on_delete: :nothing)

      timestamps()
    end
  end
end
