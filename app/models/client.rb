class Client < ApplicationRecord
  has_one :user, as: :userable
end
