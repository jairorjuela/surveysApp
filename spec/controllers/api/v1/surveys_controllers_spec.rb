require 'rails_helper'

RSpec.describe Api::V1::SurveysController, :type => :request do
  let(:user)      { create(:user, email: "test@mail.com") }
  let(:header) { { 'Authorization' => JsonWebToken.encode({ user_id: user.id }), 'HTTP_ACCEPT' => "application/json" } }

  describe "GET/surveys" do
    context "All surveys are public" do
      it "Should return empty array" do
        get '/api/v1/surveys'

        body = JSON.parse(response.body)

        expect(response.headers["Content-Type"]).to eq("application/json; charset=utf-8")
        expect(response.status).to eq(200)

        expected_response = []
        expect(body).to eq(expected_response)
      end
    end
  end

  describe "GET/surveys/survey" do
    context "One survey are public" do
      it "Should return the survey" do
        survey = create(:survey, name: "test")
        question = create(:question, survey: survey)
        options = create(:option, question: question)

        get "/api/v1/surveys/#{survey.id}"

        body = JSON.parse(response.body)

        expect(response.headers["Content-Type"]).to eq("application/json; charset=utf-8")
        expect(response.status).to eq(201)

        expected_response = {
          "title"=>"test",
          "questions"=>[
            {"name"=>"Soy una pregunta",
              "options"=>["Soy una opción"]
            }
          ],
          "owner"=>"batman@justiceleague.com"
        }

        expect(body).to eq(expected_response)
      end
    end
  end

  describe "POST/surveys" do
    context "Create a new survey" do
      it "Should return the new survey" do
        sign_in user
        params = {
          title: "New survey",
          questions: [
            {
              name: "Question one",
              options: ["option one", "option two"]
            },
            {
              name: "Question tow",
              options: ["yes", "No"]
            }
          ],
          owner: "test@mail.com"
        }

        post "/api/v1/surveys", params: params

        body = JSON.parse(response.body)

        expect(response.headers["Content-Type"]).to eq("application/json; charset=utf-8")
        expect(response.status).to eq(201)

        expected_response = ["title", "owner", "questions", "user", "survey", "created_questions", "created_options"]
        expect(body.keys).to eq(expected_response)
      end
    end

    context "Fail in Create a new survey" do
      it "Should return error if the user is nil" do
        params = { survey: { name: "New new test" } }

        post "/api/v1/surveys", params: params

        expect(response.headers["Content-Type"]).to eq("application/json; charset=utf-8")
        expect(response.status).to eq(401)

        expected_response = nil
        expect(response.request.flash.alert).to eq(expected_response)
      end
    end

    context "Create a new survey" do
      it "Should return error if the name is nil" do
        sign_in user
        params = { survey: { name: nil } }

        post "/api/v1/surveys", params: params

        body = JSON.parse(response.body)

        expect(response.headers["Content-Type"]).to eq("application/json; charset=utf-8")
        expect(response.status).to eq(401)

        expected_response = {"owner"=>["is missing"], "questions"=>["must be filled"], "title"=>["is missing"]}
        expect(body).to eq(expected_response)
      end
    end
  end

  describe "DELETE/surveys" do
    context "Delete a survey" do
      it "Should return message success when delete the survey" do
        sign_in user
        survey = create(:survey, name: "test")
        question = create(:question, survey: survey)
        options = create(:option, question: question)

        delete "/api/v1/surveys/#{survey.id}"

        body = JSON.parse(response.body)

        expect(response.headers["Content-Type"]).to eq("application/json; charset=utf-8")
        expect(response.status).to eq(201)

        expected_response = {"message"=>"Se eliminó la encuesta"}
        expect(body).to eq(expected_response)
      end
    end
  end
end
