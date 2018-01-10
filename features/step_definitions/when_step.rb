After do |scenario|
  #save_and_open_page if scenario.failed?
end

Given /^I am a registered student$/ do
  visit root_path
  click_link 'Signup', match: :first
  fill_in :user_email, with: 'tomoko@cucumber.com'
  fill_in :user_password, with: 'password1234'
  fill_in :user_password_confirmation, with: 'password1234'
  click_button 'Signup', match: :first
  click_link 'Log out'
end

Given /^Tomoko is logged in$/ do
  visit root_path
  click_link 'Log in', match: :first
  fill_in :user_email, with: 'tomoko@cucumber.com'
  fill_in :user_password, with: 'password1234'
  click_button 'Log in'
end

Given /^I am logged out$/ do
  visit root_path
  click_link 'Log out', match: :first
end

Given /^I am on the home page$/ do
  visit root_path
end

Given /^I click on (.+) '(.+)'$/ do |cliker, name|
  if cliker == 'button'
    click_button name, match: :first
  elsif cliker == 'link'
    click_link name, match: :first
  else
    fail "#{cliker} is not a valid cliker"
  end
end

Given /^I fill in and submit signup form with '(.+)' and '(.+)'$/ do |email, password|
  fill_in :user_email, with: email
  fill_in :user_password, with: password
  fill_in :user_password_confirmation, with: password
  click_button 'Signup'
end

Given /^I fill in and submit log in form with '(.+)' and '(.+)'$/ do |email, password|
  fill_in :user_email, with: email
  fill_in :user_password, with: password
  click_button 'Log in'
end

Given /^I activate Selenium$/ do
  Capybara.current_driver = :selenium
end

Given /^I pay (.+) by credit card$/ do |amount|
  #mock strip chekout script
  StripeMock.start
  stripe_helper = StripeMock.create_test_helper
  stripe_token = stripe_helper.generate_card_token
  rack_test_session_wrapper = Capybara.current_session.driver
  rack_test_session_wrapper.submit(:post, payments_path(amount: amount.to_i, stripeToken: stripe_token), nil)
  StripeMock.stop

  #autofill strip popup checkout, require selenium driver
  #not fully automatic because stripe anti-bot feature and slow as hell
  #YOU need to click back during the 5 second sleep on the popup iframe
  #yeah that sucks
  #sleep 1
  #page.find_button 'Pay 3000 Yen'
  #stripe_iframe = all('iframe[name=stripe_checkout_app]').last
  #Capybara.within_frame stripe_iframe do
    #page.find_field('Email').set 'foo@bar.com'
    #page.find_field('Card number').set '4242 4242 4242 4242'
    #page.find_field('MM / YY').set '1242'
    #page.find_field('CVC').set '123'
    #sleep 5
    #find('button[type="submit"]').click
    #sleep 5
  #end
end
