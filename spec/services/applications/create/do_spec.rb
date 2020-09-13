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
          name: "Soy una pregunta",
          options: ["Si"]
        },
        {
          name: "Soy otra pregunta",
          options: ["Tal vez"]
        }
      ],
      owner: user.email,
      date_apply: "1594996600000"#julio-17-2020
    } }

    let(:response)  { subject.(input) }

    context "When the input is valid" do
      it "Should return a success response" do
        expect(Application.count).to eq(0)
        expect(Answer.count).to eq(0)

        expect(response.success?).to be_truthy
        expect(Application.count).to eq(1)
        expect(Answer.count).to eq(2)
        expect(Application.last.date_apply).to eq("2020-07-17 14:36:40")
      end
    end

    context "When the id is valid" do
      it "Should return a failure response" do
        expect(Application.count).to eq(0)
        expect(Answer.count).to eq(0)
        input[:id] = "0"

        expect(response.success?).to be_falsey
        expect(Application.count).to eq(0)
        expect(Answer.count).to eq(0)

        expected_response = {:message=>"No se pudo encontrar la encuesta", :code=>10101}

        expect(response.failure).to eq(expected_response)
      end
    end

    context "When the answers are invalid" do
      it "Should return a failure response" do
        expect(Application.count).to eq(0)
        expect(Answer.count).to eq(0)
        input[:answers] = " "

        expect(response.failure?).to be_truthy
        expect(Application.count).to eq(0)
        expect(Answer.count).to eq(0)

        expected_response = {:answers=>["must be Array"]}

        expect(response.failure).to eq(expected_response)
      end
    end
  end
end
