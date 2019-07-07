class ApplicationController < ActionController::API
  private

  def authenticate_user!
    @current_user ||= AuthenticateUser.new(request.headers).call.result
    render json: { error: 'Not authorized' }, status: :unauthorized unless @current_user
  end
end
