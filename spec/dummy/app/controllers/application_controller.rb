class ApplicationController < ActionController::Base
  protect_from_forgery
  include Authentify::AuthentifyUtility
  before_action :set_local_thread_variables
  after_action :cleanup_local_thread_variables 
end
