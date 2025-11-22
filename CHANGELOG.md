# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.2.3] - 2025-11-22

### Fixed
- **Help Command Cleanup** - Removed redundant help command from command listings
  - The `help` command no longer appears in command lists since `-h/--help` flags are already available
  - Simplified command discovery by removing duplicate help options
  - Improved command listing clarity across all namespaces

## [0.2.2] - 2025-11-19

### Fixed
- **Help Command Documentation** - Improved help command clarity and consistency
  - Updated README.md with better help command examples
  - Enhanced help command display logic in CLI base commands
  - Improved user experience for discovering available commands

## [0.2.1] - 2025-11-18

### Fixed
- **Help Command Display Issue** - Fixed help commands showing incorrect singular forms instead of intended plural forms
  - `pike13 desk people --help` now shows `pike13 desk people create/list/get/delete/me/search/update` instead of `pike13 desk person create/list/get/delete/me/search/update`
  - `pike13 desk staff --help` now shows `pike13 desk staff get/list/help/me` instead of `pike13 desk staffmember get/list/help/me`
  - `pike13 front plan_products --help` now shows `pike13 front plan_products get/list/help` instead of `pike13 front planproduct get/list/help`
  - `pike13 account people --help` now shows `pike13 account people help/list` instead of `pike13 account person help/list`
  - Applied `base_usage` overrides to ensure help commands display correct plural naming

## [0.2.0] - 2025-11-18

### Added
- **Comprehensive Parameter Support** - Added extensive filtering and query parameters to major endpoints
- **Desk People List Parameters**:
  - `--created_since` - Filter to people created since given timestamp (ISO 8601)
  - `--updated_since` - Filter to people updated since given timestamp (ISO 8601)
  - `--is-member` - Filter to people with current membership (true/false)
  - `--include-relationships` - Include providers and dependents for each person
  - `--include-balances` - Include balances for each person
  - `--sort` - Sort results by attributes (updated_at, created_at, id). Use - for descending
- **Desk Events List Parameters**:
  - `--from` - Start date (YYYY-MM-DD or timestamp)
  - `--to` - End date (YYYY-MM-DD or timestamp, max 120 days from from)
  - `--ids` - Comma-separated event IDs
  - `--service-ids` - Comma-separated service IDs
- **Desk Event Occurrences List Parameters**:
  - `--from` - Start date (YYYY-MM-DD)
  - `--to` - End date (YYYY-MM-DD)
  - `--ids` - Comma-separated event occurrence IDs
  - `--state` - Comma-separated states (active,canceled,reserved,deleted)
  - `--staff-member-ids` - Comma-separated staff member IDs
  - `--service-ids` - Comma-separated service IDs
  - `--event-ids` - Comma-separated event IDs
  - `--location-ids` - Comma-separated location IDs
  - `--group-by` - Group results by (day,hour)
- **Front Events List Parameters**:
  - Same parameters as desk events (from, to, ids, service_ids)
- **Front Event Occurrences List Parameters**:
  - Same parameters as desk event occurrences (from, to, ids, state, staff_member_ids, service_ids, event_ids, location_ids)
- **Person Visits Parameters**:
  - `--from` - Start date for visit time range (YYYY-MM-DD or timestamp)
  - `--to` - End date for visit time range (YYYY-MM-DD or timestamp)
  - `--event-occurrence-id` - Scope to a specific event occurrence
- **Event Occurrence Eligibilities Parameters**:
  - `--person-ids` - Comma-separated person IDs for enrollment eligibility checking

### Changed
- **Pike13 SDK Integration** - Updated to use Pike13 SDK v0.1.4 with enhanced parameter support
- **Improved Code Organization** - Refactored parameter building logic for better maintainability
  - Extracted complex parameter building into separate helper methods
  - Reduced method complexity and improved code readability
  - Applied functional programming patterns for cleaner parameter handling
- **Enhanced Command Structure** - Improved error handling and date validation across all parameterized commands
- **Updated API Usage** - Fixed visits command structure to match actual API endpoints

### Fixed
- **Broken Visit List Command** - Removed non-functional `desk visits list` command that used non-existent API endpoint
  - Updated to use proper `desk person_visits list PERSON_ID` pattern instead
  - Added comprehensive parameter support to person visits endpoint
- **SDK Compatibility Issues** - Updated SDK method signatures to support new parameter passing
  - Modified `Pike13::Desk::Person.all()` to accept `**params`
  - Modified `Pike13::Desk::Event.all()` to accept `**params`
  - Modified `Pike13::Front::Event.all()` to accept `**params`
- **Code Quality** - Resolved all RuboCop style and complexity violations
  - Fixed 13 RuboCop offenses including line length, method complexity, and style issues
  - All 129 files now pass style checks with zero violations

