# frozen_string_literal: true

module Pike13
  module CLI
    # Simple progress indicator for long-running operations
    class Progress
      SPINNER_FRAMES = ["⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏"].freeze

      def initialize(message = "Loading", enabled: true)
        @message = message
        @enabled = enabled && $stdout.tty?
        @frame_index = 0
        @thread = nil
      end

      # Start the spinner
      def start
        return unless @enabled

        @thread = Thread.new do
          loop do
            print "\r#{SPINNER_FRAMES[@frame_index]} #{@message}..."
            @frame_index = (@frame_index + 1) % SPINNER_FRAMES.length
            sleep 0.1
          end
        end
      end

      # Stop the spinner and clear the line
      def stop(final_message = nil)
        return unless @enabled

        @thread&.kill
        print "\r#{' ' * (@message.length + 10)}\r" # Clear the line
        puts final_message if final_message
      end

      # Run a block with progress indication
      def self.run(message = "Loading", enabled: true)
        progress = new(message, enabled: enabled)
        progress.start

        begin
          result = yield
          progress.stop
          result
        rescue StandardError => e
          progress.stop
          raise e
        end
      end

      # Simple progress bar for known iterations
      class Bar
        def initialize(total, width: 40, enabled: true)
          @total = total
          @current = 0
          @width = width
          @enabled = enabled && $stdout.tty?
        end

        def increment(message = nil)
          return unless @enabled

          @current += 1
          percentage = (@current.to_f / @total * 100).round
          filled = (@current.to_f / @total * @width).round
          bar = ("█" * filled) + ("░" * (@width - filled))

          suffix = message ? " - #{message}" : ""
          print "\r[#{bar}] #{percentage}%#{suffix}"
          print "\n" if @current >= @total
        end

        def finish(message = "Complete")
          return unless @enabled

          @current = @total
          bar = "█" * @width
          print "\r[#{bar}] 100% - #{message}\n"
        end
      end
    end
  end
end
