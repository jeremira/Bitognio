class LessonsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_lesson, only: [:update, :destroy, :pay, :approve]
  before_action :set_available_teachers, only: [:new, :create, :edit]

  # GET /lessons
  # GET /lessons.json
  def index
    if current_user.is_a_teacher
      @request_lessons   = current_user.teacher_lessons.where(confirmed: false)
      @confirmed_lessons = current_user.teacher_lessons.where(confirmed: true)
    else
      @payed_lessons = current_user.student_lessons.where(payed: true)
      @not_payed_lessons = current_user.student_lessons.where(payed: false)
    end
  end

  # GET /lessons/new
  def new
    @lesson = Lesson.new
  end

  # POST /lessons
  # POST /lessons.json
  def create
    @lesson = current_user.student_lessons.build(lesson_params)
    respond_to do |format|
      if @lesson.save
        format.html { redirect_to lessons_path, notice: t('.lesson_created') }
        format.json { render :show, status: :created, location: @lesson }
      else
        format.html { flash.now[:alert] = t('.lesson_not_created') ;render :new }
        format.json { render json: @lesson.errors, status: :unprocessable_entity }
      end
    end
  end

  # POST /lessons/:id/pay
  def pay
    teacher = @lesson.teacher
    @payment =  current_user.transfer_money_to_teacher teacher, 3000
    if @payment.payment_processed
      @lesson.payed = true
      @lesson.payment_id = @payment.id
      @lesson.save
      flash[:notice] = t('.lesson_payed', teacher: teacher.email)
      redirect_to lessons_path
    else
      flash[:alert] = @payment.error_message
      redirect_to payments_path
    end
  end

  def approve
    @lesson.confirmed = true
    @lesson.save
    redirect_to lessons_path, notice: t('.lesson_confirmed')
  end

  # PATCH/PUT /lessons/1
  # PATCH/PUT /lessons/1.json
  def update
    respond_to do |format|
      if @lesson.update(lesson_params)
        format.html { redirect_to @lesson, notice: t('.lesson_updated') }
        format.json { render :show, status: :ok, location: @lesson }
      else
        format.html { render :edit }
        format.json { render json: @lesson.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /lessons/1
  # DELETE /lessons/1.json
  def destroy
    @lesson.destroy
    respond_to do |format|
      format.html { redirect_to lessons_url, notice: t('.lesson_canceled') }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_lesson
      @lesson = Lesson.find(params[:id])
    end

    def set_available_teachers
      @available_teachers = User.where(is_a_teacher: true)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def lesson_params
      params.require(:lesson).permit(:student_id, :teacher_id, :date, :time)
    end
end
