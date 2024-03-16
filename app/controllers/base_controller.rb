# frozen_string_literal: true

class BaseController < ApplicationController
  before_action :authenticate_user!
  layout 'navbar'

  def set_who_dunit
    PaperTrail.request.whodunnit = current_user&.id
  end
end
