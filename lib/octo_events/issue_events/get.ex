defmodule OctoEvents.IssueEvents.Get do
  alias OctoEvents.{Repo, IssueEvent}

  import Ecto.Query, only: [from: 2]

  def by_issue_id(issue_id) do
    Repo.all(from i in IssueEvent, where: i.issue_id == ^issue_id)
  end

  def issue_ids() do
    Repo.all(from i in IssueEvent, distinct: i.issue_id, select: i.issue_id)
  end
end
