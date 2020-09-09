require 'rails_helper'

RSpec.describe Option, type: :model do
  let(:question)    { create(:question) }

  describe "Validations" do
    it { is_expected.to validate_presence_of(:name) }
  end

  describe "The option values are valid" do
    it "Should create the option" do
      subject.name = "Soy una opción"
      subject.question = question

      expect(subject).to be_valid
    end
  end

  describe "The options values are not valid" do
    describe "the question not exist" do
      it "Should not create the option" do
        subject.name = "test"

        expect(subject).to be_invalid
        expect(subject.errors.messages[:question]).to match_array("Debe existir una pregunta")
      end
    end
  end
end
