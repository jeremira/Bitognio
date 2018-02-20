class Memo < ApplicationRecord
  belongs_to :teacher, class_name: 'User'
  belongs_to :postit
end
