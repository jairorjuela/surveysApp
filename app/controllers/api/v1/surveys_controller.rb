module Api
  module V1
    class SurveysController < ApplicationController
      acts_as_token_authentication_handler_for User, only: [:create, :update, :destroy]
      before_action :set_surveys, only: [:index]
      before_action :authenticate_user!, only: [:create, :update, :destroy]

      def index
        render json: @surveys, each_serializer: SurveySerializer
      end

      def show
        response = Surveys::Show::Do.new.(show_params)

        if response.success?
          render json:  response.success, status: 201
        else
          render json:  response.failure, status: 401
        end
      end

      def create
        response = Surveys::Create::Do.new.(survey_params)

        if response.success?
          render json:  response.success, status: 201, each_serializer: SurveyShowSerializer
        else
          render json:  response.failure, status: 401
        end
      end

      def destroy
        response = Surveys::Destroy::Do.new.(show_params)

        if response.success?
          render json:  response.success, status: 201
        else
          render json:  response.failure, status: 401
        end
      end

      private
      def set_surveys
        if params[:user].present?
          user = User.find_by(email: params[:user])
          @surveys = user.surveys
        else
          @surveys = Survey.all
        end
      end

      def show_params
        params.permit(:id).to_h.symbolize_keys
      end

      def survey_params
        params.permit(:title, :owner).to_h.symbolize_keys.merge(questions:params[:questions])
      end
    end
  end
end
