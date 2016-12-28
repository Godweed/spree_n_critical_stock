Deface::Override.new(:virtual_path => 'spree/admin/products/index',
  :name => 'add_critical_stock_header_to_backend_products_index',
  :insert_before => '[data-hook="admin_products_index_header_actions"]',
  :text => '
    <th class="text-center"><a style="pointer:cursor;"><%= Spree.t(:critical_stock, :scope => :n_critical_stock) %></a></th>
  ',
  :original => '1cf1e743e552f1fae35c0f3584123a8e3058e27d')

Deface::Override.new(:virtual_path => 'spree/admin/products/index',
  :name => 'add_critical_stock_row_to_backend_products_index',
  :insert_before => '[data-hook="admin_products_index_row_actions"]',
  :text => '
     <td class="text-center">
      <% if product.master.has_critical_stock %>
        <span class="label label-not"><i class="glyphicon glyphicon-remove"></i></span>
      <% else %>
        <span class="label label-ok"><i class="glyphicon glyphicon-ok"></i></span>
      <% end %>
    </td>
  ',
  :original => 'b5262a1e289f4ccb3f368cb731d5a0607c5e1a94')