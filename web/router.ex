defmodule GitlabDashboard.Router do
  use GitlabDashboard.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    # plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", GitlabDashboard do
    pipe_through :browser # Use the default browser stack

    get "/", DashboardController, :index

  end

  scope "/api", GitlabDashboard do
    pipe_through :api

    post "/event", GitlabController, :event
  end
end
