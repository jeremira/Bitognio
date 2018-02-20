class Postit < ApplicationRecord
  belongs_to :student, class_name: 'User'
  has_many :memos
end
