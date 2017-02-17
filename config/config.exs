# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :gitlab_dashboard,
  ecto_repos: [GitlabDashboard.Repo]

# Configures the endpoint
config :gitlab_dashboard, GitlabDashboard.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "01c50+w+pqk5LjWI90cgUwx+4RIrDFj08A2u0EfXkMnqHO50VqL0HVrmzdsuZg6I",
  render_errors: [view: GitlabDashboard.ErrorView, accepts: ~w(html json)],
  pubsub: [name: GitlabDashboard.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :gitlab_dashboard, :environment,
  gitlab_api_token: System.get_env("GITLAB_API_TOKEN"),
  gitlab_api_host: System.get_env("GITLAB_API_HOST")

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
