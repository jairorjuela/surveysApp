class RootPagesController < ApplicationController
  def home
  end

  def manage_surveys
    @current = current_user.email
  end
end
