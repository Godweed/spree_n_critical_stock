class AddCriticalStockToSpreeVariants < ActiveRecord::Migration
  def up
    add_column :spree_variants, :critical_stock, :integer
    add_column :spree_variants, :has_critical_stock, :boolean, default: false
  end

  def down
    remove_column :spree_variants, :critical_stock
    remove_column :spree_variants, :has_critical_stock
  end
end
