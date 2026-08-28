# AI-Powered Multi-Tenant Email Triage & Digest Workflow

An automated, intelligent email triage and reporting pipeline built with **n8n**, **PostgreSQL**, and a local **Qwen 3.6 35B LLM**.

## Features
- **Automated Scheduling:** Runs daily at 10:00 AM (Europe/Istanbul).
- **Multi-Tenant Architecture:** Iterates over active users stored in PostgreSQL and routes personalized reports.
- **AI Categorization & Priority:** Classifies unread messages into Priority (High / Normal / Low) and Sub-Category (Reply / Review / Info).
- **Interactive HTML Digest:** Sends structured HTML digest emails with color-coded badges and direct mailbox access links ("Maili Aç ↗").
- **State Synchronization:** Dynamically tracks and updates `last_processed_at` timestamps per user in PostgreSQL.

## Getting Started
1. Run `schema.sql` in your PostgreSQL instance.
2. In n8n, navigate to **Workflows -> Import from File** and select `workflow.json`.
3. Set up your credentials:
   - **PostgreSQL Account**
   - **OpenAI-Compatible LLM Account** (Local Qwen 3.6 endpoint)
   - **Gmail / SMTP Account**
