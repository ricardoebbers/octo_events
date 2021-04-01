defmodule OctoEventsWeb.Router do
  use OctoEventsWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", OctoEventsWeb do
    pipe_through :api

    get "/issues", IssueEventsController, :list_issues
    get "/issues/:issue_id/events", IssueEventsController, :list_events
    post "/payload", IssueEventsController, :create
  end
end
