# OECT RunFilesBuilder

This fork is a private production scaffold for reviewed OpenWrt/iStoreOS `.run` artifacts.

Upstream attribution is preserved in `LICENSE` and git history. This fork does not claim to be the upstream project.

## Active Scope

The active workflows are:

- `.github/workflows/oect-runfiles-dry-run-release.yml`
- `.github/workflows/oect-build-store-run.yml`

All inherited upstream workflows have been moved to `.github/workflows-disabled/` so they cannot be run from the GitHub Actions UI by accident.

## Whitelist

The default whitelist is in `oect/whitelist.txt`:

- `luci-app-store`
- `luci-lib-taskd`
- `luci-lib-xterm`
- `taskd`

Other plugins must be added intentionally with source and sha256 review. Do not use third-party DailyBuild releases as a trusted baseline.

## Security Boundary

Public releases must not contain:

- Tailscale identity, auth key, or `tailscaled.state`
- ShellCrash subscription, profile, or CrashCore runtime
- Lucky certificate, token, domain, or private reverse-proxy rules
- root password hash
- SSH private keys

The installer must run inside OpenWrt/iStoreOS, not on the fnOS host.
