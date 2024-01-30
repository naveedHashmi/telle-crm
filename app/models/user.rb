# frozen_string_literal: true

class User < ApplicationRecord
  belongs_to :userable, polymorphic: true

  validate :name, prepend: true
end
