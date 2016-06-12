module ItemCheckoutx
  class ApplicationController < ::ApplicationController
    include Authentify::SessionsHelper
    include Authentify::AuthentifyUtility
    include Authentify::UsersHelper
    include Authentify::UserPrivilegeHelper
    include Commonx::CommonxHelper
    include Searchx::SearchHelper
    include BizWorkflowx::WfHelper
    
    before_action :require_signin
    before_action :max_pagination
    before_action :check_access_right 
    before_action :load_session_variable, :only => [:new, :edit]  #for parent_record_id & parent_resource in check_access_right
    after_action :delete_session_variable, :only => [:create, :update]  #for parent_record_id & parent_resource in check_access_right
    before_action :page_params, :only => :index
    
    helper_method :return_misc_definitions, :return_users
   
    protected
  
    def max_pagination
      @max_pagination = find_config_const('pagination', session[:fort_token])
    end
    
  end
end
