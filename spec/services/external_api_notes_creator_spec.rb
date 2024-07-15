# spec/services/external_api_notes_creator_spec.rb
require 'rails_helper'

RSpec.describe ExternalApiNotesCreator, type: :service do
  describe '#call' do
    let(:sample_notes_path) { Rails.root.join('db', 'sample_notes.json') }
    let(:sample_notes) { JSON.parse File.read(sample_notes_path) }

    it 'creates notes from the External call' do
      result = ExternalApiNotesCreator.call

      expect(result[:notes].size).to eq(2)
      expect(Note.count).to eq(2)

      sample_notes.each_with_index do |sample_note, index|
        note = result[:notes][index]
        expect(note.title).to eq(sample_note["title"])
        expect(note.content).to eq(sample_note["content"])
      end
    end

    context 'when an error occurs' do
      before do
        allow(File).to receive(:read).and_raise(StandardError, 'Something went wrong')
      end

      it 'returns an error message' do
        result = ExternalApiNotesCreator.call

        expect(result[:error]).to eq('Something went wrong')
      end
    end
  end
end
