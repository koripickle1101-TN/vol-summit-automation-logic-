# Newcomer Guide

## 1) Objective
Create a simple onboarding system for this repository that helps a new contributor start quickly, protect the main branch, and begin building an automation workflow.

## 2) Step by step execution

Step 1: Understand the repository assets
- Read README.md for mission and modules.
- Use base_camp_schema.sql as the intake and eligibility data model.
- Use peak_denial_engine.json as the denial action rule map.

Step 2: Configure branch protection first
- Create one GitHub ruleset for main.
- Set enforcement to Active.
- Turn on only the minimum required rules listed below.

Step 3: Run the 60 minute onboarding checklist
- Load schema to local database.
- Seed sample rows.
- Run leakage report and confirm expected output.
- Map denial urgency to queue priority.

Step 4: Build a sprint 1 automation prototype
- Build a Python worker that reads JSON rules.
- Poll new eligibility and denial events every 15 minutes.
- Create action tasks automatically and track KPI outcomes.

Step 5: Resolve the 4 common ruleset issues
- Issue 1: No target branch configured. Fix by setting Target Branches to main.
- Issue 2: Pull request requirement missing. Fix by turning on Require pull request.
- Issue 3: Approval count not set. Fix by setting Required approvals to 1.
- Issue 4: Deletion protection off. Fix by turning on Restrict deletions.

## 3) Tools (free only)
- GitHub web or mobile app
- MySQL Community or PostgreSQL
- Python 3
- GitHub Actions free tier
- Metabase OSS

## 4) Copy paste output

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

- [ ] Read README.md for mission and modules
- [ ] Load base_camp_schema.sql into local DB
- [ ] Seed sample Patients, InsuranceProviders, EligibilityAudits rows
- [ ] Run Intake_Leakage_Report and verify non verified records only
- [ ] Parse peak_denial_engine.json and map urgency to queue priority
- [ ] Create one pseudo automation flow: event to rule to task to KPI
- [ ] Configure protect-main-v1 ruleset on GitHub

Sprint Goal: reduce denial rework time and improve collection speed
1) Build Python worker to load JSON rules
2) Query new eligibility and denial events every 15 minutes
3) Auto create action tasks by urgency
4) Track 24 hour interception KPI
5) Publish weekly savings report with hours recovered and dollars recovered

## 5) Expected result
- Main branch protection is active and accidental deletions are blocked.
- New contributors can onboard in about 60 minutes.
- Team has a direct path from static logic files to scalable automation and measurable revenue cycle impact.
