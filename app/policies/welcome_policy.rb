class WelcomePolicy < ApplicationPolicy
  def home?
    true
  end

  def index?
    false
  end

  def create?
    false
  end

  def update?
    false
  end

  def destroy?
    false
  end
end
