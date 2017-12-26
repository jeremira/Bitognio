class UsersController < ApplicationController

  before_action :authenticate_user!

  def show

    @payed_hours = 5
  end

end
