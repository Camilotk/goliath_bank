defmodule GoliathBankWeb.FallbackController do
  use GoliathBankWeb, :controller

  alias GoliathBankWeb.ErrorJSON

  def call(conn, {:error, changeset}) do
    conn
    |> put_status(:bad_request)
    |> put_view(json: ErrorJSON)
    |> render(:error, changeset: changeset)
  end
end
