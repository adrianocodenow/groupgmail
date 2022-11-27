#!/bin/bash
sqlite3 todos.sqlite <<EOF
.mode csv
.import Users.csv emails

CREATE TABLE IF NOT EXISTS "emails"(
    "First Name [Required]" TEXT, 
    "Last Name [Required]" TEXT, 
    "Email Address [Required]" TEXT, 
    "Status [READ ONLY]" TEXT,
    "Last Sign In [READ ONLY]" TEXT, 
    "Email Usage [READ ONLY]" TEXT);

CREATE TABLE IF NOT EXISTS "todos" (
    "Group Email [Required]" TEXT,
    "Member Email" TEXT,
    "Member Type" TEXT,
    "Member Role" TEXT,
    "Member Name" TEXT);

INSERT INTO todos (
    "Member Email", 
    "Member Name")
    SELECT 
        "Email Address [Required]", 
        ("First Name [Required]" || " " || "Last Name [Required]") 
    FROM 
        emails
    WHERE
        "Last Name [Required]" <> "exemplo";

INSERT INTO todos (
    "Member Email", 
    "Member Name")
    SELECT 
        "Email Address [Required]", 
        "First Name [Required]"
    FROM 
        emails
    WHERE
        "Last Name [Required]" = "exemplo";

DELETE FROM todos
WHERE
    "Member Email" = "admin@exemplo.com" OR
    "Member Email" = "atendimento@exemplo.com" OR
    "Member Email" = "exemplo.shop@exemplo.com" OR
    "Member Email" = "cadastro@exemplo.com" OR
    "Member Email" = "drop.box@exemplo.com" OR
    "Member Email" = "intranet@exemplo.com" OR
    "Member Email" = "zoom@exemplo.com";

UPDATE todos SET
    "Group Email [Required]" = "todos@exemplo.com",
    "Member Type" = "USER",
    "Member Role" = "MEMBER";

UPDATE todos SET 
    "Member Role" = "OWNER"
WHERE 
    "Member Email" = "amptec@exemplo.com";

UPDATE todos SET 
    "Member Role" = "MANAGER"
WHERE 
    "Member Email" = "aline.souza@exemplo.com" OR
    "Member Email" = "felipe.aguiar@exemplo.com" OR
    "Member Email" = "rh@exemplo.com";

.headers on
.mode csv
.output todos.csv
SELECT * FROM todos ORDER BY "Member Email";
EOF

