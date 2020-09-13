require 'rails_helper'

RSpec.describe Surveys::Create::Do do
  describe "#call" do
    let(:user)      { create(:user, email: "holi@mail.com") }
    let(:input)     { {
      title: "Mi encuesta",
      questions: [
        {
          name: "Soy una pregunta",
          options: ["Si", "No", "No se"]
        },
        {
          name: "Soy otra pregunta",
          options: ["Si", "Tal vez"]
        }
      ],
      owner: user.email
    } }

    let(:response)  { subject.(input) }

    context "When the input is valid" do
      it "Should return a success response" do
        expect(Survey.count).to eq(0)
        expect(response.success?).to be_truthy
        expect(Survey.count).to eq(1)
        expect(Question.count).to eq(2)
        expect(Option.count).to eq(5)
        expect(Survey.last.name).to eq("Mi encuesta")
      end
    end

    context "When the input is invalid" do
      it "Should return a failure response" do
        input[:title] = 123


        expect(response).to be_failure
        expect(Survey.count).to eq(0)
        expect(Question.count).to eq(0)
        expect(Option.count).to eq(0)
        expect(response.failure).to eq({:title=>["must be String"]})
      end
    end

    context "When the input is invalid" do
      it "Should return a success response" do
        input[:owner] = ""


        expect(response).to be_failure
        expect(Survey.count).to eq(0)
        expect(Question.count).to eq(0)
        expect(Option.count).to eq(0)
        expect(response.failure).to eq({:owner=>["must be filled"]})
      end
    end

    context "When the input is invalid" do
      it "Should return a success response" do
        input[:questions] = []


        expect(response).to be_failure
        expect(Survey.count).to eq(0)
        expect(Question.count).to eq(0)
        expect(Option.count).to eq(0)
        expect(response.failure).to eq({:questions=>["must be filled"]})
      end
    end
  end
end
