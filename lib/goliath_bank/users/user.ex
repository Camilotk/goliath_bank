defmodule GoliathBank.Users.User do
  use Ecto.Schema
  import Ecto.Changeset

  @cast_fields     ~w[cpf first_name last_name password]a
  @required_fields ~w[cpf first_name password]a
  @excluded_fields ~w[id first_name last_name cpf inserted_at updated_at]a

  @derive {Jason.Encoder, except: @excluded_fields}
  @primary_key {:id, :binary_id, autogenerate: true}
  schema "users" do
    field :first_name, :string
    field :last_name, :string
    field :password, :string, virtual: true
    field :password_hash, :string
    field :cpf, :string

    timestamps()
  end

  def changeset(user \\ %__MODULE__{}, attrs) do
    user
    |> cast(attrs, @cast_fields)
    |> validate_required(@required_fields)
    |> unique_constraint(:cpf)
    |> validate_length(:cpf, is: 11)
  end
end
