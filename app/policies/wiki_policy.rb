class WikiPolicy < ApplicationPolicy

  def update?
    user.present?
  end

  def create?
    user.present?
  end

  def delete?
    user_is_owner?
  end

  def user_is_owner?
    if user.id == record.user_id
      return true
    else
      return false
    end
  end

end
