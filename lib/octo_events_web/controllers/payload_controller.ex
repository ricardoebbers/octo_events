defmodule OctoEventsWeb.PayloadController do
  use OctoEventsWeb, :controller

  def inspect(conn, _params) do
    conn
    |> IO.inspect()
    |> json(conn.body_params)
  end
end
