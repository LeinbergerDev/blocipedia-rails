require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { User.create!(email: "user@example.com", password: "password", confirmed_at: Date.today)}
end
