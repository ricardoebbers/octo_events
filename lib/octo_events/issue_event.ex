defmodule OctoEvents.IssueEvent do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  @required_params [:issue_id, :payload]

  schema "issue_events" do
    field :issue_id, :integer
    field :payload, :map

    timestamps()
  end

  def changeset(params) do
    %__MODULE__{}
    |> cast(extract_issue_id(params), @required_params)
    |> validate_required(@required_params)
  end

  defp extract_issue_id(%{"issue" => %{"id" => id}} = payload) do
    %{issue_id: id, payload: payload}
  end

  defp extract_issue_id(payload), do: %{payload: payload}
end
