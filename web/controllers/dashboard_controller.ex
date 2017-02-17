defmodule GitlabDashboard.DashboardController do
  use GitlabDashboard.Web, :controller

  def index(conn, _params) do
    projects_with_builds = GitlabRepository.get_projects()
      |> Enum.map(&GitlabRepository.get_builds_for_project/1)
      |> Enum.filter(fn project -> length(project.builds) > 0 end)

    render conn, "index.html", projects_with_builds: projects_with_builds
  end
end
