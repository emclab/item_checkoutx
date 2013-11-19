require "item_checkoutx/engine"

module ItemCheckoutx
  mattr_accessor :item_class, :show_item_path, :order_class, :mfg_batch_class, :show_order_path, :order_collection
  
  def self.item_class
    @@item_class.constantize
  end
  
  def self.order_class
    @@order_class.constantize
  end
end
