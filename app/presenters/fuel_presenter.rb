class FuelPresenter < BasePresenter
  presents :fuel

  def name
    if h.policy(fuel).show?
      h.link_to fuel.name, fuel
    else
      fuel.name
    end
  end

  def details
    fuel.description
  end

  def edit_link
    if h.policy(fuel).edit?
      h.link_to 'Edit', h.edit_fuel_path(fuel), class: :default
    end
  end

  def destroy_link
    if h.policy(fuel).destroy?
      h.link_to 'Destroy', fuel, method: :delete,
                                 data: { confirm: 'Are you sure?' },
                                 class: :danger
    end
  end
end
