# frozen_string_literal: true

module ClientsHelper
  def client_users_options
    [%i[All All]] + User.pluck(:name, :id).reject { |user| user.first.blank? }
  end

  def client_users_select_options
    User.pluck(:name, :id).reject { |user| user.first.blank? }
  end

  def client_options
    Client.ids
  end
end
