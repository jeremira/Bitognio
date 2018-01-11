Then /^The website should be displayed in (.+)$/ do |locale|
  case locale
  when 'english'
    expect(page).to have_content 'Informations'
    expect(page).to have_content 'French lessons'
    expect(page).to have_content 'Contact'
  when 'japanese'
    expect(page).to have_content '情報'
    expect(page).to have_content 'フランス語レッスン'
    expect(page).to have_content '連絡'
  end
end


When /^I click the (.+) flag$/ do |locale|
  click_link locale + '-flag'
end
