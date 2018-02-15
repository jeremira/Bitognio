class CareersController < ApplicationController
  before_action :authenticate_user!

  def index
  end

  def new
    unless current_user.is_a_teacher
      @career = current_user.build_career
    end
  end

  def create
    @career = current_user.build_career(career_params)
    if @career.save
      redirect_to current_user, notice: 'You are now a teacher !'
    else
      redirect_to current_user, notice: 'We could not create your teacher account, please try again'
    end
  end

  private

    def career_params
      params.require(:career).permit(:user_id, :last_name, :first_name, :dob, :country, :adress, :city, :zipcode, :iban)
    end

end
