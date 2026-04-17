# Renovate

## Table of Contents

- [Renovate](#renovate)
  - [Table of Contents](#table-of-contents)
  - [Introduction](#introduction)
  - [Configuration](#configuration)
  - [Getting Started](#getting-started)

## Introduction

Here are some guidelines on how to run Renovate locally

## Configuration

- [config:best-practices](https://docs.renovatebot.com/presets-config/#configbest-practices) - preset with best practices from the renovate maintainers recommended for advanced users who want to follow our best practices.
  - [config:recommended](https://docs.renovatebot.com/presets-config/#configrecommended) - recommended configuration for most users, it does not matter what programming language you use.
    - [:dependencyDashboard](https://docs.renovatebot.com/presets-default/#dependencydashboard) - enable renovate Dependency Dashboard creation.
    - [:semanticPrefixFixDepsChoreOthers](https://docs.renovatebot.com/presets-default/#semanticprefixfixdepschoreothers) - use semantic commit type fix for dependencies and chore for all others if semantic commits are in use.
    - [:ignoreModulesAndTests](https://docs.renovatebot.com/presets-default/#ignoremodulesandtests) - ignore node_modules bower_components vendor and various test/tests (except for nuget) directories.
    - [group:monorepos](https://docs.renovatebot.com/presets-group/#groupmonorepos) - group known monorepo packages together.
    - [group:recommended](https://docs.renovatebot.com/presets-group/#grouprecommended) - use curated list of recommended non-monorepo package groupings.
    - [mergeConfidence:age-confidence-badges](https://docs.renovatebot.com/presets-mergeConfidence/#mergeconfidenceage-confidence-badges) - show only the Age and Confidence Merge Confidence badges for pull requests.
    - [replacements:all](https://docs.renovatebot.com/presets-replacements/#replacementsall) - apply crowd-sourced package replacement rules.
    - [workarounds:all](https://docs.renovatebot.com/presets-workarounds/#workaroundsall) - apply crowd-sourced workarounds for known problems with packages.
    - [helpers:githubDigestChangelogs](https://docs.renovatebot.com/presets-helpers/#helpersgithubdigestchangelogs) - ensure that every dependency pinned by digest and sourced from GitHub.com contains a link to the commit-to-commit diff
    - [helpers:goXPackagesChangelogLink](https://docs.renovatebot.com/presets-helpers/#helpersgoxpackageschangeloglink) - correctly link to the source code for golang.org/x packages.
    - [helpers:goXPackagesNameLink](https://docs.renovatebot.com/presets-helpers/#helpersgoxpackagesnamelink) - link to pkg.go.dev/... for golang.org/x packages' title.
  - [docker:pinDigests](https://docs.renovatebot.com/presets-docker/#dockerpindigests) - pin Docker digests.
  - [helpers:pinGitHubActionDigests](https://docs.renovatebot.com/presets-helpers/#helperspingithubactiondigeststosemver) - convert pinned GitHub Action digests to SemVer.
  - [:configMigration](https://docs.renovatebot.com/presets-default/#configmigration) - enable renovate configuration migration PRs when needed.
  - [:pinDevDependencies](https://docs.renovatebot.com/presets-default/#pindevdependencies) - pin dependency versions for development dependencies.
  - [abandonments:recommended](https://docs.renovatebot.com/presets-abandonments/#abandonmentsrecommended) - recommended configuration for abandoned packages, treating packages without a release for 1 year as abandoned, while taking into account community-sourced overrides.
  - [security:minimumReleaseAgeNpm](https://docs.renovatebot.com/presets-security/#securityminimumreleaseagenpm) - Wait until the npm package is three days old before raising the update. This a) introduces a short delay to allow for malware researchers and scanners to (possibly) detect any malicious behaviour in packages, and b) prevents the maintainer and/or NPM from unpublishing a package you already upgraded to, breaking builds.
  - [:maintainLockFilesWeekly](https://docs.renovatebot.com/presets-default/#maintainlockfilesweekly) - run lock file maintenance (updates) early Monday mornings.
- [:semanticCommitTypeAll(arg0)](https://docs.renovatebot.com/presets-default/#semanticcommittypeallarg0) - if renovate detects semantic commits it will use semantic commit type arg0 for all commits.

## Getting Started

Go to the root directory of the repository you want to analyze and run the commands below:

```bash
export LOG_FORMAT=json
export LOG_LEVEL=debug
export RENOVATE_CONFIG_FILE=~/.config/renovate/config.json
export RENOVATE_TOKEN=dummy
renovate --dry-run=full --platform=local 2>&1 | jq -r 'select(.msg | test("vuln|CVE|GHSA"; "i")) | [.time, .msg] | @tsv'
```
