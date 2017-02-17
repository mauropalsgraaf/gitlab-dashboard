defmodule GitlabRepository do
  def get_projects do
    %HTTPotion.Response{"body": response} = HTTPotion.get("#{gitlab_api_host()}/projects", [headers: headers()])

    Poison.decode! response, as: [%Project{}]
  end

  def get_builds_for_project(project) do
    %HTTPotion.Response{"body": response} = HTTPotion.get("#{gitlab_api_host()}/projects/#{project.id}/builds", [headers: headers()])
    builds = Poison.decode! response, as: [%Builds{}]

    master_build_per_project = master_build_per_project(builds)

    %{:project => project, :builds => master_build_per_project}
  end

  defp headers do
     ["PRIVATE-TOKEN": gitlab_api_token(), "content-type": "application/json"]
  end

  defp latest_build_per_branch(builds) do
      Enum.group_by(builds, fn branch -> branch.ref end)
      |> Enum.map(fn {k, v} ->
        {k, List.first(v)}
      end)
  end

  defp master_build_per_project(builds) do
    builds
      |> Enum.filter(fn build -> build.ref == "master" end)
  end

  defp gitlab_api_token() do
    {k, v} = List.first(Application.get_env(:gitlab_dashboard, :environment, :gitlab_api_token))
    v
  end

  defp gitlab_api_host() do
    {k, v} = List.last(Application.get_env(:gitlab_dashboard, :environment, :gitlab_api_host))
    
    v
  end
end
