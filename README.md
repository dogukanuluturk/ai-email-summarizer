# AI-Powered Multi-Tenant Email Triage & Digest Workflow

An automated, intelligent email triage, applicant response, and reporting pipeline built with **n8n**, **PostgreSQL**, and an OpenAI-compatible local LLM endpoint (**Qwen 3.6 35B**).

## Features
- **Automated Scheduling:** Executes daily at 10:00 AM (`Europe/Istanbul`) or via custom triggers.
- **Multi-Tenant Architecture:** Iterates over active user configurations in PostgreSQL and routes personalized digests to recipient addresses.
- **AI Categorization & Priority:** Evaluates unread emails, isolates system noise/newsletters, and assigns priorities (**High / Normal / Low**) and action categories (**Reply / Review / Info**).
- **Candidate Application Triage:** Classifies job and internship inquiries (`is_job_application`), parses candidate metadata, and branches them from standard reports.
- **Automated RFC 2822 Auto-Reply:** Dispatches immediate corporate acknowledgment emails directly to applicants within the original message thread.
- **Idempotency & Anti-Loop Engine:** Tracks processed application identifiers in PostgreSQL (`processed_applications`) using `ON CONFLICT DO NOTHING` to prevent duplicate transmissions across recurring runs.
- **Interactive HTML Digest:** Builds styled, responsive HTML digest summaries featuring priority badges and direct deep-links (`"Maili Aç ↗"`).
- **Persistent State Tracking:** Updates user-level `last_processed_at` timestamps upon successful pipeline execution.

## Pipeline Architecture
```text
Schedule Trigger ──► Fetch Active Users (Postgres)
                             │
                     Loop Over Users
                             │
                   Fetch Unread Messages (Gmail)
                             │
                   Basic LLM Chain (Qwen 3.6)
                             │
            ┌────────────────┴────────────────┐
            ▼                                 ▼
   [Application Branch]                [Digest Branch]
            │                                 │
     If Application?                   Format HTML Report
            │                                 │
   Send Auto-Reply (Gmail)             If Mail Count > 0?
            │                                 │
Log to DB (Idempotency Tracking)       Send Digest (SMTP)
                                              │
                                       Update Timestamp (Postgres)
