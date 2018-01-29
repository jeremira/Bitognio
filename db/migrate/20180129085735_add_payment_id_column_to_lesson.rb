class AddPaymentIdColumnToLesson < ActiveRecord::Migration[5.1]
  def change
    add_reference :lessons, :payment, index: true
  end
end
