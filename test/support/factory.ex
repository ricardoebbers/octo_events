defmodule OctoEvents.Factory do
  use ExMachina.Ecto, repo: OctoEvents.Repo

  alias OctoEvents.IssueEvent

  def issue_event_factory() do
    %IssueEvent{
      issue_id: 444_500_041,
      payload: %{
        "action" => "created",
        "issue" => %{
          "id" => 444_500_041
        }
      }
    }
  end

  def issue_event_params_factory() do
    %{
      "action" => "created",
      "issue" => %{
        "id" => 444_500_041,
      }
    }
  end
end
