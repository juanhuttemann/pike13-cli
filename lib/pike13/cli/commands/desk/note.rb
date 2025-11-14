# frozen_string_literal: true

module Pike13
  module CLI
    module Commands
      class Desk < Base
        class Note < Base
          desc "list PERSON_ID", "List notes for a person"
          map "ls" => :list
          format_options
          def list(person_id)
            handle_error do
              result = with_progress("Fetching notes") do
                Pike13::Desk::Note.all(person_id: person_id)
              end
              output(result)
            end
          end

          desc "get PERSON_ID NOTE_ID", "Get a note by ID"
          format_options
          def get(person_id, note_id)
            handle_error do
              result = Pike13::Desk::Note.find(person_id: person_id, id: note_id)
              output(result)
            end
          end

          desc "create PERSON_ID", "Create a note for a person"
          format_options
          option :subject, type: :string, required: true, desc: "Note subject"
          option :note, type: :string, required: true, desc: "Note content"
          def create(person_id)
            handle_error do
              attributes = {
                subject: options[:subject],
                note: options[:note]
              }
              result = Pike13::Desk::Note.create(person_id: person_id, attributes: attributes)
              output(result)
              success_message "Note created successfully"
            end
          end

          desc "update PERSON_ID NOTE_ID", "Update a note"
          format_options
          option :subject, type: :string, desc: "Note subject"
          option :note, type: :string, desc: "Note content"
          def update(person_id, note_id)
            handle_error do
              attributes = {}
              attributes[:subject] = options[:subject] if options[:subject]
              attributes[:note] = options[:note] if options[:note]
              result = Pike13::Desk::Note.update(person_id: person_id, id: note_id, attributes: attributes)
              output(result)
              success_message "Note updated successfully"
            end
          end

          desc "delete PERSON_ID NOTE_ID", "Delete a note"
          def delete(person_id, note_id)
            handle_error do
              Pike13::Desk::Note.destroy(person_id: person_id, id: note_id)
              success_message "Note #{note_id} deleted successfully"
            end
          end
        end
      end
    end
  end
end
