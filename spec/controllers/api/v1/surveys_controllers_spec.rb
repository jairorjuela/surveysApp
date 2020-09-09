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

  #describe "GET/surveys/survey" do
  #  context "One survey are public" do
  #    it "Should return the survey" do
  #      survey = create(:survey, name: "test")
  #      params = { survey: { name: "test" } }

  #      get "/api/v1/surveys/survey", params: params

  #      body = JSON.parse(response.body)

  #      expect(response.headers["Content-Type"]).to eq("application/json; charset=utf-8")
  #      expect(response.status).to eq(200)

  #      expected_response = {"name"=>"test", "user"=>{"email"=>"batman@justiceleague.com"}}
  #      expect(body).to eq(expected_response)
  #    end
  #  end
  #end

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

        expect(response.headers["Content-Type"]).to eq("text/html; charset=utf-8")
        expect(response.status).to eq(302)

        expected_response = "Debe registrarse o iniciar sesión"
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
end
