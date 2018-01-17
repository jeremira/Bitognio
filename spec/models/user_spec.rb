require 'rails_helper'

describe User  do
  let(:user)    {build :user}
  let(:student) {build :student}
  let(:teacher) {build :teacher}
  
  it "has a valid factory" do
    expect(user).to be_valid
    expect(student).to be_valid
    expect(teacher).to be_valid
  end
  it "require an email" do
    user.email = nil
    expect(user).to_not be_valid
  end
  it "require an unique email" do
    user       = create(:user, email: 'test@test.com')
    other_user =  build(:user, email: 'test@test.com')
    expect(other_user).to_not be_valid
  end
  it "can process payment" do
    expect(user).to respond_to :make_a_payment_with_stripe
  end
  it "new user is student by default" do
    expect(user.is_a_teacher).to be false
  end
end
