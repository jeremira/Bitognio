Then /^The website should be displayed in (.+)$/ do |locale|
  case locale
  when 'english'
    expect(page).to have_content 'Informations'
    expect(page).to have_content 'Contact'
    expect(page).to have_content 'Log in'
    expect(page).to have_content 'Sign up'
  when 'japanese'
    expect(page).to have_content '情報'
    expect(page).to have_content '連絡'
    expect(page).to have_content 'ログイン'
    expect(page).to have_content 'サインアップ'
  end
end


When /^I click the (.+) flag$/ do |locale|
  click_link locale + '-flag'
end
