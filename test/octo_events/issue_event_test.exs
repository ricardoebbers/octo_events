defmodule OctoEvents.IssueEventTest do
  use OctoEvents.DataCase, async: true

  import OctoEvents.Factory

  alias OctoEvents.IssueEvent
  alias Ecto.Changeset

  describe "changeset/1" do
    test "should require an issue id from payload" do
      params = build(:issue_event_params)

      response = IssueEvent.changeset(params)
      assert %Changeset{changes: %{issue_id: 444_500_041}, valid?: true} = response
    end

    test "should return an error if payload doesn't contains an issue" do
      params =
        build(:issue_event_params)
        |> Map.drop(["issue"])

      response = IssueEvent.changeset(params)
      expected_response = %{issue_id: ["can't be blank"]}

      assert errors_on(response) == expected_response
    end
  end
end
