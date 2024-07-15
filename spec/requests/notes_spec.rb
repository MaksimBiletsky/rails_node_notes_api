require 'rails_helper'

RSpec.describe "Notes", type: :request do
  let!(:notes) { create_list(:note, 10) }
  let(:note_id) { notes.first.id }

  describe "GET /notes" do
    it "returns a list of notes" do
      get "/notes"
      expect(response).to have_http_status(200)
      expect(JSON.parse(response.body).size).to eq(10)
    end
  end

  describe "GET /notes/:id" do
    context "when the note exists" do
      it "returns the note" do
        get "/notes/#{note_id}"
        expect(response).to have_http_status(200)
        expect(JSON.parse(response.body)['id']).to eq(note_id)
      end
    end

    context "when the note does not exist" do
      it "returns a not found message" do
        get "/notes/100"
        expect(response).to have_http_status(404)
        expect(response.body).to match(/Couldn't find Note/)
      end
    end
  end

  describe "POST /notes" do
    let(:valid_attributes) { { note: { title: 'New Note', content: 'Content' } } }

    context "when the request is valid" do
      it "creates a new note" do
        post "/notes", params: valid_attributes
        expect(response).to have_http_status(201)
        expect(JSON.parse(response.body)['title']).to eq('New Note')
      end
    end

    context "when the request is invalid" do
      it "returns a validation error" do
        post "/notes", params: { note: { title: '' } }
        expect(response).to have_http_status(422)
        expect(JSON.parse(response.body)['title']).to include("can't be blank")
      end
    end
  end

  describe "PUT /notes/:id" do
    let(:valid_attributes) { { note: { title: 'Updated Note' } } }

    context "when the record exists" do
      it "updates the note" do
        put "/notes/#{note_id}", params: valid_attributes
        expect(response).to have_http_status(200)
        expect(Note.find(note_id).title).to eq('Updated Note')
      end
    end

    context "when the record does not exist" do
      it "returns a not found message" do
        put "/notes/100", params: valid_attributes
        expect(response).to have_http_status(404)
        expect(response.body).to match(/Couldn't find Note/)
      end
    end
  end

  describe "DELETE /notes/:id" do
    it "deletes the note" do
      delete "/notes/#{note_id}"
      expect(response).to have_http_status(204)
      expect { Note.find(note_id) }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
