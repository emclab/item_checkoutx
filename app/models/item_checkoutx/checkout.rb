module ItemCheckoutx
  class Checkout < ActiveRecord::Base
    include Workflow
    workflow_column :wf_state


    attr_accessor :name, :spec, :last_updated_by_name
    attr_accessible :brief_note, :checkout_by_id, :comment, :item_id, :last_updated_by_id, :order_id, :out_date, :out_qty, :requested_by_id, :requested_qty, 
                    :state, :wfid, :wf_state,
                    :name, :spec, 
                    :as => :role_new
    attr_accessible :brief_note, :checkout_by_id, :comment, :item_id, :last_updated_by_id, :order_id, :out_date, :out_qty, :requested_by_id, :requested_qty, 
                    :state, :wfid, :wf_state,
                    :name, :spec, :last_updated_by_name,
                    :as => :role_update
    belongs_to :last_updated_by, :class_name => 'Authentify::User'
    belongs_to :requested_by, :class_name => 'Authentify::User'
    belongs_to :checkout_by, :class_name => 'Authentify::User'
    belongs_to :item, :class_name => ItemCheckoutx.item_class.to_s
    belongs_to :order, :class_name => ItemCheckoutx.order_class.to_s
    
    validates :out_date, :presence => true
    validates_numericality_of :requested_qty, :item_id, :order_id, :only_integer => true, :greater_than => 0
    validates :out_qty,  :numericality => {:only_integer => true, :greater_than_or_equal_to => 0}
    validates_numericality_of :out_qty, :less_than_or_equal_to => :requested_qty, :message => I18n.t('Requested Qty >= Checkout Qty')
    validate :dynamic_validate 
    
    def dynamic_validate
      wf = Authentify::AuthentifyUtility.find_config_const('dynamic_validate', 'exp_reinbersex')
      eval(wf) if wf.present?
    end        
                                          
    #for workflow input validation  
    validate :validate_wf_input_data, :if => 'wf_state.present?' 
    
    def validate_wf_input_data
      wf = Authentify::AuthentifyUtility.find_config_const('validate_checkout_' + self.wf_state, 'item_checkoutx')
      if Authentify::AuthentifyUtility.find_config_const('wf_validate_in_config') == 'true' && wf.present? 
        eval(wf) 
      end
    end           
    
    
    workflow do
      wf = Authentify::AuthentifyUtility.find_config_const('item_checkoutx_wf_pdef', 'item_checkoutx')
      if Authentify::AuthentifyUtility.find_config_const('wf_pdef_in_config') == 'true' && wf.present?
        eval(wf) 
      elsif Rails.env.test?  
        state :initial_state do
          event :submit, :transitions_to => :manager_reviewing
        end
        state :manager_reviewing do
          event :manager_approve, :transitions_to => :approved
          event :manager_reject, :transitions_to => :rejected
          event :manager_rewind, :transitions_to => :initial_state
        end
        state :approved do
          event :checkout, :transitions_to => :checkedout
        end
        state :checkedout
        
      end
    end
        
    
    
    
    
    
    
    
    
    
    
    
    
    
    
        
  end
end
