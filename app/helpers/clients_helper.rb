# frozen_string_literal: true

module ClientsHelper
  def client_users_options
    [%i[All All]] + client_users_select_options
  end

  def client_users_select_options
    User.pluck(Arel.sql("CONCAT(first_name, ' ', last_name) AS full_name"), :id).reject { |user| user.first.blank? }
  end

  def client_options
    Client.ids
  end

  def client_dropdown_options
    Client.pluck(:name, :id)
  end
end
