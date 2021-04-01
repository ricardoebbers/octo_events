defmodule OctoEventsWeb.Router do
  use OctoEventsWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/issues", OctoEventsWeb do
    pipe_through :api
    get "/:issue_id/events", IssueEventsController, :list
  end

  scope "/payload", OctoEventsWeb do
    pipe_through :api

    post "/", PayloadsController, :create
  end
end
