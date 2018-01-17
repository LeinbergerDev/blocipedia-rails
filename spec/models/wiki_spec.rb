require 'rails_helper'

RSpec.describe Wiki, type: :model do
  let(:user) { User.create!(email: "user@example.com", password: "password", confirmed_at: Date.today) }
  let(:wiki) { Wiki.create!(title: "MY test wiki", body: "Test body for new wiki", private: false, user: user) }

  describe "attributes" do
    it "has title, body, private and user attributes" do
      expect(wiki).to have_attributes(title: "MY test wiki", body: "Test body for new wiki", private: false, user: user)
    end
  end
end
