defmodule OctoEvents.Repo.Migrations.CreateIssueEvents do
  use Ecto.Migration

  def change do
    create table(:issue_events, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :issue_id, :integer
      add :payload, :map

      timestamps()
    end
  end
end
