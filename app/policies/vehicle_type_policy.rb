class VehicleTypePolicy < ApplicationPolicy
  def index?
    admin? || manager? || auditor?
  end

  def create?
    admin? || manager?
  end

  def update?
    admin? || manager?
  end

  def destroy?
    admin? || manager?
  end

  def import?
    admin? || manager?
  end

  def autocomplete?
    admin? || manager? || auditor?
  end
end
