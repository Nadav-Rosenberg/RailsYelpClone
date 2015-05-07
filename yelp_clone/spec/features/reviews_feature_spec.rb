require 'rails_helper'

feature 'reviewing' do
  before {Restaurant.create name: 'KFC'}

  scenario 'allows users to leave a review using a form' do
    visit '/restaurants'
    click_link 'Review KFC'
    fill_in "Thoughts", with: "so so"
    select '3', from: 'Rating'
    click_button 'Leave Review'

    expect(current_path).to eq '/restaurants'
    expect(page).to have_content('so so')
  end

  scenario 'when parent restaurant is destroyed, child reviews are destroyed as well' do
    sign_up_for_tests
    visit '/restaurants'
    click_link 'Review KFC'
    fill_in "Thoughts", with: "so so"
    select '3', from: 'Rating'
    click_button 'Leave Review'
    click_link 'Review KFC'
    fill_in "Thoughts", with: "sagarsg"
    select '3', from: 'Rating'
    click_button 'Leave Review'
    click_link 'Delete KFC'
    expect(current_path).to eq '/restaurants'
    expect(page).not_to have_content('so so')

  end
  
end