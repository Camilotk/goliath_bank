defmodule GoliathBank.Repo.Migrations.AddBalanceConstraintToTransactions do
  use Ecto.Migration

  def change do
    create constraint(:transactions, :amount_must_be_positive, check: "amount >= 0")
  end
end
