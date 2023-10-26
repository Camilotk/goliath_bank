defmodule GoliathBank.Transactions.Search do
  alias GoliathBank.Repo
  alias GoliathBank.Transactions.Transaction
  import Ecto.Query

  def call(%{"start_date" => start_date, "end_date" => end_date}) do
    with {:ok, start_dt} <- parse_date(start_date, "T00:00:00Z"),
         {:ok, end_dt} <- parse_date(end_date, "T23:59:59Z") do
      query =
        Transaction
        |> where([t], fragment("? BETWEEN ? AND ?", t.inserted_at, ^start_dt, ^end_dt))
        |> preload([:sender, :receiver])

      Repo.all(query)
    else
      _ -> {:error, :invalid_date}
    end
  end

  def call(_), do: {:error, :invalid}

  defp parse_date(date, time_suffix) do
    date = if String.length(date) == 10, do: date <> time_suffix, else: date

    case DateTime.from_iso8601(date) do
      {:ok, dt, _} -> {:ok, DateTime.to_naive(dt)}
      error -> error
    end
  end
end
