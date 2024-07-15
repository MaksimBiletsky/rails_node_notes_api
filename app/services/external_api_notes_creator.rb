class ExternalApiNotesCreator < ApplicationService
  def call
    notes = fetch_notes.each_with_object([]) do |note, notes_array|
      notes_array << Note.create!(title: note["title"], content: note["content"])
    end
    { notes: }
  rescue StandardError => e
    return { error: e.message }
  end

  private

  def fetch_notes
    file_path = Rails.root.join('db', 'sample_notes.json')
    file = File.read(file_path)
    JSON.parse(file)
  end
end