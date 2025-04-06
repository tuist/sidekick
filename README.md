# Plasma

Plasma is an orchestrator of CI runners for companies building software. It acts as a bridge between Git forges (e.g. [GitHub](https://github.com), [GitLab](https://gitlab.com), [Forgejo](https://forgejo.org/)), and cloud providers (e.g. [AWS](https://aws.amazon.com/), [Azure](https://azure.microsoft.com/en-us/), [GCP](https://cloud.google.com/), [Scaleway](ttps://www.scaleway.com/en/)).

> [!WARNING]
> The project is currently being worked on.

## Instances

### Tuist

You can use the instance hosted by [Tuist](https://tuist.dev) at [plasma.dev](https://plasma.dev) with any of the two following methods:
- **Bring-your-infra:** Plug your own infrastructure into Plasma using your infrastructure keys (e.g. AWS).
- **Use-our-infra:** Use our infrastructure and pay a tax over our infrastructure cost.

### Your own

You can self-host Plasma following our docs, or do a one-click deployment to Render:

[![Deploy to Render](https://render.com/images/deploy-to-render-button.svg)](https://render.com/deploy)

## Development

### Setup

1. Git clone the repo: `git@github.com:tuist/agent.git`.
2. Install dependencies with `mise install`.

### Monorepo

The repository is a monorepo with the following projects:

- [`agent`](./agent): It's a portable Elixir application that runs in the host.
- [`app`](./app): It's an Elixir library (to integrate with another app) along with a Phoenix application to host the web interface.
- [`docs`](./docs): It's a documentation static website available at [docs.plasma.dev](https://docs.plasma.dev).

### Releasing

The project follows [semantic versioning](https://semver.org/) releasing new versions automatically when releasable changes are detected in `main`. The application is pushed to the GitHub registry and the [Hex packages](https://hex.pm/) directory, and the agent published as an artifact in the GitHub release.
