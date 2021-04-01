defmodule OctoEventsWeb.IssueEventsController do
  use OctoEventsWeb, :controller

  alias OctoEvents.IssueEvent

  def list_issues(conn, _params) do
    issue_list = OctoEvents.list_issues()
    render(conn, "list.json", issue_list: issue_list)
  end

  def list_events(conn, %{"issue_id" => id}) do
    with {id_int, _rest} <- Integer.parse(id),
         issue_events <- OctoEvents.list_issue_events(id_int) do
      render(conn, "list.json", issue_events: issue_events)
    else
      _ ->
        conn
        |> put_status(:bad_request)
        |> text("")
    end
  end

  def create(conn, payload) do
    case OctoEvents.create_issue_event(payload) do
      {:ok, %IssueEvent{}} ->
        conn
        |> put_status(:created)
        |> text("")

      _ ->
        handle_invalid_payload(conn, payload)
    end
  end

  # If it is the ping payload, should return an 200 OK,
  # so github knows that the webhook endpoint is valid
  defp handle_invalid_payload(conn, %{"zen" => _zen}) do
    conn
    |> put_status(:ok)
    |> text("")
  end

  defp handle_invalid_payload(conn, _payload) do
    conn
    |> put_status(:bad_request)
    |> text("invalid payload")
  end
end
