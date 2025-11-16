# frozen_string_literal: true

module Pike13
  module CLI
    module Commands
      class Desk < Base
        class EventOccurrenceNote < Base
          # Override base_usage to match the actual subcommand registration
          def self.base_usage
            "desk event_occurrence_notes"
          end
          desc "list EVENT_OCCURRENCE_ID", "List notes for an event occurrence"
          format_options
          def list(event_occurrence_id)
            handle_error do
              result = with_progress("Fetching event occurrence notes") do
                Pike13::Desk::EventOccurrenceNote.all(event_occurrence_id: event_occurrence_id)
              end
              output(result)
            end
          end

          desc "get EVENT_OCCURRENCE_ID ID", "Get a specific note for an event occurrence"
          format_options
          def get(event_occurrence_id, id)
            handle_error do
              result = Pike13::Desk::EventOccurrenceNote.find(event_occurrence_id: event_occurrence_id, id: id)
              output(result)
            end
          end

          desc "create EVENT_OCCURRENCE_ID", "Create a note for an event occurrence"
          format_options
          option :note, type: :string, required: true, desc: "Note content"
          option :subject, type: :string, required: true, desc: "Note subject"
          def create(event_occurrence_id)
            handle_error do
              attributes = {
                note: options[:note],
                subject: options[:subject]
              }
              result = with_progress("Creating event occurrence note") do
                Pike13::Desk::EventOccurrenceNote.create(event_occurrence_id: event_occurrence_id,
                                                         attributes: attributes)
              end
              output(result)
            end
          end

          desc "update EVENT_OCCURRENCE_ID ID", "Update a note for an event occurrence"
          format_options
          option :note, type: :string, desc: "Updated note content"
          option :subject, type: :string, desc: "Updated note subject"
          def update(event_occurrence_id, id)
            handle_error do
              attributes = {}
              attributes[:note] = options[:note] if options[:note]
              attributes[:subject] = options[:subject] if options[:subject]

              result = with_progress("Updating event occurrence note") do
                Pike13::Desk::EventOccurrenceNote.update(event_occurrence_id: event_occurrence_id, id: id,
                                                         attributes: attributes)
              end
              output(result)
            end
          end

          desc "delete EVENT_OCCURRENCE_ID ID", "Delete a note for an event occurrence"
          format_options
          def delete(event_occurrence_id, id)
            handle_error do
              result = with_progress("Deleting event occurrence note") do
                Pike13::Desk::EventOccurrenceNote.destroy(event_occurrence_id: event_occurrence_id, id: id)
              end
              output(result)
            end
          end
        end
      end
    end
  end
end
