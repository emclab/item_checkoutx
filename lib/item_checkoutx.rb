require "item_checkoutx/engine"

module ItemCheckoutx
  mattr_accessor :item_class, :show_item_path
  
  def self.item_class
    @@item_class.constantize
  end
  
end
