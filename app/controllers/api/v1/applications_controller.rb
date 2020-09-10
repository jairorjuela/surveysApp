module Api
  module V1
    class ApplicationsController < ApplicationController

      def index
        @surveys = Survey.all
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

      def update
        #if authorized?
        #  if @survey.update(survey_params)
        #    render json: @survey, status: 201
        #  else
        #    render json: { error: "El registro no pudo ser actualizado" }, status: 401
        #  end
        #else
        #  render json: { error: "No tiene permisos" }, status: 403
        #end
        response = Surveys::Update::Do.new.(survay_params)

        if response.success?
          render json:  response.success, status: 201, each_serializer: SurveyShowSerializer
        else
          render json:  response.failure, status: 401
        end
      end

      def destroy
        if authorized?
          @survey.destroy
          render json: @surveys, status: 201
        else
          render json: { error: "No tiene permisos" }, status: 403
        end
      end

      private
      def show_params
        params.permit(:id).to_h.symbolize_keys
      end

      def survey_params
        #params.require(:survey).permit(:name).merge(user: current_user).to_h.symbolize_keys
        params.permit(:title, :owner).to_h.symbolize_keys.merge(questions:params[:questions])
      end

      #def set_survey
      #  @survey = Survey.find_by(name: survey_params[:name])
      #end

      def authorized?
        @survey.user.eql?(current_user)
      end
    end
  end
end
