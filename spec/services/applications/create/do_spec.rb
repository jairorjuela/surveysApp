require 'rails_helper'

RSpec.describe Applications::Create::Do do
  describe "#call" do
    let!(:user)      { create(:user, email: "holi@mail.com") }
    let!(:survey)    { create(:survey, user: user) }
    let!(:question1) { create(:question, survey: survey, name: "Soy una pregunta") }
    let!(:question2) { create(:question, survey: survey, name: "Soy otra pregunta") }
    let!(:option1)   { create(:option, question: question1, name: "Si") }
    let!(:option2)   { create(:option, question: question1, name: "si") }
    let!(:option3)   { create(:option, question: question2, name: "Tal vez") }
    let!(:option4)   { create(:option, question: question2, name: "tal vez") }

    let(:input)     { {
      id: survey.id.to_s,
      answers: [
        {
          question: "Soy una pregunta",
          answer: ["Si"]
        },
        {
          question: "Soy otra pregunta",
          answer: ["Tal vez"]
        }
      ],
      owner: user.email,
      date_apply: "1594996600000"#julio-17-2020
    } }

    let(:response)  { subject.(input) }

    context "When the input is valid" do
      it "Should return a success response" do
      pp response
        #expect(response.success?).to be_truthy
      end
    end
  end
end