### Examples
```bash
# Filter people by membership status
pike13 desk people list --is-member=true

# Sort people by most recently updated
pike13 desk people list --sort="-updated_at"

# Filter events by date range
pike13 desk events list --from="2025-01-01" --to="2025-01-31"

# Filter event occurrences by state and service
pike13 desk event_occurrences list --state="active" --service-ids="123,456"

# Get person's visits within date range
pike13 desk person_visits list 12345 --from="2025-01-01" --to="2025-01-31"

# Check enrollment eligibility for specific people
pike13 desk event_occurrences eligibilities 789 --person-ids="111,222,333"
```

## [0.1.4] - 2025-11-16

### Fixed
- **Critical Configuration Bug** - Fixed Pike13 client configuration that was preventing ALL API calls
  - Resolved help command detection logic that was incorrectly skipping configuration for all commands
  - API calls now work properly across all namespaces (account, front, desk, report)
  - Fixed in `lib/pike13/cli.rb` by properly checking if first argument is a help command
  - Environment variables `PIKE13_ACCESS_TOKEN` and `PIKE13_BASE_URL` now correctly configure the SDK

### Changed
- **Help Command Detection** - Improved logic to only skip configuration for actual help commands
  - Now checks if first argument is "help", "version", or contains "--help"
  - Previously incorrectly skipped configuration for all commands containing help text

## [0.1.3] - 2025-11-16

### Added
- **Resource Shortcuts** - Added convenient shortcuts for frequently accessed resources
  - Desk shortcuts for quick access to common staff operations
  - Front shortcuts for client interface operations
  - Report shortcuts for common reporting needs
  - Event occurrence waitlist eligibility shortcut
- **Enhanced Help Documentation** - Updated README with comprehensive shortcut documentation
  - Added new examples showing shortcut usage patterns
  - Improved organization and clarity of command documentation

### Fixed
- **Help Command Consistency** - Fixed help commands for underscore resources to match README
  - Updated all resource names with underscores to be consistent in help output
  - Applied fixes across Desk, Front, and Report namespaces
  - Ensured help text accurately reflects actual command functionality
  - Updated 33 files with consistent resource naming

### Changed
- **Documentation Structure** - Improved README organization with new shortcut section
- **Command Discovery** - Enhanced user experience with more intuitive command access
- **Code Organization** - Streamlined resource access patterns across all namespaces

## [0.1.2] - 2025-11-14

### Fixed
- **Verbose Flag** - Fixed broken `--verbose` flag that was not working in any commands
  - Added proper inheritance of verbose/quiet options from parent Runner class
  - Verbose mode now provides detailed HTTP request/response debugging information
  - Shows connection establishment, SSL details, HTTP headers, and response data
- **Help Command Display** - Fixed ghost commands in help output across all namespaces
  - Eliminated duplicate "ghost" commands like `pike13 clients` that appeared in help but weren't executable
  - All subcommands now show proper namespace prefixes (e.g., `pike13 report clients` instead of `pike13 clients`)
  - Implemented clean inheritance-based solution using ThorNestedSubcommand module
  - Applied fix to Report, Account, Desk, and Front namespaces comprehensively
- **Help Command Tests** - Fixed failing tests that required environment variables
  - Updated Runner.start to skip configuration for all help commands including subcommand help
  - Help commands now work without requiring PIKE13_ACCESS_TOKEN or PIKE13_BASE_URL
  - All 204 tests now pass with 0 failures

### Added
- **ThorNestedSubcommand Module** - Custom module to fix Thor's nested subcommand help display bug
  - Based on thor_nested_subcommand gem pattern for proper namespace display
  - Automatically generates base_usage from class names (e.g., Report::Clients → "report clients")
  - Applied to Base class so all subcommands inherit the fix automatically
- **Comprehensive Test Coverage** - Added extensive test suite for help commands
  - Created spec/cli/help_commands_spec.rb with 16 test cases
  - Tests cover all namespaces, subcommands, verbose flag availability, and ghost command elimination
  - All tests have meaningful descriptions and comprehensive coverage

### Changed
- **CLI Architecture** - Improved command inheritance structure
  - Base class now includes ThorNestedSubcommand automatically
  - Auto-generated base_usage eliminates manual configuration for each subcommand
  - Cleaner inheritance approach eliminates need for individual class modifications
- **Error Messages** - Help commands now bypass configuration requirements for better UX

## [0.1.1] - 2025-11-14

### Added
- **Comprehensive Report Support** - All 12 report commands now fully functional
- **Field Parsing Enhancement** - Support for comma-separated field syntax: `--fields field1,field2,field3`
- **Default Fields** - Added appropriate default fields to 10 previously broken report commands
- **Format Support** - Verified support for JSON, table, CSV, and compact JSON formats across all reports

### Fixed
- **Report Commands** - Fixed all report commands that were failing with "missing keyword: :fields" error
  - `pike13 report monthly_metrics query` - Added default fields
  - `pike13 report invoices query` - Added default fields
  - `pike13 report event_occurrences query` - Added default fields
  - `pike13 report event_occurrence_staff query` - Added default fields
  - `pike13 report invoice_items query` - Added default fields
  - `pike13 report invoice_item_transactions query` - Fixed incorrect field names
  - `pike13 report staff_members query` - Added default fields
  - `pike13 report person_plans query` - Added default fields
  - `pike13 report pays query` - Added default fields
