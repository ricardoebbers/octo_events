defmodule OctoEventsWeb.IssueEventsController do
  use OctoEventsWeb, :controller

  def list_issues(conn, _params) do
    issue_list = OctoEvents.list_issues()
    render(conn, "list.json", issue_list: issue_list)
  end

  def list_events(conn, %{"issue_id" => id}) do
    issue_events = OctoEvents.list_issue_events(id)
    render(conn, "list.json", issue_events: issue_events)
  end
end
