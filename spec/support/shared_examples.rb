
RSpec.shared_examples "an authenticated GET action" do |action|
  it "redirect not logged in user" do
    expect(get action).to redirect_to '/users/sign_in'
  end
  it "respond with success when logged-in" do
    sign_in user
    expect(get action).to have_http_status :success
  end
end
