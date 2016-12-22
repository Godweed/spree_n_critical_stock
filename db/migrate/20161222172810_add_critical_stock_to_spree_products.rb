class AddCriticalStockToSpreeProducts < ActiveRecord::Migration
  def up
    add_column :spree_products, :has_critical_stock, :boolean, default: false
  end

  def down
    remove_column :spree_products, :has_critical_stock
  end
end
