Deface::Override.new(:virtual_path => 'spree/admin/general_settings/edit',
  :name => 'add_mail_to_address_to_general_settings_edit',
  :insert_before => "erb[silent]:contains('if @preferences_security.any?')",
  :text => '
    <% if @preferences_mail.any? %>
      <div class="panel panel-default security">
        <div class="panel-heading">
          <h1 class="panel-title">
            <%= Spree.t(:mail_settings) %>
          </h1>
        </div>

        <div class="panel-body">
          <% @preferences_mail.each do |key|
              type = Spree::Config.preference_type(key) %>
              <div class="checkbox">
                <%= label_tag key do %>
                  <%= preference_field_tag(key, Spree::Config[key], type: type) %>
                  <%= Spree.t(key, scope: :n_critical_stock) %>
                <% end %>
              </div>
          <% end %>
        </div>
      </div>
    <% end %>
  ')