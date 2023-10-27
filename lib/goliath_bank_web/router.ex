defmodule GoliathBankWeb.Router do
  use GoliathBankWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", GoliathBankWeb do
    pipe_through :api
    resources "/users", UsersController, only: [:index, :create, :update, :delete, :show]
    post "/users/login", UsersController, :login
    post "/accounts", AccountsController, :create
    get "/accounts/balance/:id", AccountsController, :show
    post "/transactions", TransactionsController, :create
    get "/transactions/:start_date/:end_date", TransactionsController, :search
  end

  # Enable LiveDashboard in development
  if Application.compile_env(:goliath_bank, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through [:fetch_session, :protect_from_forgery]

      live_dashboard "/dashboard", metrics: GoliathBankWeb.Telemetry
    end
  end
end
