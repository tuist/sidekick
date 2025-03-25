import Config

config :sidekick, :version, System.get_env("SIDEKICK_VERSION", "not-found")
