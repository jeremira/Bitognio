require 'rails_helper'

RSpec.describe LessonsController, type: :controller do

  let(:user)          {create :user}
  let(:teacher)       {create :teacher}
  let(:lesson)        {create :lesson, student_id: user.id, teacher_id: teacher.id}
  let(:lesson_params) { attributes_for(:lesson, teacher_id: teacher.id )}
  let(:invalid_lesson_params) { attributes_for(:lesson, teacher_id: teacher.id, date: nil)}

  describe 'GET index' do
    it_behaves_like "an authenticated GET action", :index
  end

  describe 'GET new' do
    it_behaves_like "an authenticated GET action", :new
  end

  describe 'PUT update' do
    it "redirect not log in user" do
      expect(put :update, params: {id: lesson.id, lesson: lesson_params }).to redirect_to '/users/sign_in'
    end
    it "respond with success" do
      sign_in user
      expect(put :update, params: {id: lesson.id, lesson: lesson_params }).to have_http_status 302
    end
  end

  describe 'DELETE destroy' do
    it "redirect not log in user" do
      expect(delete :destroy, params: {id: lesson.id}).to redirect_to '/users/sign_in'
    end
    it "delete a lesson record" do
      lesson.save
      sign_in user
      expect{delete :destroy, params: {id: lesson.id}}.to change(Lesson, :count).by -1
    end
  end

  describe 'POST pay' do
    it "redirect not log in user" do
      expect(post :pay, params: {id: lesson.id}).to redirect_to '/users/sign_in'
    end
    it "respond with success" do
      sign_in user
      expect(post :pay, params: {id: lesson.id}).to have_http_status 302
    end
    it "create a payment record" do
      sign_in user
      expect{post :pay, params: {id: lesson.id}}.to change(Payment, :count).by 1
    end
  end

  describe 'POST create' do
    context "with valid params" do
      before :each { sign_in user}
      it "respond with success" do
        expect(post :create, params: {lesson: lesson_params}).to have_http_status 302
      end
      it "create a new lesson record" do
        expect{post :create, params: {lesson: lesson_params}}.to change(Lesson, :count).by 1
      end
    end
    context "with invalid params" do
      before :each { sign_in user}
      it "respond with success" do
        expect(post :create, params: {lesson: invalid_lesson_params}).to have_http_status 200
      end
      it "create a new lesson record" do
        expect{post :create, params: {lesson: invalid_lesson_params}}.to_not change(Lesson, :count)
      end
    end
    context "not logged-in" do
      it "redirect to signin page" do
        expect(post :create, params: {lesson: lesson_params}).to redirect_to '/users/sign_in'
        expect{post :create, params: {lesson: lesson_params}}.to_not change(Lesson, :count)
      end
    end
  end

end
