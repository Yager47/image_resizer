module Api
  module V1
    class AuthenticationController < ApplicationController
      def subscribe
        command = SubscribeUser.new.call

        if command.success?
          render json: { auth_token: command.result }, status: :ok
        else
          render json: command.errors, status: :unprocessable_entity
        end
      end
    end
  end
end
