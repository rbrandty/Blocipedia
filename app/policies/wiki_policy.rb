class WikiPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.present?
        scope.where(private: false).or(scope.where(user_id: user.id))
      else
        scope.where(private: false)
      end
    end
  end

  def create?
    user.present?
  end

  def edit?
    user.present?
  end
end
