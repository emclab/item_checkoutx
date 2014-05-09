module ItemCheckoutx
  class Checkout < ActiveRecord::Base
    attr_accessor :last_updated_by_name, :id_noupdate, :wf_comment, :wf_event
    attr_accessible :brief_note, :checkout_by_id, :item_id, :last_updated_by_id, :out_date, :out_qty, :requested_by_id, :requested_qty, :wf_state,  
                    :name, :item_spec,
                    :as => :role_new
    attr_accessible :brief_note, :checkout_by_id, :item_id, :last_updated_by_id, :out_date, :out_qty, :requested_by_id, :requested_qty, :wf_state, 
                    :name, :item_spec, :last_updated_by_name, :id_noupdate, :wf_comment,
                    :as => :role_update
                    
    attr_accessor :start_date_s, :end_date_s, :time_frame_s, :name_s, :requested_by_id_s, :checkout_by_id_s, :item_spec_s, :item_id_s
    attr_accessible :start_date_s, :end_date_s, :time_frame_s, :name_s, :requested_by_id_s, :checkout_by_id_s, :item_spec_s, :item_id_s,
                    :as => :role_search_stats
                    
    belongs_to :last_updated_by, :class_name => 'Authentify::User'
    belongs_to :requested_by, :class_name => 'Authentify::User'
    belongs_to :checkout_by, :class_name => 'Authentify::User'
    belongs_to :item, :class_name => ItemCheckoutx.item_class.to_s
    
    validates :out_date, :name, :item_spec, :presence => true
    validates_numericality_of :requested_qty, :item_id, :only_integer => true, :greater_than => 0
    validates :out_qty,  :numericality => {:only_integer => true, :greater_than_or_equal_to => 0}
    validates_numericality_of :out_qty, :less_than_or_equal_to => :requested_qty, :message => I18n.t('Requested Qty <= Checkout Qty')    
  end
end
