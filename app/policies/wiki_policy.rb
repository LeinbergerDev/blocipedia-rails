class WikiPolicy < ApplicationPolicy

  def update?
    user.present?
  end

  def create?
    user.present?
  end

  def delete?
    user.present?
  end

  def user_is_owner?
    if user.id == record.user_id
      return true
    else
      return false
    end
  end

  def public?
    if record.private == false
      return true
    else
      return false
    end
  end

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      wikis = []
      if user.id == 'admin'
        wikis = scope.all?
      elsif user.role == 'premium'
        all_wikis = scope.all
        all_wikis.each do |wiki|
          if wiki.private == false || wiki.user_id == user.id || wiki.collaborators.include?(user)
            wikis << wiki
          end
        end
      else
        all_wikis = scope.all
        wikis = []
        all_wikis.each do |wiki|
          if wiki.private == false || wiki.collaborators.include?(user)
            wikis << wiki
          end
        end
      end
      wikis
    end
  end

end