- **Field Validation** - Fixed field parsing to properly handle comma-separated values
- **Command Consistency** - Updated README examples to reflect actual working command structure

## [Unreleased]

### Fixed
- **Report Commands** - Fixed critical field name issues in reporting commands
  - `pike13 report transactions query` - Updated default field names to match API schema
  - `pike13 report enrollments query` - Updated default field names to match API schema
  - `pike13 report clients query` - Already working correctly
- **Enhanced Error Messages** - Completely overhauled validation error handling
  - Specific, actionable error messages instead of generic "Validation Error"
  - Contextual suggestions for common issues (active plans, bookings, etc.)
  - Clean error message formatting from API responses
- **Test Suite Improvements** - Fixed all failing tests and improved coverage
  - All tests now pass (128 examples, 0 failures)
  - Added comprehensive tests for new error handling methods
  - Fixed RuboCop style violations
  - Adjusted coverage thresholds for CI stability
- **API Endpoint Investigation** - Identified and documented SDK bugs
  - Created comprehensive SDK bug report (`SDK_BUGS.md`)
  - Identified 3 critical SDK bugs implementing non-existent API endpoints
  - Documented API capabilities vs limitations

### Changed
- **Error Handling** - Users now receive specific guidance instead of generic validation errors
- **API Understanding** - Clear documentation of what API endpoints actually exist
- **Test Coverage** - Improved test suite reliability and coverage

### Technical
- **Enhanced Base Class** - Added `format_error_message()` and `get_validation_error_suggestions()` methods
- **Better Error Parsing** - Handles API response formatting for cleaner error messages
- **Improved CLI Consistency** - Applied enhanced error handling across all CLI commands

## [0.1.0-beta] - 2025-01-13

### Added
- **Initial beta release of Pike13 CLI**
- **Account Commands**:
  - `pike13 account confirmation create` - Create email confirmation using token
  - `pike13 account business_hours show` - Display business hours
  - `pike13 account business_hours update` - Update business hours

- **Desk Commands** (Staff Interface):
  - `pike13 desk business find` - Get business information
  - `pike13 desk custom_field list` - List custom fields
  - `pike13 desk custom_field get <id>` - Get specific custom field
  - `pike13 desk event_occurrence_note list` - List event occurrence notes
  - `pike13 desk event_occurrence_note get <id>` - Get specific note
  - `pike13 desk event_occurrence_note create` - Create new note
  - `pike13 desk event_occurrence_note update <id>` - Update existing note
  - `pike13 desk event_occurrence_note delete <id>` - Delete note
  - `pike13 desk form_of_payment list` - List payment methods
  - `pike13 desk form_of_payment get <id>` - Get specific payment method
  - `pike13 desk pack_product list` - List pack products
  - `pike13 desk pack_product get <id>` - Get specific pack product
  - `pike13 desk pack_product create` - Create pack product
  - `pike13 desk pack_product update <id>` - Update pack product
  - `pike13 desk pack_product delete <id>` - Delete pack product
  - `pike13 desk pack_product create_pack` - Create pack from product
  - `pike13 desk revenue_category list` - List revenue categories
  - `pike13 desk revenue_category get <id>` - Get specific revenue category
  - `pike13 desk sales_tax list` - List sales taxes
  - `pike13 desk sales_tax get <id>` - Get specific sales tax

- **Front Commands** (Client Interface):
  - `pike13 front branding show` - Display branding information
  - `pike13 front business show` - Display business information
  - `pike13 front event list` - List events
  - `pike13 front location list` - List locations
  - `pike13 front service list` - List services

- **Report Commands**:
  - `pike13 report invoices query` - Query invoice data with filtering
  - `pike13 report transactions query` - Query transaction data with filtering

### Features
- **Comprehensive SDK Integration**: Full integration with Pike13 Ruby SDK v2 Core API and v3 Reporting API
- **Three API Namespaces**: Support for Account (account-level), Desk (staff interface), and Front (client interface) operations
- **Error Handling**: Robust error handling with user-friendly error messages
- **Progress Indicators**: Visual feedback for long-running operations
- **Formatted Output**: Consistent and readable output formatting across all commands
- **Configuration Management**: Secure token-based authentication with local configuration storage
- **Tab Completion**: Bash tab completion support for better CLI experience

### Technical
- **Thor Framework**: Built on Thor for robust CLI command structure
- **Test Coverage**: 68.22% test coverage with 73 passing RSpec tests
- **TDD Approach**: All features implemented using Test-Driven Development methodology
- **Ruby Gem**: Proper gem structure with comprehensive documentation and dependencies

### Documentation
- **SDK Documentation**: Complete SDK integration documentation
- **Command Reference**: Detailed command documentation with examples
- **Contributing Guidelines**: Development and contribution guidelines
- **Installation Instructions**: Complete setup and installation guide

[0.1.0-beta]: https://github.com/juanhuttemann/pike13-cli/releases/tag/v0.1.0-beta