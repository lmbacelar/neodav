class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :authenticate_user!, unless: :devise_controller?

  include Pundit
  after_action :verify_authorized, unless: :devise_controller?
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private
    def export_filename
      "#{params[:controller]}_#{Time.zone.now.strftime('%Y%m%d_%H%M%S')}.#{params[:format]}"
    end

    def user_not_authorized exception
      policy_name = exception.policy.class.to_s.underscore
      flash[:warning] = t "#{policy_name}.#{exception.query}", scope: 'pundit', default: :default
      redirect_to request.referrer || root_path
    end
end
