require 'rails_helper'

RSpec.describe Image, type: :model do
  it { should validate_presence_of(:file) }
  it { should validate_presence_of(:width) }
  it { should validate_presence_of(:height) }

  it { should validate_numericality_of(:width).is_greater_than(0) }
  it { should validate_numericality_of(:height).is_greater_than(0) }
end
