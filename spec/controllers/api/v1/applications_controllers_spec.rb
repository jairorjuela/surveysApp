require 'rails_helper'

RSpec.describe Api::V1::ApplicationsController, :type => :request do
  describe "POST/applications" do
    context "Create a new application for survey" do
      it "Should return the new application" do
        user = create(:user, email: "test@mail.com")
        survey = create(:survey, name: "test", user: user)
        question = create(:question, name: "Test", survey: survey)
        option1 = create(:option, name: "One", question: question)
        option2 = create(:option, name: "Two", question: question)

        params = {
          id: survey.id.to_s,
          answers: [
            {
              name: "Test",
              options: ["One"]
            }
          ],
          owner: "test@mail.com",
          date_apply: "1594996600000"#julio-17-2020
        }

        post "/api/v1/applications", params: params

        body = JSON.parse(response.body)

        expect(response.headers["Content-Type"]).to eq("application/json; charset=utf-8")
        expect(response.status).to eq(201)

        expected_response = ["id", "date_apply", "owner", "answers", "survey", "questions", "options", "application", "all_answers"]
        expect(body.keys).to eq(expected_response)
      end
    end

    context "Create a new survey" do
      it "Should return error if the id survey is nil" do
        params = {
          id: "blah",
          answers: [
            {
              question: "Test",
              answer: ["One"]
            }
          ],
          owner: "test@mail.com",
          date_apply: "1594996600000"#julio-17-2020
        }

        post "/api/v1/applications", params: params

        body = JSON.parse(response.body)

        expect(response.headers["Content-Type"]).to eq("application/json; charset=utf-8")
        expect(response.status).to eq(401)

        expected_response = {"message"=>"No se pudo encontrar la encuesta", "code"=>10101}
        expect(body).to eq(expected_response)
      end

      it "Should return error when the survey doesnt have questions" do
        user = create(:user, email: "test@mail.com")
        survey = create(:survey, name: "test", user: user)

        params = {
          id: survey.id,
          answers: [
            {
              question: "Test",
              answer: ["One"]
            }
          ],
          owner: "test@mail.com",
          date_apply: "1594996600000"#julio-17-2020
        }

        post "/api/v1/applications", params: params

        body = JSON.parse(response.body)

        expect(response.headers["Content-Type"]).to eq("application/json; charset=utf-8")
        expect(response.status).to eq(401)

        expected_response = {"message"=>"No se pudo encontrar las preguntas", "code"=>10101}
        expect(body).to eq(expected_response)
      end
    end
  end
end
