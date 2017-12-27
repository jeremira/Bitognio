class UsersController < ApplicationController

  before_action :authenticate_user!

  def show
    @balance = current_user.account.balance
    @payed_hours = @balance.to_i / 3000
  end

end
