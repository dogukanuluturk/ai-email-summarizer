-- Multi-Tenant User Configuration Table
CREATE TABLE IF NOT EXISTS user_email_configs (
    id SERIAL PRIMARY KEY,
    user_name VARCHAR(100) NOT NULL,
    imap_host VARCHAR(255) NOT NULL,
    imap_port INT DEFAULT 993,
    imap_user VARCHAR(255) NOT NULL,
    imap_password VARCHAR(255) NOT NULL,
    report_recipient_email VARCHAR(255) NOT NULL,
    last_processed_at TIMESTAMP WITH TIME ZONE DEFAULT (NOW() - INTERVAL '24 HOURS'),
    is_active BOOLEAN DEFAULT TRUE
);

-- Processed Emails Audit Log Table
CREATE TABLE IF NOT EXISTS processed_emails (
    id SERIAL PRIMARY KEY,
    user_id INT REFERENCES user_email_configs(id) ON DELETE CASCADE,
    email_message_id VARCHAR(255) NOT NULL,
    subject TEXT,
    priority VARCHAR(50),
    action VARCHAR(50),
    processed_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    CONSTRAINT unique_user_email UNIQUE (user_id, email_message_id)
);

-- Candidate Job/Internship Applications Idempotency Tracking Table
CREATE TABLE IF NOT EXISTS processed_applications (
    id SERIAL PRIMARY KEY,
    message_id VARCHAR(255) UNIQUE NOT NULL,
    applicant_email VARCHAR(255) NOT NULL,
    replied_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Example Inserts
INSERT INTO user_email_configs (user_name, imap_host, imap_user, imap_password, report_recipient_email)
VALUES ('Demo User', 'imap.gmail.com', 'user@example.com', 'your-app-password', 'user@example.com');
