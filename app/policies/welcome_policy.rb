class WelcomePolicy < ApplicationPolicy
  def home?
    admin? || manager? || auditor? || regular?
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
