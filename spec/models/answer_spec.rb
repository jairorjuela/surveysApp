require 'rails_helper'

RSpec.describe Answer, type: :model do
  let(:survey)         { create(:survey) }
  let(:question)       { create(:question, survey: survey) }
  let(:option)         { create(:option, question: question) }
  let(:application)    { create(:application, survey: survey) }

  describe "The answer values are valid" do
    it "Should create the answer" do
      subject.application = application
      subject.question = question
      subject.option = option

      expect(subject).to be_valid
    end
  end

  describe "The answer values are not valid" do
    describe "the application not exist" do
      it "Should not create the answer" do
        subject.question = question
        subject.option = option

        expect(subject).to be_invalid
        expect(subject.errors.messages[:application]).to match_array("Debe aplicar a una encuesta") 
      end
    end

    describe "the question not exist" do
      it "Should not create the answer" do
        subject.application = application
        subject.option = option

        expect(subject).to be_invalid
        expect(subject.errors.messages[:question]).to match_array("Debe existir una pregunta") 
      end
    end

    describe "the option not exist" do
      it "Should not create the answer" do
        subject.application = application
        subject.question = question

        expect(subject).to be_invalid
        expect(subject.errors.messages[:option]).to match_array("Debe existir una opción") 
      end
    end
  end
end
