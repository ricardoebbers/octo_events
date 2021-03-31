defmodule OctoEventsWeb.Router do
  use OctoEventsWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", OctoEventsWeb do
    pipe_through :api
  end

  scope "/payload", OctoEventsWeb do
    post "/", PayloadController, :inspect
  end
end
