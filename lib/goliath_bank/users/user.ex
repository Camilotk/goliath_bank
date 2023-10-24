defmodule GoliathBank.Users.User do
  use Ecto.Schema
  import Ecto.Changeset

  @fields     ~w[cpf first_name last_name password]a
  @excluded_fields [:__meta__, :password, :password_hash, :inserted_at, :updated_at]

  @derive {Jason.Encoder, except: @excluded_fields}
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
    |> cast(attrs, @fields)
    |> validate_required(@fields)
    |> unique_constraint(:cpf)
    |> validate_length(:cpf, is: 11)
    |> add_password_hash()
  end

  defp add_password_hash(%Ecto.Changeset{valid?: true, changes: %{password: password}} = changeset) do
    change(changeset, Argon2.add_hash(password))
  end

  defp add_password_hash(changeset), do: changeset
end
