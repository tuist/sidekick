<div align="center">
  <img width="200px" src="/assets/logo.png" alt="Logo">
  <h1>Your Heading Text</h1>
</div>

[![Sidekick](https://github.com/tuist/sidekick/actions/workflows/sidekick.yml/badge.svg)](https://github.com/tuist/sidekick/actions/workflows/sidekick.yml)

Sidekick is an Elixir application (daemon) for the Tuist server to run tasks (e.g. virtualized operation) in other environments.
The server communicates with `sidekick` using the OTP protocol.

## Usage

Sidekick is a combination of a daemon/agent that runs in hosts and that another Elixir application (e.g. a web server) can communicate with to run tasks in a different environment,
and a library that provides the API to communicate with the agent.

### Run the agent

Sidekick distributes the agent as a portable binary built using [Burrito](https://github.com/burrito-elixir/burrito).
Every release includes the agent binary for macOS and Linux. You can install them using [Ubi](https://github.com/houseabsolute/ubi):

```bash
ubi -t 0.1.9 -p tuist/sidekick
bin/sidekick
```

### Integrate the library

To integrate Sidekick as a library, add the dependency to your `mix.exs` file:

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
