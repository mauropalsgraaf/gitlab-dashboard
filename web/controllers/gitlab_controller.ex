defmodule GitlabDashboard.GitlabController do
  use GitlabDashboard.Web, :controller

  def event(conn, params = %{"object_kind" => "pipeline", "commit" => %{"id" => commit_hash}}) do
    GitlabDashboard.Endpoint.broadcast("gitlab:" <> commit_hash, "pipeline_update", params)

    conn
      |> send_resp(:ok, "")
  end

  def event(conn, params = %{"object_kind" => "build", "commit" => %{"sha" => commit_hash}}) do
    GitlabDashboard.Endpoint.broadcast("gitlab:" <> commit_hash, "build_update", params)

    conn
      |> send_resp(:ok, "")
  end
end
