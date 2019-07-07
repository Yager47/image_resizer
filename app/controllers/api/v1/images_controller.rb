module Api
  module V1
    class ImagesController < ApplicationController
      before_action :authenticate_user!

      def create
        image = @current_user.images.new(image_params)

        if image.save
          render json: image, status: :created
        else
          render json: image.errors, status: :unprocessable_entity
        end
      end

      private

      def image_params
        params.permit(:file, :width, :height)
      end
    end
  end
end
