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
