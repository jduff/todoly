require "application_responder"
class ApplicationController < ActionController::Base
  protect_from_forgery

  self.responder = ApplicationResponder
  respond_to :html, :xml, :json

  before_filter :authenticate_user!

  # Use this method in your controllers to load and authorize resources with CanCan
  # load_and_authorize_resource

  # rescue_from CanCan::AccessDenied do |ex|
  #   flash[:alert] = ex.message
  #   redirect_to user_path(@user)
  # end

  # Example of using the responders - this will render html, xml or json depending on the request
  # def show
  #   respond_with @user
  # end
end
