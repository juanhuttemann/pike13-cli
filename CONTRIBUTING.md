# Contributing to Pike13 CLI

Thank you for your interest in contributing to pike13-cli!

## Development Setup

1. Clone the repository:
```bash
git clone https://github.com/juanhuttemann/pike13-cli.git
cd pike13-cli
```

2. Install dependencies:
```bash
bundle install
```

3. Set up your environment variables:
```bash
export PIKE13_ACCESS_TOKEN="your_test_token"
export PIKE13_BASE_URL="yourtest.pike13.com"
```

4. Run the CLI locally:
```bash
./bin/pike13 help
```

## Project Structure

```
pike13-cli/
├── bin/
│   └── pike13           # Executable entry point
├── lib/
│   └── pike13/
│       └── cli/
│           ├── cli.rb   # Main CLI runner
│           ├── config.rb         # Configuration
│           ├── formatter.rb      # Output formatting
│           ├── version.rb        # Version info
│           └── commands/         # Command implementations
│               ├── base.rb       # Base command class
│               ├── desk/         # Desk namespace commands
│               ├── front/        # Front namespace commands
│               ├── account/      # Account namespace commands
│               └── report.rb     # Reporting commands
└── spec/                # Tests (TBD)
```

## Adding a New Command

1. Create or edit the appropriate command file in `lib/pike13/cli/commands/`
2. Add `format_options` before each command method to enable formatting
3. Use `handle_error` to wrap API calls
4. Use `output(data)` to format and display results

Example:
```ruby
desc "new_command ID", "Description of command"
format_options
def new_command(id)
  handle_error do
    result = Pike13::Desk::Resource.find(id)
    output(result)
  end
end
```

## Code Style

- Follow Ruby community style guidelines
- Use `frozen_string_literal: true` at the top of each file
- Add YARD documentation for public methods
- Keep methods focused and single-purpose

## Testing

Before submitting a PR:

1. Test your changes manually with real API calls
2. Verify all output formats work (JSON, table, CSV)
3. Check that error handling works correctly
4. Update TODO.md with testing status

## Pull Request Process

1. Create a feature branch: `git checkout -b feature/your-feature-name`
2. Make your changes and test thoroughly
3. Update CHANGELOG.md with your changes
4. Update README.md if adding new commands
5. Submit a PR with a clear description of changes

## Questions?

Open an issue on GitHub if you have questions or need help!
