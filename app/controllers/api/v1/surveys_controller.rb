module Api
  module V1
    class SurveysController < ApplicationController
      before_action :set_survey, only: [:show, :update, :destroy]
      before_action :authenticate_user!, only: [:create, :update, :destroy]

      def index
        @surveys = Survey.all
        render json: @surveys
      end

      def show
        if @survey.present?
          render json: @survey
        else
          render json: { error: "El registro no existe" }, status: 401
        end
      end

      def create
        survey = Survey.new(survey_params)

        if survey.save
          render json: survey, status: 201
        else
          render json: { error: "El registro no pudo ser creado" }, status: 401
        end
      end

      def update
        if authorized?
          if @survey.update(survey_params)
            render json: @survey, status: 201
          else
            render json: { error: "El registro no pudo ser actualizado" }, status: 401
          end
        else
          render json: { error: "No tiene permisos" }, status: 403
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
      def survey_params
        params.require(:survey).permit(:name).merge(user: current_user)
      end

      def set_survey
        @survey = Survey.find_by(name: survey_params[:name])
      end

      def authorized?
        @survey.user.eql?(current_user)
      end
    end
  end
end
