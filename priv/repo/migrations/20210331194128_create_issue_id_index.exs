defmodule OctoEvents.Repo.Migrations.CreateIssueIdIndex do
  use Ecto.Migration

  def change do
    create index("issue_events", [:issue_id], comment: "Index Issue Id")
  end
end
