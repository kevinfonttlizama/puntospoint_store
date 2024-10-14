class AdminsController < ApplicationController
  before_filter :require_admin
  def dashboard
  end
end
