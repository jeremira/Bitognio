require 'rails_helper'

RSpec.describe AdminUser, type: :model do
  let(:admin) {build :admin}
  it "has a valid factory" do
    expect(admin).to be_valid
  end
  it "require an email" do
    admin.email = nil
    expect(admin).to_not be_valid
  end
  it "require an unique email" do
    admin       = create(:admin, email: 'test@test.com')
    other_admin =  build(:admin, email: 'test@test.com')
    expect(other_admin).to_not be_valid
  end
end
