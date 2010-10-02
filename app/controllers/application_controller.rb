require "application_responder"
class ApplicationController < ActionController::Base
  protect_from_forgery

  self.responder = ApplicationResponder
  respond_to :html, :xml, :json, :js

  before_filter :authenticate_user!

  rescue_from CanCan::AccessDenied do |ex|
    logger.error ex
    flash[:alert] = ex.message
    redirect_to tasks_path
  end

  # Use this method in your controllers to load and authorize resources with CanCan
  # load_and_authorize_resource

  # Example of using the responders - this will render html, xml or json depending on the request
  # def show
  #   respond_with @user
  # end
end
