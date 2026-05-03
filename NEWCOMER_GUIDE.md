# Newcomer Guide: VOL Summit Automation Logic Hub

## What this repository is
This is a lightweight **RCM (Revenue Cycle Management) automation logic starter pack**. It has two core assets:

1. A SQL schema for intake + eligibility integrity.
2. A JSON rule engine for denial recovery actions.

Think of it as a “logic layer” you can wire into a larger healthcare operations stack.

---

## General structure

- `README.md` → mission, branding, and a high-level map of modules.
- `base_camp_schema.sql` → relational data model and one operational reporting view.
- `peak_denial_engine.json` → denial-code to action mappings with urgency tiers.

There is no application runtime in this repo yet (no API service, UI, or orchestration scripts). This is intentional: the repo currently focuses on **business logic artifacts**.

---

## Important things to understand first

### 1) Data model intent (`base_camp_schema.sql`)
- `Patients` stores patient identity basics and created timestamp.
- `InsuranceProviders` stores payer metadata.
- `EligibilityAudits` links patients and payers, then records verification outcomes and patient financial responsibility fields.
- `Intake_Leakage_Report` view surfaces non-verified eligibility events to expose front-end revenue leakage.

Why this matters:
- Eligibility and demographic errors are a major downstream denial source. This schema captures that “front-door quality” checkpoint.

### 2) Denial automation intent (`peak_denial_engine.json`)
- Uses standardized denial codes (`CO-18`, `CO-16`, `PR-1`).
- Each code maps to:
  - reason
  - automated/semiautomated response
  - urgency level
- Includes an explicit 24-hour interception goal.

Why this matters:
- It converts denial handling from ad hoc behavior into deterministic playbooks.

### 3) System boundary (what exists vs. what is missing)
Exists:
- Data definitions
- Operational logic map

Missing (next build layer):
- ETL / ingestion
- Rule execution service
- Task queue/worklist generator
- Outcome tracking dashboard
- Test harness and CI checks

---

## Fast mental model for newcomers

Use this sequence to understand the repo quickly:
1. Start in `README.md` for context.
2. Read SQL tables in dependency order: `Patients` → `InsuranceProviders` → `EligibilityAudits`.
3. Review the `Intake_Leakage_Report` view to understand the primary KPI focus.
4. Read JSON protocols and ask: “what system event should trigger each action?”
5. Sketch how a claim moves from intake verification to denial-resolution workflow.

---

## What to learn next (high-value path)

### Track A — Build automation backbone
1. Add a minimal Python service to load denial rules from JSON.
2. Build a SQL query that identifies new denial events and applies matching protocol.
3. Emit actionable tasks (CSV, queue message, or ticket).

### Track B — Add measurable outcomes
1. Add fields/tables for:
   - denial detected timestamp
   - action executed timestamp
   - recovered amount
   - final status
2. Create KPI views:
   - 24-hour interception rate
   - first-pass resolution rate
   - net collection lift by code

### Track C — Production hardening
1. Add validation tests for SQL schema + JSON rule shape.
2. Add CI pipeline checks (lint + schema checks).
3. Add role-based data access and PHI-safe logging patterns.

---

## Practical onboarding checklist (first 60 minutes)

- [ ] Load schema into a local MySQL-compatible instance.
- [ ] Insert 10 synthetic patients, 3 payers, 15 audit rows.
- [ ] Query `Intake_Leakage_Report` and verify only non-verified rows appear.
- [ ] Parse `peak_denial_engine.json` and print actions by urgency.
- [ ] Write one pseudo-workflow: event → rule lookup → action → status update.

---

## Suggested north-star architecture (simple and scalable)

- **Database**: MySQL/PostgreSQL for intake + audit facts.
- **Rules layer**: JSON-backed engine (later migrate to config service).
- **Automation runtime**: Python worker (cron or queue-triggered).
- **Observability**: KPI SQL views + lightweight BI dashboard.

This keeps cost near zero for prototyping while preserving a migration path to enterprise orchestration.
