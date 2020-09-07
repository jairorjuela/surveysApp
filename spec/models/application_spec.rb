require 'rails_helper'

RSpec.describe Application, type: :model do
  let(:survey)    { create(:survey) }

  describe "Validations" do
    it { is_expected.to validate_presence_of(:date_apply) }
  end

  describe "The Application values are valid" do
    it "Should create the Application" do
      subject.date_apply = DateTime.now
      subject.survey = survey

      expect(subject).to be_valid
    end
  end

  describe "The Application values are not valid" do
    describe "the survey not exist" do
      it "Should not create the Application" do
        subject.date_apply = DateTime.now

        expect(subject).to be_invalid
        expect(subject.errors.messages[:survey]).to match_array("Debe existir una encuesta")
      end
    end
  end
end
