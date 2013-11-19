module ItemCheckoutx
  class Checkout < ActiveRecord::Base
    attr_accessor :name, :spec, :last_updated_by_name
    attr_accessible :brief_note, :checkout_by_id, :comment, :item_id, :last_updated_by_id, :order_id, :out_date, :out_qty, :requested_by_id, :requested_qty, 
                    :state, :wfid, 
                    :name, :spec,
                    :as => :role_new
    attr_accessible :brief_note, :checkout_by_id, :comment, :item_id, :last_updated_by_id, :order_id, :out_date, :out_qty, :requested_by_id, :requested_qty, 
                    :state, :wfid,
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
  end
end
