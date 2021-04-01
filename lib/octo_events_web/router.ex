defmodule OctoEventsWeb.Router do
  use OctoEventsWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/issues", OctoEventsWeb do
    pipe_through :api
    get "/", IssueEventsController, :list_issues
    get "/:issue_id/events", IssueEventsController, :list_events
  end

  scope "/payload", OctoEventsWeb do
    pipe_through :api

    post "/", PayloadsController, :create
  end
end
