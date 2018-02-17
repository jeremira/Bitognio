class User < ApplicationRecord
  has_many :payments
  has_one  :account
  has_one  :career

  has_many :student_lessons, class_name: 'Lesson', foreign_key: :student_id
  has_many :teacher_lessons, class_name: 'Lesson', foreign_key: :teacher_id

  has_many :postit, foreign_key: :student_id
  has_many :memo,   foreign_key: :teacher_id

  before_create :create_account_child

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  #Handle payment method
  include CanPay

  def create_account_child
    build_account
    true
  end

end
