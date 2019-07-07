class User
  include Mongoid::Document
  include Mongoid::Timestamps

  field :access_token, type: String

  has_many :images, dependent: :destroy

  validates_presence_of :access_token
end
