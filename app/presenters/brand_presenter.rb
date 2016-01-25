class BrandPresenter < BasePresenter
  presents :brand

  def description
    if h.policy(brand).show?
      h.link_to brand.description, brand
    else
      brand.description
    end
  end

  def details
    "cod. #{brand.code}"
  end

  def edit_link
    if h.policy(brand).edit?
      h.link_to h.t('actions.edit'), h.edit_brand_path(brand), class: :default
    end
  end

  def destroy_link
    if h.policy(brand).destroy?
      h.link_to h.t('actions.destroy'), brand, method: :delete,
                                        data: { confirm: h.t('actions.are_you_sure') },
                                        class: :danger
    end
  end
end
