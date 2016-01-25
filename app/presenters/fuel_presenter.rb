class FuelPresenter < BasePresenter
  presents :fuel

  def description
    if h.policy(fuel).show?
      h.link_to fuel.description, fuel
    else
      fuel.description
    end
  end

  def details
    "cod. #{fuel.code}"
  end

  def edit_link
    if h.policy(fuel).edit?
      h.link_to h.t('actions.edit'), h.edit_fuel_path(fuel), class: :default
    end
  end

  def destroy_link
    if h.policy(fuel).destroy?
      h.link_to h.t('actions.destroy'), fuel, method: :delete,
                                        data: { confirm: h.t('actions.are_you_sure') },
                                        class: :danger
    end
  end
end
