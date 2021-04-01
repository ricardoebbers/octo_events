defmodule OctoEvents do

  alias OctoEvents.IssueEvents.Create, as: CreateIssueEvent
  alias OctoEvents.IssueEvents.ListAll, as: ListAllIssueEvents

  defdelegate create_issue_event(payload), to: CreateIssueEvent, as: :call
  #defdelegate list_all_issue_events(issue_id), to: ListAllIssueEvents, as: :call
end
