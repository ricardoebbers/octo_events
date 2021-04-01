defmodule OctoEvents do
  alias OctoEvents.IssueEvents.Create, as: CreateIssueEvent
  alias OctoEvents.IssueEvents.Get, as: GetIssueEvents

  defdelegate create_issue_event(payload), to: CreateIssueEvent, as: :call
  defdelegate list_issue_events(issue_id), to: GetIssueEvents, as: :by_issue_id
  defdelegate list_issues(), to: GetIssueEvents, as: :issue_ids
end
