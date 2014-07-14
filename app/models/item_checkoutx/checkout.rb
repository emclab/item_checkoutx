module ItemCheckoutx
  require 'workflow'
  class Checkout < ActiveRecord::Base

    include Workflow
    workflow_column :wf_state


    attr_accessor :last_updated_by_name, :id_noupdate, :wf_comment, :wf_state_noupdate, :wf_event
    attr_accessible :brief_note, :checkout_by_id, :item_id, :last_updated_by_id, :out_date, :out_qty, :requested_by_id, :requested_qty, :wf_state,  
                    :name, :item_spec, :wf_state, :request_date, :checkout, :unit, 
                    :as => :role_new
    attr_accessible :brief_note, :checkout_by_id, :item_id, :last_updated_by_id, :out_date, :out_qty, :requested_by_id, :requested_qty, :wf_state, 
                    :name, :item_spec, :last_updated_by_name, :id_noupdate, :wf_comment, :wf_state, :request_date, :checkout, :unit, :released,
                    :as => :role_update
                    
    attr_accessor :start_date_s, :end_date_s, :time_frame_s, :name_s, :requested_by_id_s, :checkout_by_id_s, :item_spec_s, :item_id_s, :outed_s
    attr_accessible :start_date_s, :end_date_s, :time_frame_s, :name_s, :requested_by_id_s, :checkout_by_id_s, :item_spec_s, :item_id_s, :outed_s,
                    :as => :role_search_stats
                    
    belongs_to :last_updated_by, :class_name => 'Authentify::User'
    belongs_to :requested_by, :class_name => 'Authentify::User'
    belongs_to :checkout_by, :class_name => 'Authentify::User'
    belongs_to :item, :class_name => ItemCheckoutx.item_class.to_s
    
    validates :request_date, :name, :item_spec, :unit, :presence => true
    validates_numericality_of :requested_qty, :item_id, :only_integer => true, :greater_than => 0
    validates :out_qty, :numericality => {:only_integer => true, :greater_than_or_equal_to => 0}, :if => 'out_qty.present?'
    validates_numericality_of :out_qty, :less_than_or_equal_to => :requested_qty, :message => I18n.t('Requested Qty <= Checkout Qty'), :if => 'out_qty.present?'   
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
      wf = Authentify::AuthentifyUtility.find_config_const('checkout_wf_pdef', 'item_checkoutx')
      if Authentify::AuthentifyUtility.find_config_const('wf_pdef_in_config') == 'true' && wf.present?
        eval(wf) 
      elsif Rails.env.test?  
        state :initial_state do
          event :submit, :transitions_to => :reviewing
        end
        state :reviewing do
          event :approve, :transitions_to => :approved
          event :reject, :transitions_to => :rejected
          event :rewind, :transitions_to => :initial_state
        end
        state :approved do
          event :release, :transitions_to => :released
        end
        state :rejected
        state :released
        
      end
    end
  end
end