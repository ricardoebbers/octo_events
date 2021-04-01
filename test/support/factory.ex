defmodule OctoEvents.Factory do
  use ExMachina

  def issue_event_params_factory() do
    %{
      "issue" => %{
        "id" => 123_123,
        "other_key" => "other_value"
      },
      "other_map" => %{
        "other_key" => "other_value"
      }
    }
  end
end
