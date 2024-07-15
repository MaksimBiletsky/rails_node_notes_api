# spec/models/note_spec.rb
require 'rails_helper'

RSpec.describe Note, type: :model do
  subject { described_class.new }

  it "is valid with title" do
    subject.title = "Test Title"
    expect(subject).to be_valid
  end

  it "is not valid without a title" do
    expect(subject).to_not be_valid
  end
end
