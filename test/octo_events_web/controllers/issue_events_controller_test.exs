defmodule OctoEventsWeb.IssueEventsControllerTest do
  use OctoEventsWeb.ConnCase, async: true

  import OctoEvents.Factory

  describe "list_issues/2" do
    test "should return an empty list when no events are stored", %{conn: conn} do
      response =
        conn
        |> get(Routes.issue_events_path(conn, :list_issues))
        |> json_response(:ok)

      assert [] == response
    end

    test "should return a list containing a issue_id when there is one event for that issue", %{
      conn: conn
    } do
      insert(:issue_event)

      response =
        conn
        |> get(Routes.issue_events_path(conn, :list_issues))
        |> json_response(:ok)

      assert [444_500_041] == response
    end

    test "should not contain duplicated issue_id when more than one event exists", %{conn: conn} do
      insert(:issue_event)
      insert(:issue_event)

      response =
        conn
        |> get(Routes.issue_events_path(conn, :list_issues))
        |> json_response(:ok)

      assert [444_500_041] == response
    end
  end

  describe "list_events/2" do
    test "should return an empty list when no events are stored", %{conn: conn} do
      response =
        conn
        |> get(Routes.issue_events_path(conn, :list_events, "444500041"))
        |> json_response(:ok)

      assert [] == response
    end

    test "should return a list with all events payloads", %{conn: conn} do
      insert(:issue_event)

      response =
        conn
        |> get(Routes.issue_events_path(conn, :list_events, "444500041"))
        |> json_response(:ok)

      assert [%{"action" => "created", "issue" => %{"id" => 444_500_041}}] == response
    end

    test "should return an empty list if there aren't events for given issue_id", %{conn: conn} do
      insert(:issue_event)

      response =
        conn
        |> get(Routes.issue_events_path(conn, :list_events, "123"))
        |> json_response(:ok)

      assert [] == response
    end

    test "should return a bad request when the issue_id is not a number", %{conn: conn} do
      response =
        conn
        |> get(Routes.issue_events_path(conn, :list_events, "abc"))
        |> text_response(:bad_request)

      assert "" == response
    end
  end

  describe "create/2" do
    test "should store an issue event and return status created", %{conn: conn} do
      payload = build(:issue_event_params)

      response =
        conn
        |> post(Routes.issue_events_path(conn, :create, payload))
        |> text_response(:created)

      assert "" == response
    end

    test "should not store an event that isn't issue event", %{conn: conn} do
      payload =
        build(:issue_event_params)
        |> Map.drop(["issue"])

      response =
        conn
        |> post(Routes.issue_events_path(conn, :create, payload))
        |> text_response(:bad_request)

      assert "invalid payload" == response
    end
  end
end
