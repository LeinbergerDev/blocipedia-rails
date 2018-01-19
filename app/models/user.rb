class User < ApplicationRecord

  has_many :wikis, dependent: :destroy

  before_save { self.email = email.downcase if email.present? }
  after_initialize :set_role, :if => :new_record?

  enum role: [:standard, :premium, :admin]

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  def set_role
    self.role ||= :standard
  end

end
