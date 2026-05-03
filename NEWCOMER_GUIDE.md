# Newcomer Guide and Mobile Setup Playbook

## 1) Objective
Get a new contributor productive in under 60 minutes and prevent accidental branch deletion by setting a safe GitHub ruleset from mobile.

---

## 2) Step by step execution

### A) Understand what this repo contains
This repository is a logic first RCM automation starter with two assets:

1. base_camp_schema.sql for intake and eligibility data model.
2. peak_denial_engine.json for denial code response playbooks.

There is no API or UI service yet. This repository is currently a rules and data foundation.

### B) Learn the architecture in the right order

#### Step 1 - SQL data foundation
Read base_camp_schema.sql in this sequence:
- Patients
- InsuranceProviders
- EligibilityAudits
- Intake_Leakage_Report view

Why this order works:
- It follows relationship flow from patient intake to payer mapping to eligibility outcomes to leakage reporting.

#### Step 2 - Denial automation logic
Read peak_denial_engine.json and map each code to operations:
- CO-18 for duplicate claim recovery pathway
- CO-16 for missing information remediation pathway
- PR-1 for patient responsibility pathway

#### Step 3 - Translate to workflow
Use this trigger chain:
1. Intake event stored in SQL.
2. Eligibility issue flagged by view.
3. Denial event matched to JSON rule.
4. Action task generated as work queue or ticket.
5. Outcome logged for KPI reporting.

### C) Mobile GitHub ruleset setup
Use this minimal configuration to protect key branches quickly.

#### Step 1 - Ruleset name
Use one of these names:
- protect-main-v1
- protect-production-v1

#### Step 2 - Enforcement status
- Start with Active if ready now.
- If testing first, set Disabled, save, then switch to Active after validation.

#### Step 3 - Target branches
Tap Add target and set one pattern:
- main

Optional second ruleset for release branches:
- release/*

#### Step 4 - Turn on these branch rules
Enable:
- Restrict deletions
- Require pull request before merging
- Require approvals with minimum 1
- Require status checks to pass if CI exists

Leave off for now to reduce friction on early stage repos:
- Require signed commits
- Require deployments to succeed

#### Step 5 - Bypass list
Keep bypass list empty unless strictly needed.
If needed, add only owner or admin account.

#### Step 6 - Save and test
1. Save ruleset.
2. Open a test branch and verify you can still create pull requests.
3. Confirm direct delete or push to main is blocked.

---

## 3) Tools (free only)
- GitHub mobile web or app for rulesets and pull request workflow
- MySQL Community or PostgreSQL free tier
- Python 3 for rule runner prototype
- GitHub Actions free tier for basic checks
- Metabase OSS optional for KPI dashboard

---

## 4) Copy paste output

### A) Branch protection profile
```md
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
```

### B) 60 minute onboarding checklist
```md
- [ ] Read README.md for mission and modules
- [ ] Load base_camp_schema.sql into local DB
- [ ] Seed sample Patients, InsuranceProviders, EligibilityAudits rows
- [ ] Run Intake_Leakage_Report and verify non Verified records only
- [ ] Parse peak_denial_engine.json and map urgency to queue priority
- [ ] Create one pseudo automation flow: event to rule to task to KPI
- [ ] Configure protect-main-v1 ruleset on GitHub
```

### C) Next build sprint with income generating focus
```md
Sprint Goal: reduce denial rework time and improve collection speed
1) Build Python worker to load JSON rules
2) Query new eligibility and denial events every 15 minutes
3) Auto create action tasks by urgency
4) Track 24 hour interception KPI
5) Publish weekly savings report with hours recovered and dollars recovered
```

---

## 5) Expected result
- New contributors understand architecture and system boundaries quickly.
- Main branch is protected against accidental deletion and unsafe updates.
- Team has a direct path from static logic files to scalable automation with measurable revenue cycle impact.
