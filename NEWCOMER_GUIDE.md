# Newcomer Guide

## 1) Objective
Set up GitHub CLI on Linux or BSD quickly, verify installation security, and enable contributors to use branch protection and pull request workflows in this repository.

## 2) Step by step execution

Step 1: Choose your install path
- Recommended: official GitHub CLI packages from cli.github.com.
- Community paths are available but are not maintained by the GitHub CLI team.

Step 2: Verify signing keys before install
- Confirm key fingerprints match:
  - 2C6106201985B60E6C7AC87323F3D4EA75716059
  - 7F38BBB59D064DBCB3D84D725612B36462313325

Step 3: Install GitHub CLI on your platform
- Debian and Ubuntu: use official apt repository from cli.github.com.
- RPM systems: use gh-cli repo for dnf5, dnf4, yum, or zypper.
- BSD: use native package manager such as pkg, pkgin, or pkg_add depending on system.

Step 4: Verify installation and auth
- Run gh --version.
- Run gh auth login.
- Run gh repo view to confirm repository access.

Step 5: Use GitHub CLI in this repo
- Create branch: gh repo clone or git checkout -b feature branch.
- Push changes and open PR: gh pr create.
- Review checks and merge through pull request workflow.

Step 6: Apply main branch ruleset
- Use the ruleset block below.
- Confirm direct delete or push to main is blocked.

## 3) Tools (free only)
- GitHub CLI from official packages
- GitHub web or mobile app
- Git
- Bash shell

## 4) Copy paste output

Debian or Ubuntu install:
```bash
(type -p wget >/dev/null || (sudo apt update && sudo apt install wget -y)) \
&& sudo mkdir -p -m 755 /etc/apt/keyrings \
&& out=$(mktemp) && wget -nv -O$out https://cli.github.com/packages/githubcli-archive-keyring.gpg \
&& cat $out | sudo tee /etc/apt/keyrings/githubcli-archive-keyring.gpg > /dev/null \
&& sudo chmod go+r /etc/apt/keyrings/githubcli-archive-keyring.gpg \
&& sudo mkdir -p -m 755 /etc/apt/sources.list.d \
&& echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
&& sudo apt update \
&& sudo apt install gh -y
```

Key verification command:
```bash
curl -fsSL -o - https://cli.github.com/packages/githubcli-archive-keyring.gpg | gpg --show-keys
```

Post install checks:
```bash
gh --version
gh auth login
gh repo view
```

Ruleset Name: protect-main-v1
Enforcement: Active
Target Branches: main
Rules:
- Restrict deletions: ON
- Require pull request: ON
- Required approvals: 1
- Require status checks: ON if CI exists
- Require signed commits: OFF
- Require deployments: OFF
Bypass list: none

## 5) Expected result
- GitHub CLI is installed with official packages.
- Contributor access is validated through gh auth.
- Main branch is protected with minimal safe rules.
- Team can create pull requests faster and scale collaboration safely.
