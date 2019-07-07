module Api
  module V1
    class ImagesController < ApplicationController
      before_action :authenticate_user!

      def index
        images = @current_user.images
        render json: images, status: :ok
      end

      def create
        image = @current_user.images.new(image_params)

        if image.save
          render json: image, status: :created
        else
          render json: image.errors, status: :unprocessable_entity
        end
      end

      def resize_old_image
        if @current_user.images.where(id: old_image_params[:id]).exists?
          command = ResizeOldImage.new(old_image_params).call
          if command.success?
            render json: command.result, status: :created
          else
            render json: command.errors, status: :unprocessable_entity
          end
        else
          render json: { error: 'Image not found' }, status: :not_found
        end
      end

      private

      def image_params
        params.permit(:file, :width, :height)
      end

      def old_image_params
        params.permit(:id, :width, :height)
      end
    end
  end
end
