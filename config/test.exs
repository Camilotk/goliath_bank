import Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :goliath_bank, GoliathBank.Repo,
  username: "postgres",
  password: "asdf",
  hostname: "localhost",
  database: "goliath_bank_test#{System.get_env("MIX_TEST_PARTITION")}",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :goliath_bank, GoliathBankWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "6k41IhSVMmVyYc7yN5RqUNiEVUjSQZnaIUAIZR3EpsxRlilHHRV1N/LIwV0YMBwR",
  server: false

# Print only warnings and errors during test
config :logger, level: :warning

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
