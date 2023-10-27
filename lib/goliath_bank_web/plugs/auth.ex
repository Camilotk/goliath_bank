defmodule GoliathBankWeb.Plugs.Auth do
  import Plug.Conn

  alias Phoenix.Controller

  def init(opts), do: opts

  def call(conn, _opts) do
    with ["Bearer " <> token] <- get_req_header(conn, "authorization"),
    {:ok, data} <- GoliathBankWeb.Token.verify(token) do
      assign(conn, :user_id, data)
    else
      _error ->
        conn
        |> put_status(:unauthorized)
        |> Controller.put_view(json: GoliathBankWeb.ErrorJSON)
        |> Controller.render(:error, status: :unauthorized)
        |> halt()
    end
  end
end
