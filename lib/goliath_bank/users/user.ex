defmodule GoliathBank.Users.User do
  use Ecto.Schema
  import Ecto.Changeset

  alias GoliathBank.Accounts.Account

  @fields          ~w[cpf first_name last_name password]a
  @update_fields   ~w[cpf first_name last_name]a
  @excluded_fields [:__meta__, :password, :password_hash, :account, :inserted_at, :updated_at]

  @derive {Jason.Encoder, except: @excluded_fields}
  schema "users" do
    field :first_name, :string
    field :last_name, :string
    field :password, :string, virtual: true
    field :password_hash, :string
    field :cpf, :string
    has_one :account, Account

    timestamps()
  end
  def changeset(user \\ %__MODULE__{}, attrs)
  def changeset(%__MODULE__{id: nil} = user, attrs) do
    user
    |> cast(attrs, @fields)
    |> validate_required(@fields)
    |> unique_constraint(:cpf)
    |> validate_length(:cpf, is: 11)
    |> validate_cpf(:cpf)
    |> add_password_hash()
  end

  def changeset(user, attrs) do
    user
    |> cast(attrs, @fields)
    |> validate_required(@update_fields)
    |> unique_constraint(:cpf)
    |> validate_length(:cpf, is: 11)
    |> validate_cpf(:cpf)
    |> add_password_hash()
  end

  defp add_password_hash(%Ecto.Changeset{valid?: true, changes: %{password: password}} = changeset) do
    change(changeset, Argon2.add_hash(password))
  end

  defp add_password_hash(changeset), do: changeset

  defp validate_digit(digits, validate_array, digit) do
    remainder = digits
                |> Enum.zip_reduce(validate_array, 0, fn left, right, acc -> acc + (left * right) end)
                |> Kernel.*(10)
                |> Kernel.rem(11)

    remainder == digit or (remainder == 10 and digit == 0)
  end

  defp validate_edge_cases(document, size) do
    has_correct_length = String.length(document) == size
    has_same_digits = Regex.match?(~r/^(\d)\1+$/, document)

    has_correct_length and not has_same_digits
  end

  def is_cpf_valid?(:cpf, document_number) do
    clean_document = Regex.replace(~r/[^0-9]/, document_number, "")

    cpf = clean_document
          |> String.split("", trim: true)
          |> Enum.map(fn x -> elem(Integer.parse(x), 0) end)

    digits = cpf
             |> Enum.slice(9, 2)

    first_digit_valid = cpf
                            |> Enum.slice(0, 9)
                            |> validate_digit(Enum.to_list(10..2), List.first(digits))

    second_digit_valid = cpf
                            |> Enum.slice(0, 10)
                            |> validate_digit(Enum.to_list(11..2), List.last(digits))

    edge_cases_validated = validate_edge_cases(clean_document, 11)

    first_digit_valid and second_digit_valid and edge_cases_validated
  end

  defp validate_cpf(changeset, field) do
    validate_change(changeset, field, fn _, value ->
      if is_cpf_valid?(:cpf, value) do
        []
      else
        [{field, "CPF is invalid"}]
      end
    end)
  end
end
