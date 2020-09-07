require 'rails_helper'

RSpec.describe Question, type: :model do
  let(:survey)    { create(:survey) }

  describe "Validations" do
    it { is_expected.to validate_presence_of(:name) }
  end

  describe "The question values are valid" do
    it "Should create the question" do
      subject.name = "Soy una pregunta"
      subject.survey = survey

      expect(subject).to be_valid
    end
  end

  describe "The question values are not valid" do
    describe "the survey not exist" do
      it "Should not create the question" do
        subject.name = "test"

        expect(subject).to be_invalid
        expect(subject.errors.messages[:survey]).to match_array("Debe existir una encuesta")
      end
    end
  end
end
