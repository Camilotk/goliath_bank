defmodule GoliathBank.Transactions.Transaction do
  use Ecto.Schema
  import Ecto.Changeset

  alias GoliathBank.Accounts.Account

  @required_params ~w[amount sender_id receiver_id]a

  @derive {Jason.Encoder, except: [:__meta__]}
  schema "transactions" do
    field :amount, :decimal
    belongs_to :sender, Account, foreign_key: :sender_id
    belongs_to :receiver, Account, foreign_key: :receiver_id

    timestamps()
  end

  def changeset(transaction \\ %__MODULE__{}, params) do
    transaction
    |> cast(params, @required_params)
    |> validate_required(@required_params)
    |> check_constraint(:balance, name: :amount_must_be_positive)
  end
end
