class APIController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  respond_to :json
  before_action :set_default_response_format

  protected

  def set_default_response_format
    request.format = :json
  end
end
