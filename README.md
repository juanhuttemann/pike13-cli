# Pike13 CLI

[![CI](https://github.com/juanhuttemann/pike13-cli/actions/workflows/ci.yml/badge.svg)](https://github.com/juanhuttemann/pike13-cli/actions/workflows/ci.yml)

A command-line interface for interacting with the Pike13 API, supporting both:
- **[Core API](https://developer.pike13.com/docs/api/v2)** - CRUD operations for managing people, events, invoices, and more
- **[Reporting API](https://developer.pike13.com/docs/reporting/v3)** - Advanced analytics and reporting queries

## Installation

```bash
gem install pike13-cli
```

## Configuration

Set the following environment variables:

```bash
export PIKE13_ACCESS_TOKEN="your_access_token"
export PIKE13_BASE_URL="yourbusiness.pike13.com"
```

### Shell Completion (Optional)

The CLI includes tab completion support for bash and zsh.

**Bash:**
```bash
# Copy the completion script
sudo cp completions/pike13.bash /etc/bash_completion.d/pike13

# Or source it in your ~/.bashrc
echo 'source /path/to/pike13-cli/completions/pike13.bash' >> ~/.bashrc
source ~/.bashrc
```

**Zsh:**
```bash
# Create completion directory if it doesn't exist
mkdir -p ~/.zsh/completion

# Copy the completion script
cp completions/_pike13 ~/.zsh/completion/

# Add to ~/.zshrc (if not already present)
echo 'fpath=(~/.zsh/completion $fpath)' >> ~/.zshrc
echo 'autoload -U compinit && compinit' >> ~/.zshrc
source ~/.zshrc
```

## Usage

### Command Structure

```bash
pike13 <namespace> <resource> <action> [options]
```

**Namespaces:**
- `desk` - Staff interface (full read/write access)
- `front` - Client interface (limited access for customer-facing apps)
- `account` - Account-level operations (not scoped to business)
- `report` - Reporting API (analytics and insights)

### Account Namespace

Account-level operations (not scoped to a business subdomain):

```bash
# Get current account
pike13 account me

# List all businesses
pike13 account businesses

# List all people across businesses
pike13 account people

# Request password reset
pike13 account password-reset --email "user@example.com"

# Create email confirmation
pike13 account confirmation create --token "confirmation_token"

# Get business hours
pike13 account business-hours show

# Update business hours
pike13 account business-hours update --monday "9:00-17:00" --tuesday "9:00-17:00"
```

### Desk Namespace (Staff Interface)

Full staff interface with read/write access:

#### People

```bash
# List all people
pike13 desk people list

# Find a person
pike13 desk people get 123

# Search for people
pike13 desk people search "John Doe"

# Get current authenticated user
pike13 desk people me

# Create a person
pike13 desk people create --first-name "John" --last-name "Doe" --email "john@example.com"

# Update a person
pike13 desk people update 123 --first-name "Jane"

# Delete a person
pike13 desk people delete 123
```

#### Business

```bash
# Get business details
pike13 desk business find
```

#### Events & Event Occurrences

```bash
# List events
pike13 desk events list

# Get an event
pike13 desk events get 100

# List event occurrences
pike13 desk event_occurrences list --from "2025-01-01" --to "2025-01-31"

# Get event occurrence
pike13 desk event_occurrences get 789

# Get enrollment eligibilities
pike13 desk event_occurrences eligibilities 789
```

#### Event Occurrence Notes

```bash
# List notes for an event occurrence
pike13 desk event_occurrence_notes list --event-occurrence-id 789

# Get specific note
pike13 desk event_occurrence_notes get 1 --event-occurrence-id 789

# Create note
pike13 desk event_occurrence_notes create \
  --event-occurrence-id 789 \
  --subject "Note Subject" \
  --note "This is a note"

# Update note
pike13 desk event_occurrence_notes update 1 \
  --event-occurrence-id 789 \
  --note "Updated note content"

# Delete note
pike13 desk event_occurrence_notes delete 1 --event-occurrence-id 789
```

#### Bookings

```bash
# Get booking
pike13 desk bookings get 123

# Create booking (requires idempotency token)
pike13 desk bookings create --event-occurrence-id 789 --person-id 123

# Update booking
pike13 desk bookings update 456 --state "completed"

# Delete booking
pike13 desk bookings delete 456
```

#### Appointments

```bash
# Find available slots
pike13 desk appointments available --service-id 100 --date "2025-01-15"

# Get availability summary
pike13 desk appointments summary --service-id 100 --from "2025-01-01" --to "2025-01-31"
```

#### Invoices & Payments

```bash
# List invoices
pike13 desk invoices list

# Get invoice
pike13 desk invoices get 700

# Get payment
pike13 desk payments get 800

# Void payment
pike13 desk payments void 800 --invoice-item-ids "1,2"
```

#### Pack Products

```bash
# List pack products
pike13 desk pack_products list

# Get specific pack product
pike13 desk pack_products get 123

# Create pack product
pike13 desk pack_products create \
  --name "10 Class Pack" \
  --price "200.00" \
  --visit-count 10

# Update pack product
pike13 desk pack_products update 123 --name "Updated Pack Name"

# Delete pack product
pike13 desk pack_products delete 123

# Create pack from product
pike13 desk pack_products create_pack \
  --product-id 123 \
  --person-id 456 \
  --quantity 5
```

#### Other Resources

```bash
# Locations
pike13 desk locations list
pike13 desk locations get 1

# Services
pike13 desk services list
pike13 desk services get 100

# Staff members
pike13 desk staff list
pike13 desk staff get 5
pike13 desk staff me

# Visits
pike13 desk visits list
pike13 desk visits get 456

# Plans
pike13 desk plans list
pike13 desk plans get 200

# Notes
pike13 desk notes list 123
pike13 desk notes get 123 456
pike13 desk notes create 123 --subject "Follow up" --note "Client requested callback"
pike13 desk notes update 123 456 --note "Updated note content"
pike13 desk notes delete 123 456

# Custom Fields
pike13 desk custom_fields list
pike13 desk custom_fields get 185003

# Forms of Payment
pike13 desk forms_of_payment list 123
pike13 desk forms_of_payment get 123 456
pike13 desk forms_of_payment create 123 --type "creditcard" --token "tok_xxx"
pike13 desk forms_of_payment update 123 456 --is-default
pike13 desk forms_of_payment delete 123 456

# Revenue Categories
pike13 desk revenue_categories list
pike13 desk revenue_categories get 138248

# Sales Taxes
pike13 desk sales_taxes list
pike13 desk sales_taxes get 1

# Make-Ups
pike13 desk make_ups reasons
pike13 desk make_ups generate 456 --make-up-reason-id 126989 --free-form-reason "Client was sick"

# Waitlist
pike13 desk waitlist list
pike13 desk waitlist get 789
pike13 desk waitlist create --person-id 123 --event-id 100
pike13 desk waitlist delete 789

# Person-related resources
pike13 desk person_visits list 123
pike13 desk person_plans list 123
pike13 desk person_waitlist list 123
pike13 desk person_waivers list 123
```

### Front Namespace (Client Interface)

Client-facing interface with limited read-only access:

```bash
# Get authenticated client user (only)
pike13 front people me

# List events (client view)
pike13 front events list

# List locations (client view)
pike13 front locations list

# List services (client view)
pike13 front services list

# Get business info
pike13 front business show

# Get branding
pike13 front branding show

# Find available appointment slots (client view)
pike13 front appointments available \
  --service-id 100 \
  --date "2025-01-15"

# Bookings (client view)
pike13 front bookings get 456
pike13 front bookings create --event-occurrence-id 789 --person-id 123
pike13 front bookings update 456 --state "completed"
pike13 front bookings delete 456

# Person-related resources (client view)
pike13 front person_visits list 123
pike13 front person_plans list 123
pike13 front person_waitlist list 123
pike13 front person_waivers list 123

# Forms of payment (client view)
pike13 front forms_of_payment list 123
pike13 front forms_of_payment get 123 456
pike13 front forms_of_payment find_me 456
pike13 front forms_of_payment create 123 --type "creditcard" --token "tok_xxx"
pike13 front forms_of_payment update 123 456 --is-default
pike13 front forms_of_payment delete 123 456
```

### Report Namespace (Reporting API)

Advanced analytics and reporting:

```bash
# Monthly business metrics
pike13 report monthly_metrics query \
  --fields month_start_date,net_paid_amount,member_count

# Clients report
pike13 report clients query \
  --fields full_name,email,completed_visits,has_membership

# Transactions
pike13 report transactions query \
  --fields transaction_date,net_paid_amount,payment_method,invoice_payer_name

# Invoices
pike13 report invoices query \
  --fields invoice_number,expected_amount,outstanding_amount,invoice_state

# Enrollments (visits)
pike13 report enrollments query \
  --fields full_name,service_name,service_date,state

# Event occurrences
pike13 report event_occurrences query \
  --fields event_name,service_date,enrollment_count,capacity

# Event occurrence staff members
pike13 report event_occurrence_staff query \
  --fields full_name,event_name,service_date,enrollment_count

# Invoice items
pike13 report invoice_items query \
  --fields product_name,expected_amount,net_paid_amount

# Invoice item transactions
pike13 report invoice_item_transactions query \
  --fields transaction_date,payment_method,net_paid_amount

# Pays (staff compensation)
pike13 report pays query \
  --fields staff_name,service_name,final_pay_amount,pay_state

# Person plans
pike13 report person_plans query \
  --fields full_name,plan_name,start_date,is_available

# Staff members
pike13 report staff_members query \
  --fields full_name,email,role,tenure
```

### Report Options

```bash
# Filtering (use hash format - note: advanced filters may require API-specific syntax)
pike13 report clients query --filter has_membership:true
pike13 report transactions query --filter payment_method:cash

# Grouping
pike13 report clients query --group tenure_group
pike13 report transactions query --group payment_method

# Sorting (comma-separated fields, append - for descending)
pike13 report clients query --sort completed_visits-
pike13 report transactions query --sort transaction_date

# Pagination (use hash format)
pike13 report clients query --page size:50 --page number:2
pike13 report clients query --page size:100

# Include total count
pike13 report clients query --total-count

# Combine multiple options
pike13 report clients query \
  --fields full_name,email,completed_visits \
  --filter has_membership:true \
  --sort completed_visits- \
  --page size:50 \
  --total-count
```

### Output Formats

```bash
# JSON output (default, pretty-printed)
pike13 desk people list

# Compact JSON
pike13 desk people list --compact

# Table output
pike13 desk people list --format table

# Table with color
pike13 desk people list --format table --color

# CSV output
pike13 report clients query --format csv

# Show progress indicator (useful for long-running reports)
pike13 report clients query --progress --format table
```

### Common Options

```bash
# Help for any command
pike13 help
pike13 desk help
pike13 desk people help
pike13 report help

# Verbose output (show HTTP requests and detailed debugging)
pike13 desk people list --verbose

# Quiet mode (suppress all output except errors)
pike13 desk people list --quiet

# Verbose mode with error details (useful for troubleshooting)
pike13 desk people get 999999 --verbose  # Shows full error trace

# Show version information
pike13 version
```

## Examples

### Staff Workflow Examples

```bash
# Find a client and view their details
pike13 desk people search "John Smith"

# Check upcoming classes
pike13 desk event_occurrences list \
  --from "$(date +%Y-%m-%d)" \
  --to "$(date -d '+7 days' +%Y-%m-%d)"

# Create a booking for a client
pike13 desk bookings create \
  --event-occurrence-id 789 \
  --person-id 123

# View client's visit history
pike13 desk visits list --person-id 123
```

### Client-Facing Examples

```bash
# View available classes (client view)
pike13 front events list

# Find available appointment slots
pike13 front appointments available \
  --service-id 100 \
  --date "2025-01-15"

# Get my profile (as client)
pike13 front people me
```

### Reporting Examples

```bash
# Monthly revenue summary
pike13 report monthly_metrics query \
  --fields month_start_date,net_paid_amount,member_count,new_client_count \
  --format table

# Active members report
pike13 report clients query \
  --fields full_name,email,tenure,completed_visits \
  --filter has_membership=true \
  --sort completed_visits- \
  --format csv > active_members.csv

# Payment method breakdown
pike13 report transactions query \
  --fields total_net_paid_amount,transaction_count \
  --group payment_method

# Class attendance report
pike13 report enrollments query \
  --fields service_name,completed_enrollment_count,noshowed_enrollment_count \
  --group service_name
```

### Shell Integration

```bash
# Chain commands
CLIENT_ID=$(pike13 desk people search "John" --compact | jq -r '.people[0].id')
pike13 desk visits list --person-id $CLIENT_ID

# Export reports
pike13 report clients query \
  --fields full_name,email,phone,completed_visits \
  --format csv > clients_$(date +%Y%m%d).csv

# Monitor daily signups
watch -n 300 "pike13 report clients query \
  --fields full_name,email,client_since_date \
  --format table"
```

## Tips and Tricks

### Command Aliases

Many list commands support the `ls` alias:
```bash
pike13 desk people ls
pike13 desk locations ls
pike13 desk events ls
```

### Colored Output

Enable colored tables for better readability:
```bash
pike13 desk people list --format table --color
```

### Date Validation

Date parameters are validated automatically:
```bash
# ✗ Invalid - will show error
pike13 desk event_occurrences list --from "2025-11"

# ✓ Valid - YYYY-MM-DD format
pike13 desk event_occurrences list --from "2025-11-01"
```

### Check Configuration

Use the version command to verify your environment:
```bash
pike13 version
# Shows: CLI version, SDK version, Ruby version, and env status
```

### Progress Indicators

Show a spinner for long-running report queries:
```bash
pike13 report clients query --progress --format table
pike13 report transactions query --progress --format table
```
Note: Progress indicators only appear in TTY mode and are automatically disabled when piping.

### Piping and Redirection

Colors and progress indicators are automatically disabled when piping:
```bash
# Save to file
pike13 report clients query --fields full_name,email --format csv > clients.csv

# Pipe to other commands
pike13 desk people list --format json | jq '.people[0]'
```

## Troubleshooting

### Environment Variables Not Set

```bash
# Error: PIKE13_ACCESS_TOKEN environment variable is required

# Solution: Set required environment variables
export PIKE13_ACCESS_TOKEN="your_access_token"
export PIKE13_BASE_URL="yourbusiness.pike13.com"

# Verify they're set
echo $PIKE13_ACCESS_TOKEN
echo $PIKE13_BASE_URL

# Or add to your shell profile for persistence
echo 'export PIKE13_ACCESS_TOKEN="your_token"' >> ~/.bashrc
echo 'export PIKE13_BASE_URL="yourbusiness.pike13.com"' >> ~/.bashrc
```

### API Errors

The CLI provides detailed error messages with helpful suggestions:

**Resource not found (404)**
```bash
pike13 desk people get 999999
# Not Found: The requested resource does not exist
#
# Suggestions:
#   1. Verify the resource ID is correct
#   2. Check if the resource has been deleted
#   3. Ensure you have permission to access this resource

# Use --verbose for more details
pike13 desk people get 999999 --verbose
```

**Authentication errors (401)**
```bash
pike13 desk people list
# Authentication Error: Invalid or expired access token
#
# Suggestions:
#   1. Verify your PIKE13_ACCESS_TOKEN environment variable is set correctly
#   2. Check if your access token has expired
#   3. Generate a new access token from your Pike13 account settings
#
# Current token: eyJhbGciO...
```

**Validation errors (422)**
```bash
pike13 desk people create --first-name "John"
# Validation Error: The request contains invalid data
#
# Details: email is required, last_name is required
#
# Suggestions:
#   1. Check that all required fields are provided
#   2. Verify field formats (dates, emails, etc.)
#   3. Review the Pike13 API documentation for field requirements
```

**Rate limit errors (429)**
```bash
# Rate Limit Exceeded: Too many requests
#
# Rate limit will reset at: 2025-11-13T01:00:00Z
#
# Suggestions:
#   1. Wait a few minutes before retrying
#   2. Reduce the frequency of your requests
#   3. Consider batching operations when possible
```

**Server errors (5xx)**
```bash
# Server Error: Pike13 API is experiencing issues
#
# HTTP Status: 503
#
# Suggestions:
#   1. Wait a few minutes and try again
#   2. Check Pike13 status page for service updates
#   3. Contact Pike13 support if the issue persists
```

**Connection errors**
```bash
# Connection Error: Unable to connect to Pike13 API
#
# Error: Connection refused
#
# Suggestions:
#   1. Check your internet connection
#   2. Verify PIKE13_BASE_URL is set correctly: yourbusiness.pike13.com
#   3. Check if a firewall is blocking the connection
#   4. Verify the Pike13 service is available
```

### Command Not Found

```bash
# pike13: command not found

# Solution: Ensure gem is installed and in PATH
gem install pike13-cli

# Check if gem bin directory is in PATH
gem environment

# Add to PATH if needed
export PATH="$PATH:$(gem environment gemdir)/bin"
```

### Date Format Errors

```bash
# Error: Invalid date format for 'from'. Expected YYYY-MM-DD

# Solution: Use correct date format
pike13 desk event_occurrences list --from "2025-01-01" --to "2025-01-31"

# Not: --from "01/01/2025" or --from "2025-01"
```

### Reporting Filter Syntax

```bash
# For hash options, use key:value format
pike13 report clients query --filter has_membership:true

# For multiple filters or complex conditions, consult Pike13 API documentation
# The CLI supports basic hash filters; advanced filters may require API-specific array syntax
```

### Large Result Sets

```bash
# For large reports, use pagination
pike13 report clients query --page size:100 --page number:1

# Or save directly to file
pike13 report clients query --format csv > clients.csv
```

### Getting Help

```bash
# View help for any command
pike13 help
pike13 desk help
pike13 desk people help

# Check your environment
pike13 version

# List all available commands
pike13 help | grep -A 100 "Commands:"
```

## Development

```bash
# Clone the repository
git clone https://github.com/juanhuttemann/pike13-cli.git
cd pike13-cli

# Install dependencies
bundle install

# Build and install locally
gem build pike13-cli.gemspec
gem install pike13-cli-0.1.0.beta.gem

# Test the CLI
pike13 help

# Run tests
bundle exec rspec

# Run rake tasks
rake console     # Open IRB with pike13-cli loaded
rake install_local  # Build and install locally
rake clean       # Remove build artifacts
```

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines on how to contribute to this project.

## License

[MIT License](LICENSE.txt)
