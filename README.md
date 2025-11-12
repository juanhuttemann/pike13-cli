# Pike13 CLI

A command-line interface for interacting with the Pike13 API.

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

#### Events & Event Occurrences

```bash
# List events
pike13 desk events list

# Get an event
pike13 desk events get 100

# List event occurrences
pike13 desk event_occurrences list --from "2024-01-01" --to "2024-01-31"

# Get event occurrence
pike13 desk event_occurrences get 789

# Get enrollment eligibilities
pike13 desk event_occurrences eligibilities 789
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
pike13 desk appointments available --service-id 100 --date "2024-01-15"

# Get availability summary
pike13 desk appointments summary --service-id 100 --from "2024-01-01" --to "2024-01-31"
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
pike13 desk notes list --person-id 123
pike13 desk notes create --person-id 123 --subject "Note" --note "Content"
```

### Front Namespace (Client Interface)

Client-facing interface with limited read-only access:

```bash
# Get authenticated client user (only)
pike13 front people me

# List events (client view)
pike13 front events list

# Get event occurrences (client view)
pike13 front event_occurrences list --from "2024-01-01" --to "2024-01-31"

# Get business info
pike13 front business

# Get branding
pike13 front branding

# List locations (client view)
pike13 front locations list

# List services (client view)
pike13 front services list

# Find available appointment slots
pike13 front appointments available --service-id 100 --date "2024-01-15"

# Create booking (client)
pike13 front bookings create --event-occurrence-id 789 --person-id 123

# List visits
pike13 front visits list
```

### Report Namespace (Reporting API)

Advanced analytics and reporting:

```bash
# Monthly business metrics
pike13 report monthly_metrics \
  --fields "month_start_date,net_paid_amount,member_count" \
  --from "2024-01-01"

# Clients report
pike13 report clients \
  --fields "full_name,email,completed_visits,has_membership" \
  --filter "has_membership=true"

# Transactions
pike13 report transactions \
  --fields "transaction_date,net_paid_amount,payment_method,invoice_payer_name" \
  --from "2024-01-01" \
  --to "2024-12-31"

# Invoices
pike13 report invoices \
  --fields "invoice_number,expected_amount,outstanding_amount,invoice_state"

# Enrollments (visits)
pike13 report enrollments \
  --fields "full_name,service_name,service_date,state" \
  --filter "state=completed"

# Event occurrences
pike13 report event_occurrences \
  --fields "event_name,service_date,enrollment_count,capacity"

# Event occurrence staff members
pike13 report event_occurrence_staff \
  --fields "full_name,event_name,service_date,enrollment_count"

# Invoice items
pike13 report invoice_items \
  --fields "product_name,expected_amount,net_paid_amount"

# Invoice item transactions
pike13 report invoice_item_transactions \
  --fields "transaction_date,payment_method,net_paid_amount"

# Pays (staff compensation)
pike13 report pays \
  --fields "staff_name,service_name,final_pay_amount,pay_state"

# Person plans
pike13 report person_plans \
  --fields "full_name,plan_name,start_date,is_available"

# Staff members
pike13 report staff_members \
  --fields "full_name,email,role,tenure"
```

### Report Options

```bash
# Filtering
pike13 report clients --filter "has_membership=true"
pike13 report transactions --filter "payment_method=creditcard"

# Grouping
pike13 report clients --group-by "tenure_group"
pike13 report transactions --group-by "payment_method"

# Sorting
pike13 report clients --sort "completed_visits-"  # descending
pike13 report transactions --sort "transaction_date+"  # ascending

# Pagination
pike13 report clients --limit 50
pike13 report clients --page 2

# Date ranges
pike13 report transactions --from "2024-01-01" --to "2024-12-31"
```

### Output Formats

```bash
# JSON output (default, pretty-printed)
pike13 desk people list

# Compact JSON
pike13 desk people list --compact

# Table output
pike13 desk people list --format table

# CSV output
pike13 report clients --fields "full_name,email" --format csv
```

### Common Options

```bash
# Help for any command
pike13 help
pike13 desk help
pike13 desk people help
pike13 report help

# Verbose output (show HTTP requests)
pike13 desk people list --verbose

# Quiet mode (errors only)
pike13 desk people list --quiet
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
pike13 front event_occurrences list \
  --from "2024-01-15" \
  --to "2024-01-22"

# Find available appointment slots
pike13 front appointments available \
  --service-id 100 \
  --date "2024-01-15"

# Get my profile (as client)
pike13 front people me
```

### Reporting Examples

```bash
# Monthly revenue summary
pike13 report monthly_metrics \
  --fields "month_start_date,net_paid_amount,member_count,new_client_count" \
  --from "2024-01-01" \
  --format table

# Active members report
pike13 report clients \
  --fields "full_name,email,tenure,completed_visits" \
  --filter "has_membership=true" \
  --sort "completed_visits-" \
  --format csv > active_members.csv

# Payment method breakdown
pike13 report transactions \
  --fields "total_net_paid_amount,transaction_count" \
  --group-by "payment_method" \
  --from "2024-01-01"

# Class attendance report
pike13 report enrollments \
  --fields "service_name,completed_enrollment_count,noshowed_enrollment_count" \
  --group-by "service_name" \
  --filter "state=completed"
```

### Shell Integration

```bash
# Chain commands
CLIENT_ID=$(pike13 desk people search "John" --compact | jq -r '.people[0].id')
pike13 desk visits summary --person-id $CLIENT_ID

# Export reports
pike13 report clients \
  --fields "full_name,email,phone,completed_visits" \
  --format csv > clients_$(date +%Y%m%d).csv

# Monitor daily signups
watch -n 300 "pike13 report clients \
  --filter 'client_since_date=$(date +%Y-%m-%d)' \
  --format table"
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
gem install pike13-cli-0.1.0.gem

# Test the CLI
pike13 help
```

## License

MIT
