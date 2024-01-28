# frozen_string_literal: true

class Lead < ApplicationRecord
  has_one :user, as: :userable

  enum status: { Alive: 0, Diseased: 1, Unknown: 2 }
end
