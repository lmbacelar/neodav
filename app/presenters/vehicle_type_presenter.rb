class VehicleTypePresenter < BasePresenter
  presents :vehicle_type

  def name
    if h.policy(vehicle_type).show?
      h.link_to vehicle_type.name, vehicle_type
    else
      vehicle_type.name
    end
  end

  def details
    vehicle_type.description
  end

  def edit_link
    if h.policy(vehicle_type).edit?
      h.link_to 'Edit', h.edit_vehicle_type_path(vehicle_type), class: :default
    end
  end

  def destroy_link
    if h.policy(vehicle_type).destroy?
      h.link_to 'Destroy', vehicle_type, method: :delete,
                                         data: { confirm: 'Are you sure?' },
                                         class: :danger
    end
  end
end
