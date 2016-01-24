module ApplicationHelper
  def present object, klass = nil
    klass ||= "#{object.class}Presenter".constantize
    presenter = klass.new object, self
    yield presenter if block_given?
    presenter
  end

  def paginate collection_or_options = nil, options = {}
    if collection_or_options.is_a? Hash
      options, collection_or_options = collection_or_options, nil
    end
    unless options[:renderer]
      options = options.merge renderer: BootstrapPagination::Rails
    end
    will_paginate(*[collection_or_options, options].compact)
  end

  def resources_path options={}
    Rails.application.routes.url_helpers.send("#{resources_name}_path", options.merge(locale: I18n.locale).symbolize_keys)
  end

  def import_resources_path options={}
    Rails.application.routes.url_helpers.send("import_#{resources_name}_path", options.merge(locale: I18n.locale).symbolize_keys)
  end

  def new_resource_path options={}
    Rails.application.routes.url_helpers.send("new_#{resource_name}_path", options.merge(locale: I18n.locale).symbolize_keys)
  end

  def resources_name
    params[:controller]
  end

  def resource_name
    resources_name.singularize
  end

  def resource_class
    resource_name.classify.constantize
  end

  def resource_human
    resource_class.model_name.human
  end

  def resources_human
    resource_class.model_name.human count: 2
  end

  def action_name
    params[:action].capitalize
  end
end
