defmodule OctoEvents.IssueEvents.Create do
  alias OctoEvents.{Repo, IssueEvent}

  def call(params) do
    params
    |> IssueEvent.changeset()
    |> Repo.insert()
  end
end
