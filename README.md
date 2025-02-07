# Sidekick

[![Sidekick](https://github.com/tuist/sidekick/actions/workflows/sidekick.yml/badge.svg)](https://github.com/tuist/sidekick/actions/workflows/sidekick.yml)

Sidekick is an Elixir application (daemon) for the Tuist server to run tasks (e.g. virtualized operation) in other environments.
The server communicates with `sidekick` using the OTP protocol.

## Usage

Add the dependency to your `mix.exs` file:

```elixir
defp deps do
  [
    # Other dependencies
    {:sidekick, git: "https://github.com/tuist/sidekick.git", tag: "0.1", runtime: false}
  ]
end
```

## Development

### Setup

1. Git clone the repo: `git@github.com:tuist/sidekick.git`.
2. Install dependencies with `mise install`.
3. Run the tests with `mix test`
