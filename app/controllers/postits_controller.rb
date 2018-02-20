class PostitsController < ApplicationController
  before_action :authenticate_user!
  before_action :only_for_student

  def index
    @teachers = User.where(is_a_teacher: true)
    @postits = current_user.postits
    @postit = Postit.new
  end

  def create
    @postit = current_user.postits.build(postit_params)
    if @postit.save
      redirect_to postits_path, notice: 'Your new postit has been post !'
    else
      redirect_to postits_path, alert: 'Your postit could not be saved'
    end
  end

  def destroy
    @postit = Postit.find_by_id(params[:id])
    @postit.destroy
    redirect_to postits_path, notice: 'Your postit is deleted'
  end

  private
    def only_for_student
      if current_user.is_a_teacher
        redirect_to root_page, notice: 'This page is only for student'
      end
    end

    def postit_params
      params.require(:postit).permit(:body, :planning)
    end

end
