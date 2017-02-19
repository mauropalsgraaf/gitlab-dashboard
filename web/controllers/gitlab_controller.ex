defmodule GitlabDashboard.GitlabController do
  use GitlabDashboard.Web, :controller

  def event(conn, %{"object_kind": "pipeline", "builds": _builds}) do
    render conn, "index.html"
  end

  def event(conn, %{"object_kind": "build"}) do
    render conn, "index.html"
  end
end
