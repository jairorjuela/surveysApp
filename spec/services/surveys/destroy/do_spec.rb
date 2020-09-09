require 'rails_helper'

RSpec.describe Surveys::Destroy::Do do
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
      pp response
        #expect(response.success?).to be_truthy
      end
    end
  end
end
