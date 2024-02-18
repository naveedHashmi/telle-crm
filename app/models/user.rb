# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,
         :recoverable
  belongs_to :userable, polymorphic: true, optional: true

  has_many :clients

  validate :name, prepend: true
end
