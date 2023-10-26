defmodule GoliathBankWeb.FallbackController do
  use GoliathBankWeb, :controller

  alias GoliathBankWeb.ErrorJSON

  def call(conn, {:error, :not_found}) do
    conn
    |> put_status(:not_found)
    |> put_view(json: ErrorJSON)
    |> render(:error, status: :not_found)
  end

  def call(conn, {:error, :invalid_value_in_amount}) do
    conn
    |> put_status(:bad_request)
    |> put_view(json: ErrorJSON)
    |> render(:error, status: :invalid_value_in_amount)
  end

  def call(conn, {:error, %Ecto.Changeset{} = changeset}) do
    conn
    |> put_status(:bad_request)
    |> put_view(json: ErrorJSON)
    |> render(:error, changeset: changeset)
  end

  def call(conn, {:error, message}) do
    conn
    |> put_status(:bad_request)
    |> put_view(json: ErrorJSON)
    |> render(:error, message: message)
  end
end
