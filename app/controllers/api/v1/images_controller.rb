module Api
  module V1
    class ImagesController < ApplicationController
      def index
        images = Image.all
        render json: images, status: :ok
      end

      def create
        image = Image.new(image_params)

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
