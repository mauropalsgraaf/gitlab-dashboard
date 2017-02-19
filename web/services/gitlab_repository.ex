defmodule GitlabRepository do
  def get_projects do
    %HTTPotion.Response{"body": response} = HTTPotion.get("#{gitlab_api_host()}/projects", [headers: headers(), timeout: 10000])

    Poison.decode! response, as: [%Project{}]
  end

  def get_builds_for_project(project) do
    %HTTPotion.Response{"body": response} = HTTPotion.get("#{gitlab_api_host()}/projects/#{project.id}/builds", [headers: headers(), timeout: 10000])
    builds = Poison.decode! response, as: [%Builds{}]

    master_build_per_project = master_build_per_project(builds)

    %{:project => project, :builds => master_build_per_project}
  end

  defp headers do
     ["PRIVATE-TOKEN": gitlab_api_token(), "content-type": "application/json"]
  end

  defp master_build_per_project(builds) do
    builds
      |> Enum.filter(fn build -> build.ref == "master" end)
  end

  defp gitlab_api_token() do
    {_, api_token} = List.first(Application.get_env(:gitlab_dashboard, :environment, :gitlab_api_token))
    case api_token do
      Nil -> raise "Environment variable GITLAB_API_TOKEN not set"
      _ -> api_token
    end
  end

  defp gitlab_api_host() do
    {_, api_host} = List.last(Application.get_env(:gitlab_dashboard, :environment, :gitlab_api_host))
    case api_host do
      Nil -> raise "Environment variable GITLAB_API_HOST not set"
      _ -> api_host
    end
  end
end
