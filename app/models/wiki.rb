class Wiki < ApplicationRecord
  belongs_to :user
  has_many :users, through: :collaborators
end
