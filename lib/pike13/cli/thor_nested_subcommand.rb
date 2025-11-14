# frozen_string_literal: true

# Fix for Thor nested subcommand help display bug
# Based on https://github.com/gangelo/thor_nested_subcommand
module Pike13
  module CLI
    # This module fixes a bug in Thor that prohibits help for nested
    # subcommands from displaying help properly. Nested subcommands fail
    # to display their subcommand ancestor command name. This fixes that
    # bug.
    module ThorNestedSubcommand
      class << self
        def included(base)
          base.extend ClassMethods
        end
      end

      module ClassMethods
        def base_usage
          raise NotImplementedError, "#{name} must implement .base_usage method"
        end

        # Don't override desc - just fix the banner for proper display
        # The banner override handles the display correctly

        # Thor override
        # rubocop:disable Lint/UnusedMethodArgument
        # rubocop:disable Style/OptionalBooleanParameter
        def banner(command, namespace = nil, subcommand = false)
          "#{basename} #{base_usage} #{command.usage}"
        end
        # rubocop:enable Lint/UnusedMethodArgument
        # rubocop:enable Style/OptionalBooleanParameter
      end
    end
  end
end
