module Api
  module V1
    class ApplicationsController < ApplicationController
      def create
        response = Applications::Create::Do.new.(applications_params)

        if response.success?
          render json:  response.success, status: 201
        else
          render json:  response.failure, status: 401
        end
      end

      private
      def applications_params
        params.permit(:id, :date_apply, :owner).to_h.symbolize_keys.merge(answers: params[:answers])
      end
    end
  end
end
