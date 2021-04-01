defmodule OctoEventsWeb.IssueEventsView do
  use OctoEventsWeb, :view

  def render("list.json", %{issue_list: issue_list}), do: issue_list

  def render("list.json", %{issue_events: issue_events}) do
    issue_events
    |> Enum.map(fn event -> render("issue_event.json", event) end)
  end

  def render("issue_event.json", %{payload: payload}), do: payload
end
