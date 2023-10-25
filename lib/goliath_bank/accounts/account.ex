defmodule GoliathBank.Accounts.Account do
  use Ecto.Schema
  import Ecto.Changeset

  alias GoliathBank.Users.User

  @required_params ~w[balance user_id]a

  @derive {Jason.Encoder, only: [:user_id, :balance]}
  schema "accounts" do
    field :balance, :decimal
    belongs_to :user, User

    timestamps()
  end

  def changeset(account \\ %__MODULE__{}, params) do
    account
    |> cast(params, @required_params)
    |> validate_required(@required_params)
    |> check_constraint(:balance, name: :balance_must_be_positive)
  end
end
