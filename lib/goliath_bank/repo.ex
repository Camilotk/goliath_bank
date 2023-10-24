defmodule GoliathBank.Repo do
  use Ecto.Repo,
    otp_app: :goliath_bank,
    adapter: Ecto.Adapters.Postgres
end
