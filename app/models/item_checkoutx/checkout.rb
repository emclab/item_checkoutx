module ItemCheckoutx
  require 'workflow'
  class Checkout < ActiveRecord::Base

    include Workflow
    workflow_column :wf_state
    
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
    
    attr_accessor :last_updated_by_name, :id_noupdate, :wf_comment, :wf_state_noupdate, :wf_event, :requested_by_name, :checkout_by_name, :skip_wf_noupdate,
                  :name, :item_spec

    belongs_to :last_updated_by, :class_name => 'Authentify::User'
    belongs_to :requested_by, :class_name => 'Authentify::User'
    belongs_to :checkout_by, :class_name => 'Authentify::User'
    belongs_to :item, :class_name => ItemCheckoutx.item_class.to_s
    
    validates :requested_qty, :presence => true, :numericality => {:only_integer => false, :greater_than => 0}
    validates :item_id, :presence => true, :numericality => {:only_integer => true, :greater_than => 0} #, :if => 'item_id.present?'
    validates :out_qty, :numericality => true, :if => 'out_qty.present?' 
    validates :out_qty, :numericality => {:less_than_or_equal_to => :requested_qty, :message => I18n.t('Requested Qty <= Checkout Qty')}, :if => 'out_qty.present? && requested_qty.present?' 
    validate :dynamic_validate 
    validate :check_out_qty
    #for workflow input validation  
    validate :validate_wf_input_data, :if => 'wf_state.present?' 
    
    
    def dynamic_validate
      wf = Authentify::AuthentifyUtility.find_config_const('dynamic_validate', 'item_checkoutx')
      eval(wf) if wf.present?
    end        
    
    def check_out_qty
      errors.add(:out_qty, I18n.t('Qty <> 0')) if out_qty == 0      
    end
                                          
    def validate_wf_input_data
      wf = Authentify::AuthentifyUtility.find_config_const('validate_checkout_' + self.wf_state, 'item_checkoutx')
      if Authentify::AuthentifyUtility.find_config_const('wf_validate_in_config') == 'true' && wf.present? 
        eval(wf) 
      end
    end           
    
  end
end