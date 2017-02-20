defmodule GitlabDashboard.GitlabChannel do
  use Phoenix.Channel

  def join("gitlab:*", _message, socket) do
    {:ok, socket}
  end

  def handle_out("build_update", payload, socket) do
    push socket, "build_update", payload
    {:noreply, socket}
  end

  def handle_out("pipeline_update", payload, socket) do
    push socket, "pipeline_update", payload
    {:noreply, socket}
  end
end
