import Config

config :plasma_agent, :version, System.get_env("PLASMA_AGENT_VERSION", "not-found")
