# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

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