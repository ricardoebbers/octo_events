defmodule OctoEventsWeb.IssueEventsController do
  use OctoEventsWeb, :controller

  alias OctoEvents.IssueEvent

  def list_issues(conn, _params) do
    issue_list = OctoEvents.list_issues()
    render(conn, "list.json", issue_list: issue_list)
  end

  def list_events(conn, %{"issue_id" => id}) do
    issue_events = OctoEvents.list_issue_events(id)
    render(conn, "list.json", issue_events: issue_events)
  end

  def create(conn, payload) do
    with {:ok, %IssueEvent{}} <- OctoEvents.create_issue_event(payload) do
      conn
      |> put_status(:created)
      |> text("")
    else
      _ -> handle_invalid_payload(conn, payload)
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
