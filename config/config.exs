# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :discuss,
       ecto_repos: [Discuss.Repo]

# Configures the endpoint
config :discuss,
       DiscussWeb.Endpoint,
       url: [
         host: "localhost"
       ],
       secret_key_base: "kfalsBsBKddnqflwGwBW7TVNwglx6FSKSpFnrJ52jpcRIhN+s8G6XQgxVvPvTLfp",
       render_errors: [
         view: DiscussWeb.ErrorView,
         accepts: ~w(html json)
       ],
       pubsub: [
         name: Discuss.PubSub,
         adapter: Phoenix.PubSub.PG2
       ],
       live_view: [
         signing_salt: "lViOmGXP"
       ]

# Configures Elixir's Logger
config :logger,
       :console,
       format: "$time $metadata[$level] $message\n",
       metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"

# Config of ueberAuth
config :ueberauth,
       Ueberauth,
       providers: [
         github: {Ueberauth.Strategy.Github, [allow_private_emails: true]}
       ]
config :ueberauth,
       Ueberauth.Strategy.Github.OAuth,
       client_id: "725214aca3424ffebcef",
       client_secret: "62f1f7735ba6ad7863fde4fbd11b9e01cb3282cf"