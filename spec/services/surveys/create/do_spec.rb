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
      pp response
        #expect(response.success?).to be_truthy
      end
    end
  end
end
