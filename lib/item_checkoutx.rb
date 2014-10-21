require "item_checkoutx/engine"

module ItemCheckoutx
  mattr_accessor :item_class, :show_item_path, :material_requisition_class
  
  def self.item_class
    @@item_class.constantize
  end
  
  def self.material_requisition_class
    @@material_requisition_class.constantize
  end
  
end
