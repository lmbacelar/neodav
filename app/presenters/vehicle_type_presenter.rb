class VehicleTypePresenter < BasePresenter
  presents :vehicle_type

  def description
    if h.policy(vehicle_type).show?
      h.link_to vehicle_type.description, vehicle_type
    else
      vehicle_type.description
    end
  end

  def details
    "cod. #{vehicle_type.code}"
  end

  def edit_link
    if h.policy(vehicle_type).edit?
      h.link_to h.t('actions.edit'), h.edit_vehicle_type_path(vehicle_type), class: :default
    end
  end

  def destroy_link
    if h.policy(vehicle_type).destroy?
      h.link_to h.t('actions.destroy'), vehicle_type, method: :delete,
                                        data: { confirm: h.t('actions.are_you_sure') },
                                        class: :danger
    end
  end
end
