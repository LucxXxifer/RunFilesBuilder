# OECT RunFiles Production Scaffold

This fork packages only reviewed, whitelisted artifacts for OpenWrt/iStoreOS.

The active workflows are:

- `oect-runfiles-dry-run-release.yml`: publishes scaffold metadata, whitelist, installer, and safety notes.
- `oect-build-store-run.yml`: downloads the current whitelisted iStore Store packages from `repo.istoreos.com`, records exact URLs and sha256, packages them with `makeself`, and publishes a prerelease.

Upstream workflows have been moved to `.github/workflows-disabled/` so this fork does not expose a generic third-party plugin market by default.

## Safety Boundary

Public releases must not contain:

- Tailscale identity, auth key, or `tailscaled.state`
- ShellCrash subscription, profile, or CrashCore runtime
- Lucky certificate, token, domain, or private reverse-proxy rules
- root password hash
- SSH private keys

The installer refuses to run outside OpenWrt/iStoreOS 24.10.x with `opkg`.

## Update Rule

Upstream updates are not auto-promoted. Rebuilds are manual and each release records exact source URLs and sha256 values.
