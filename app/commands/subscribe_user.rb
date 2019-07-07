class SubscribeUser
  prepend SimpleCommand

  def call
    generate_access_token
    user.save
    JsonWebToken.encode(access_token: user.access_token)
  end

  private

  def user
    @user ||= User.new
  end

  def generate_access_token
    loop do
      user.access_token = Digest::SHA256.hexdigest(Time.now.to_s)
      break unless User.where(access_token: user.access_token).exists?
    end
  end
end