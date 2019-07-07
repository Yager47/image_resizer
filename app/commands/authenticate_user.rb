class AuthenticateUser
  prepend SimpleCommand

  def initialize(headers = {})
    @headers = headers
  end

  def call
    return user if user
    errors.add(:token, 'Invalid token')
    nil
  end

  private

  attr_reader :headers

  def user
    @user ||= User.find_by(access_token: decoded_auth_token['access_token']) if decoded_auth_token
  end

  def decoded_auth_token
    @decoded_auth_token = JsonWebToken.decode(http_auth_header)
  end

  def http_auth_header
    if headers['Authorization'].present?
      headers['Authorization'].split(' ').last
    else
      errors.add(:token, 'Missing auth token')
      nil
    end
  end
end