## Plasma

**Plasma** aims to simplify the orchestration of containerized environments—ideal for use cases like hosted runners on Git forges such as [GitHub](https://github.com), [GitLab](https://gitlab.com), or [Forgejo](https://forgejo.org). It can scale and provision environments either manually or automatically, using strategies tailored to your CI workloads and demands.

## Motivation

While building features for [Tuist](https://tuist.dev), we realized the need for a fast and cost-effective way to spin up macOS and Linux containers. Unfortunately, this kind of innovation has historically been locked away behind traditional CI providers, who’ve treated it as part of their competitive moat.

We believe this space should be **commoditized**. Lowering the time and cost of remote execution unlocks better developer experiences—faster feedback loops, cheaper experimentation, and greater flexibility.

**Plasma** is our step toward making that a reality.

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
