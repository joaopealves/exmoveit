use Mix.Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :exmoveit, Exmoveit.Repo,
  username: System.get_env("DB_USERNAME"),
  password: System.get_env("DB_PASSWORD"),
  database: "exmoveit_test#{System.get_env("MIX_TEST_PARTITION")}",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

if System.get_env("GITHUB_ACTIONS") do
  config :exmoveit, Exmoveit.Repo,
    username: "postgres",
    password: "postgres"
end

if System.get_env("CIRCLECI_ACTIONS") do
  config :exmoveit, Exmoveit.Repo,
    username: "postgres",
    password: "postgres"
end

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :exmoveit, ExmoveitWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn
