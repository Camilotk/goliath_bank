defmodule GoliathBank.Accounts.Account do
  use Ecto.Schema
  import Ecto.Changeset

  alias GoliathBank.Users.User

  @fields ~w[balance user_id]a

  @derive {Jason.Encoder, except: [:__meta__]}
  schema "accounts" do
    field :balance, :decimal
    belongs_to :user, User

    timestamps()
  end

  def changeset(account \\ %__MODULE__{}, params) do
    account
    |> cast(params, @fields)
    |> validate_required(@fields)
    |> check_constraint(:balance, name: :balance_must_be_positive)
  end
end
