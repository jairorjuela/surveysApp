require 'rails_helper'

RSpec.describe Surveys::Show::Do do
  describe "#call" do
    let!(:user)          { create(:user, email: "holi@mail.com") }
    let!(:survey)        { create(:survey, name: "holi", user: user) }
    let!(:questions1)    { create(:question, name: "pregunta 1", survey: survey) }
    let!(:questions2)    { create(:question, name: "pregunta 2", survey: survey) }
    let!(:options1)      { create(:option, name: "opción 1", question: questions1) }
    let!(:options2)      { create(:option, name: "opción 2", question: questions1) }
    let!(:options3)      { create(:option, name: "opción 3", question: questions2) }
    let!(:options4)      { create(:option, name: "opción 4", question: questions2) }
    let(:input)          { { id: survey.id.to_s } }

    let(:response)      { subject.(input) }

    context "When the input is valid" do
      it "Should return a success response" do
        expected_response = {
          :title=>"holi",
          :questions=>[
            {:name=>"pregunta 1", :options=>["opción 1", "opción 2"]},
            {:name=>"pregunta 2", :options=>["opción 3", "opción 4"]}
          ],
          :owner=>"holi@mail.com"
        }

        expect(response.success?).to be_truthy
        expect(response.success).to eq(expected_response)
      end
    end

    context "When the input is invalid" do
      it "Should return a failure response" do
        input[:id] = { id: 4 }

        expect(response).to be_failure
        expect(Survey.count).to eq(1)
        expect(Question.count).to eq(2)
        expect(Option.count).to eq(4)
        expect(response.failure).to eq({:id=>["must be String"]})
      end
    end

    context "When the input is invalid" do
      it "Should return a failure response" do
        input[:id] = { id: "4" }

        expect(response).to be_failure
        expect(Survey.count).to eq(1)
        expect(Question.count).to eq(2)
        expect(Option.count).to eq(4)
      end
    end
  end
end
