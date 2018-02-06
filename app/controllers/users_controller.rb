class UsersController < ApplicationController

  before_action :authenticate_user!

  def show
    @balance = current_user.account.balance
    @payed_hours = @balance.to_i / 3000
  end

  def upgrade
    @user = current_user
  end

  def teacherupgrade
    #put method
    #update user is a teacher and account info
  end

end
